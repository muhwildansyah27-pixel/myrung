import 'package:flutter/material.dart';
// import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/warungku_logo.dart';
import '../../stock/views/stock_screen.dart';
import '../../finance/views/finance_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const navy = Color(0xFF1D2B4D);
  static const page = Color(0xFFF7F8FA);
  static const green = Color(0xFF08B981);
  static const red = Color(0xFFFF4148);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: page,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 28, height: 28, child: WarungkuLogo()),
                  const SizedBox(width: 20),
                  const Expanded(
                    child: Text(
                      'Warung Maju Jaya',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: navy,
                      ),
                    ),
                  ),
                  _iconButton(Icons.settings_outlined),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang,',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8993A5),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Halo, Pemilik Warung!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: navy,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Selasa, 21 Mei 2024',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF596780),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _iconButton(Icons.notifications_none_rounded),
                ],
              ),
              const SizedBox(height: 30),
              const _SectionTitle('Ringkasan Hari Ini'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _financeCard(
                      'Pemasukan',
                      'Rp 1.250.000',
                      Icons.trending_up_rounded,
                      const Color(0xFFE4FAF2),
                      green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _financeCard(
                      'Pengeluaran',
                      'Rp 650.000',
                      Icons.trending_down_rounded,
                      const Color(0xFFFFF0F0),
                      red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Row(
                  children: [
                    _IconTile(
                      icon: Icons.account_balance_wallet_outlined,
                      background: Color(0xFF394967),
                      foreground: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Keuntungan Bersih',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Text(
                      'Rp 600.000',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              const _SectionTitle('Status Inventaris'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _inventoryCard(
                      'Total Stok',
                      '128',
                      'Item',
                      Icons.inventory_2_outlined,
                      const Color(0xFFEDF1F6),
                      navy,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _inventoryCard(
                      'Stok Tipis',
                      '8',
                      'Item',
                      Icons.warning_amber_rounded,
                      const Color(0xFFFFF0F0),
                      red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              const _SectionTitle('Menu Utama'),
              const SizedBox(height: 22),
              Row(
                children: [
                  _menu(
                  Icons.inventory_2_outlined,
                  'Kelola Stok',
                  const Color(0xFFEDF1F6),
                  navy,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StockScreen(),
                      ),
                    );
                  },
                ),
                  _menu(
                    Icons.account_balance_wallet_outlined,
                    'Keuangan',
                    const Color(0xFFE4FAF2),
                    green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FinanceScreen(),
                        ),
                      );
                    },
                  ),
                  _menu(
                    Icons.receipt_long_outlined,
                    'Laporan',
                    const Color(0xFFFFF2C9),
                    const Color(0xFFF59E0B),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E7EF)),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: navy, size: 22),
    );
  }

  static Widget _financeCard(
    String title,
    String value,
    IconData icon,
    Color background,
    Color foreground,
  ) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconTile(
            icon: icon,
            background: foreground,
            foreground: Colors.white,
            size: 28,
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF8792A5), fontSize: 12),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _inventoryCard(
    String title,
    String value,
    String unit,
    IconData icon,
    Color background,
    Color foreground,
  ) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E6EF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF8993A5),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: foreground,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8993A5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          _IconTile(
            icon: icon,
            background: background,
            foreground: foreground,
            size: 36,
          ),
        ],
      ),
    );
  }

  
  static Widget _menu(
    IconData icon,
    String title,
    Color background,
    Color foreground, {
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            _IconTile(
              icon: icon,
              background: background,
              foreground: foreground,
              size: 52,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: navy,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: DashboardScreen.navy,
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color foreground;
  final double size;

  const _IconTile({
    required this.icon,
    required this.background,
    required this.foreground,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Icon(icon, color: foreground, size: size * 0.55),
    );
  }
}
