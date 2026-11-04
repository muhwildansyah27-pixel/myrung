
import 'package:flutter/material.dart';
import 'stock_transaction_screen.dart';

class DetailBarangScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const DetailBarangScreen({
    super.key,
    required this.product,
  });

  @override
  State<DetailBarangScreen> createState() => _DetailBarangScreenState();
}

class _DetailBarangScreenState extends State<DetailBarangScreen> {
  static const navy = Color(0xFF1D2B4D);

  String _formatPrice(int price) {
    final value = price.toString();
    final result = StringBuffer();

    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        result.write('.');
      }
      result.write(value[i]);
    }

    return 'Rp ${result.toString()}';
  }

  
  Future<void> _openTransaction(String type) async {
    final quantity = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) => StockTransactionScreen(
          product: widget.product,
          type: type,
        ),
      ),
    );
  
    if (quantity == null || !mounted) return;
  
    setState(() {
      final currentStock = widget.product['stock'] as int;
  
      widget.product['stock'] = type == 'masuk'
          ? currentStock + quantity
          : currentStock - quantity;
    });
  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          type == 'masuk'
              ? 'Stok berhasil ditambahkan.'
              : 'Stok berhasil dikurangi.',
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        foregroundColor: navy,
        title: const Text(
          'Detail Barang',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur edit barang akan dibuat berikutnya.'),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          const SizedBox(width: 10),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE0E5EC)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                product['icon'] as IconData,
                size: 90,
                color: const Color(0xFF8B8173),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product['name'] as String,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    'Stok Saat Ini',
                    '${product['stock']} pcs',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    'Harga Jual',
                    _formatPrice(product['price'] as int),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    'Stok Masuk',
                    Icons.arrow_upward,
                    const Color(0xFF08B981),
                    const Color(0xFFE4FAF2),
                    () => _openTransaction('masuk'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    'Stok Keluar',
                    Icons.arrow_downward,
                    const Color(0xFFFF4148),
                    const Color(0xFFFFF0F0),
                    () => _openTransaction('keluar'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Riwayat barang akan dibuat berikutnya.'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Riwayat Barang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCE4EF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String title,
    IconData icon,
    Color foreground,
    Color background,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          backgroundColor: background,
          side: BorderSide(color: foreground),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
