
import 'package:flutter/material.dart';
import '../stock_data.dart';

class TambahBarangScreen extends StatefulWidget {
  const TambahBarangScreen({super.key});

  @override
  State<TambahBarangScreen> createState() =>
      _TambahBarangScreenState();
}

class _TambahBarangScreenState
    extends State<TambahBarangScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final _satuanController = TextEditingController(text: 'pcs');

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    _satuanController.dispose();
    super.dispose();
  }

  void _simpanBarang() {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text.trim();
    final harga = int.parse(_hargaController.text);
    final stok = int.parse(_stokController.text);
    final satuan = _satuanController.text.trim();

    StockData.products.add({
      'name': nama,
      'price': harga,
      'stock': stok,
      'unit': satuan,
      'icon': Icons.inventory_2_outlined,
      'color': const Color(0xFFE8E2D6),
    });

    Navigator.pop(context, true);
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    required String pesan,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D2B4D),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: pesan,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label wajib diisi';
            }

            if (keyboardType == TextInputType.number) {
              final angka = int.tryParse(value);
              if (angka == null || angka < 0) {
                return '$label harus berupa angka minimal 0';
              }
            }

            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Tambah Barang'),
        backgroundColor: const Color(0xFFF7F8FA),
        foregroundColor: const Color(0xFF1D2B4D),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _input(
                label: 'Nama Barang',
                controller: _namaController,
                pesan: 'Contoh: Beras Premium 5kg',
              ),
              const SizedBox(height: 18),
              _input(
                label: 'Harga Barang (Rp)',
                controller: _hargaController,
                pesan: 'Masukkan harga barang',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 18),
              _input(
                label: 'Stok Awal',
                controller: _stokController,
                pesan: 'Masukkan jumlah stok',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 18),
              _input(
                label: 'Satuan',
                controller: _satuanController,
                pesan: 'Contoh: pcs, kg, liter',
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _simpanBarang,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D2B4D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Simpan Barang'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
