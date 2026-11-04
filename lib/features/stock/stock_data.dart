
import 'package:flutter/material.dart';

class StockData {
  static final List<Map<String, dynamic>> products = [
    {
      'name': 'Beras Premium 5kg',
      'stock': 25,
      'price': 75000,
      'icon': Icons.rice_bowl,
      'color': Color(0xFFE8E2D6),
    },
    {
      'name': 'Minyak Goreng 1L',
      'stock': 18,
      'price': 16000,
      'icon': Icons.water_drop_outlined,
      'color': Color(0xFFF5E7B2),
    },
    {
      'name': 'Gula Pasir 1kg',
      'stock': 12,
      'price': 14000,
      'icon': Icons.shopping_bag_outlined,
      'color': Color(0xFFF0F0F0),
    },
    {
      'name': 'Teh Celup (25s)',
      'stock': 30,
      'price': 8000,
      'icon': Icons.local_cafe_outlined,
      'color': Color(0xFFE8D9C6),
    },
    {
      'name': 'Telur Ayam (1kg)',
      'stock': 14,
      'price': 22000,
      'icon': Icons.egg_outlined,
      'color': Color(0xFFEAD8C2),
    },
  ];
}
