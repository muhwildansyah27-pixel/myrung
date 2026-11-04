
class FinanceData {
  static final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Penjualan',
      'type': 'pemasukan',
      'amount': 150000,
      'category': 'Penjualan',
      'date': DateTime(2024, 5, 21, 10, 30),
      'note': 'Penjualan hari ini',
    },
    {
      'title': 'Penjualan',
      'type': 'pemasukan',
      'amount': 250000,
      'category': 'Penjualan',
      'date': DateTime(2024, 5, 21, 12, 15),
      'note': '',
    },
    {
      'title': 'Pembelian Barang',
      'type': 'pengeluaran',
      'amount': 120000,
      'category': 'Pembelian Barang',
      'date': DateTime(2024, 5, 21, 9, 20),
      'note': 'Belanja stok warung',
    },
  ];
}
