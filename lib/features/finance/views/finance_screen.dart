
import 'package:flutter/material.dart';
import '../controllers/finance_controller.dart';
import 'transaction_form_screen.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  static const navy = Color(0xFF1D2B4D);
  static const green = Color(0xFF08B981);
  static const red = Color(0xFFFF4148);
  static const page = Color(0xFFF7F8FA);

  final FinanceController _controller = FinanceController();
  String _filter = 'semua';

  String _rupiah(int value) {
    final digits = value.toString();
    final result = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      result.write(digits[i]);

      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        result.write('.');
      }
    }

    return 'Rp $result';
  }

  String _tanggal(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _bukaForm() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const TransactionFormScreen(),
      ),
    );

    if (result == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _controller.getTransactionsByType(_filter);

    return Scaffold(
      backgroundColor: page,
      appBar: AppBar(
        backgroundColor: page,
        foregroundColor: navy,
        elevation: 0,
        title: const Text(
          'Keuangan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saldo Bersih',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _rupiah(_controller.saldoBersih),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _ringkasan(
                          'Pemasukan',
                          _rupiah(_controller.totalPemasukan),
                          Icons.trending_up_rounded,
                          green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _ringkasan(
                          'Pengeluaran',
                          _rupiah(_controller.totalPengeluaran),
                          Icons.trending_down_rounded,
                          red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Riwayat Transaksi',
                    style: TextStyle(
                      color: navy,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _bukaForm,
                  icon: const Icon(Icons.add, size: 19),
                  label: const Text('Tambah'),
                  style: TextButton.styleFrom(
                    foregroundColor: green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _filterButton('Semua', 'semua'),
                _filterButton('Pemasukan', 'pemasukan'),
                _filterButton('Pengeluaran', 'pengeluaran'),
              ],
            ),
            const SizedBox(height: 16),
            if (transactions.isEmpty)
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 42,
                      color: Color(0xFF8993A5),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada transaksi',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Transaksi akan muncul di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF8993A5)),
                    ),
                  ],
                ),
              )
            else
              ...transactions.map((transaction) {
                final isIncome = transaction['type'] == 'pemasukan';
                final amount = transaction['amount'] as int;
                final date = transaction['date'] as DateTime;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE8ECF2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isIncome
                              ? const Color(0xFFE4FAF2)
                              : const Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isIncome
                              ? Icons.south_west_rounded
                              : Icons.north_east_rounded,
                          color: isIncome ? green : red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['title'] as String,
                              style: const TextStyle(
                                color: navy,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${transaction['category']} • ${_tanggal(date)}',
                              style: const TextStyle(
                                color: Color(0xFF8993A5),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${isIncome ? '+' : '-'}${_rupiah(amount)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: isIncome ? green : red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _bukaForm,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Tambah Transaksi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton(String label, String value) {
    final selected = _filter == value;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() => _filter = value);
      },
      selectedColor: navy,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : navy,
        fontSize: 12,
      ),
      side: BorderSide(
        color: selected ? navy : const Color(0xFFE1E6EF),
      ),
      showCheckmark: false,
    );
  }

  Widget _ringkasan(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
