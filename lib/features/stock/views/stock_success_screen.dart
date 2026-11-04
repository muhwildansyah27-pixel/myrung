
import 'package:flutter/material.dart';
import 'stock_screen.dart';

class StockSuccessScreen extends StatelessWidget {
  const StockSuccessScreen({super.key});

  static const navy = Color(0xFF1D2B4D);
  static const background = Color(0xFFF7F8FA);
  static const green = Color(0xFF08B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 4),

            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xFFE4FAF2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 52,
                color: green,
              ),
            ),

            const SizedBox(height: 26),

            const Text(
              'Berhasil!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Data telah disimpan.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF718096),
              ),
            ),

            const Spacer(flex: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StockScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Daftar Barang',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
