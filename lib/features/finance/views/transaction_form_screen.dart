
import 'package:flutter/material.dart';
import '../controllers/finance_controller.dart';

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key});

  @override
  State<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  static const navy = Color(0xFF1D2B4D);
  static const green = Color(0xFF08B981);
  static const red = Color(0xFFFF4148);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final FinanceController _controller = FinanceController();

  String _type = 'pemasukan';
  String _category = 'Penjualan';
  DateTime _date = DateTime.now();

  final Map<String, List<String>> _categories = {
    'pemasukan': [
      'Penjualan',
      'Pendapatan Lain',
      'Modal',
    ],
    'pengeluaran': [
      'Pembelian Barang',
      'Operasional',
      'Transportasi',
      'Lainnya',
    ],
  };

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null && mounted) {
      setState(() => _date = selected);
    }
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final amount = int.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominal harus lebih dari nol.'),
        ),
      );
      return;
    }

    try {
      _controller.tambahTransaksi(
        title: _titleController.text,
        type: _type,
        amount: amount,
        category: _category,
        date: _date,
        note: _noteController.text,
      );

      Navigator.pop(context, true);
    } on ArgumentError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message.toString())),
      );
    }
  }

  String _tanggalText() {
    return '${_date.day.toString().padLeft(2, '0')}/'
        '${_date.month.toString().padLeft(2, '0')}/'
        '${_date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final color = _type == 'pemasukan' ? green : red;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF7F8FA),
        foregroundColor: navy,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Jenis Transaksi',
              style: TextStyle(
                color: navy,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _typeButton(
                    'Pemasukan',
                    'pemasukan',
                    green,
                    Icons.trending_up_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _typeButton(
                    'Pengeluaran',
                    'pengeluaran',
                    red,
                    Icons.trending_down_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _label('Nama Transaksi'),
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration(
                'Contoh: Penjualan beras',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama transaksi wajib diisi.';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _label('Nominal (Rupiah)'),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('Contoh: 150000'),
              validator: (value) {
                final amount = int.tryParse(value?.trim() ?? '');

                if (amount == null || amount <= 0) {
                  return 'Masukkan nominal yang valid.';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            _label('Kategori'),
            DropdownButtonFormField<String>(
              value: _category,
              isExpanded: true,
              decoration: _inputDecoration('Pilih kategori'),
              items: _categories[_type]!
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => _category = value);
              },
            ),
            const SizedBox(height: 18),
            _label('Tanggal Transaksi'),
            InkWell(
              onTap: _pilihTanggal,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: _inputDecoration('Pilih tanggal'),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 19,
                      color: navy,
                    ),
                    const SizedBox(width: 10),
                    Text(_tanggalText()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            _label('Catatan (Opsional)'),
            TextFormField(
              controller: _noteController,
              maxLines: 3,
              decoration: _inputDecoration(
                'Tambahkan catatan jika diperlukan',
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan Transaksi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeButton(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    final selected = _type == value;

    return InkWell(
      onTap: () {
        setState(() {
          _type = value;
          _category = _categories[value]!.first;
        });
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.10) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : const Color(0xFFE1E6EF),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
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
          color: navy,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE1E6EF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE1E6EF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: navy, width: 1.5),
      ),
    );
  }
}
