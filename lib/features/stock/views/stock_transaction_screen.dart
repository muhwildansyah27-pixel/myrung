
import 'package:flutter/material.dart';
import 'stock_success_screen.dart';

class StockTransactionScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final String type;

  const StockTransactionScreen({
    super.key,
    required this.product,
    required this.type,
  });

  @override
  State<StockTransactionScreen> createState() =>
      _StockTransactionScreenState();
}

class _StockTransactionScreenState
    extends State<StockTransactionScreen> {
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime _date = DateTime.now();

  bool get isIncoming => widget.type == 'masuk';

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null && mounted) {
      setState(() {
        _date = selected;
      });
    }
  }

  String _dateText() {
    return '${_date.day.toString().padLeft(2, '0')}/'
        '${_date.month.toString().padLeft(2, '0')}/'
        '${_date.year}';
  }

  void _save() {
    // Validasi semua input yang menggunakan Form.
    if (!_formKey.currentState!.validate()) return;

    final quantity = int.tryParse(_quantityController.text.trim());

    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Jumlah harus lebih dari 0.'),
        ),
      );
      return;
    }

    final currentStock = widget.product['stock'] as int;

    // Pastikan stok keluar tidak melebihi stok tersedia.
    if (!isIncoming && quantity > currentStock) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Stok tidak mencukupi.'),
        ),
      );
      return;
    }

    // Perbarui stok tepat satu kali.
    widget.product['stock'] = isIncoming
        ? currentStock + quantity
        : currentStock - quantity;

    // Tampilkan halaman sukses setelah transaksi berhasil.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const StockSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF1D2B4D);
    const background = Color(0xFFF7F8FA);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        foregroundColor: navy,
        title: Text(
          isIncoming ? 'Stok Masuk' : 'Stok Keluar',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: Color(0xFFE0E5EC),
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Pilih Barang'),
                TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: widget.product['name'] as String,
                  ),
                  decoration: _decoration(),
                ),
                const SizedBox(height: 18),

                _label(
                  isIncoming ? 'Jumlah Masuk' : 'Jumlah Keluar',
                ),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: _decoration(
                    hint: 'Masukkan jumlah',
                    suffix: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Center(
                        widthFactor: 1,
                        child: Text('pcs'),
                      ),
                    ),
                  ),
                  validator: (value) {
                    final quantity = int.tryParse(
                      (value ?? '').trim(),
                    );

                    if (quantity == null || quantity <= 0) {
                      return 'Masukkan jumlah yang valid';
                    }

                    return null;
                  },
                ),

                if (isIncoming) ...[
                  const SizedBox(height: 18),
                  _label('Harga Beli Satuan'),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: _decoration(
                      hint: 'Contoh: Rp 70.000',
                    ),
                  ),
                ],

                const SizedBox(height: 18),
                _label('Tanggal'),
                InkWell(
                  onTap: _chooseDate,
                  child: InputDecorator(
                    decoration: _decoration(
                      suffix: const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    child: Text(_dateText()),
                  ),
                ),

                const SizedBox(height: 18),
                _label('Catatan (opsional)'),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: _decoration(
                    hint: isIncoming
                        ? 'Contoh: Pembelian dari supplier A'
                        : 'Contoh: Barang terjual',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: _save,
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Simpan'),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF172033),
        ),
      ),
    );
  }

  InputDecoration _decoration({
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDCE4EF),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDCE4EF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF1D2B4D),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: _decoration(),
    );
  }
}
