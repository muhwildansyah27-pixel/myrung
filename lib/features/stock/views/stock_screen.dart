
import 'package:flutter/material.dart';
import 'detail_barang_screen.dart';
import '../stock_data.dart';
import 'tambah_barang_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> get _products => StockData.products;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products.where((product) {
      return product['name']
          .toString()
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 19),
          color: const Color(0xFF1D2942),
        ),
        title: const Text(
          'Kelola Stok',
          style: TextStyle(
            color: Color(0xFF172033),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah Barang',
            onPressed: () async {
              final berhasil = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => const TambahBarangScreen(),
                ),
              );

              if (berhasil == true && mounted) {
                setState(() {});
              }
            },
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE0E5EC)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari barang...',
                hintStyle: const TextStyle(
                  color: Color(0xFF8290A5),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF64748B),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCE4EF),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(
                    color: Color(0xFFDCE4EF),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: const BorderSide(
                    color: Color(0xFF1D2B4D),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
              itemCount: filteredProducts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBarangScreen(
                          product: product,
                        ),
                      ),
                    );

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFDCE4EF),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: product['color'] as Color,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(
                            product['icon'] as IconData,
                            color: const Color(0xFF8B8173),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF172033),
                                ),
                              ),
                              const SizedBox(height: 5),
                              
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Stok: ${product['stock']} pcs',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: (product['stock'] as int) == 0
                                            ? const Color(0xFFFF4148)
                                            : const Color(0xFF718096),
                                      ),
                                    ),
                                  ),
                                  if ((product['stock'] as int) == 0) ...[
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Color(0xFFFF4148),
                                      size: 15,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatPrice(product['price'] as int),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2B4D),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _NavItem(this.icon, this.label, this.selected);

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFF164BFF)
        : const Color(0xFF9AA4B5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
