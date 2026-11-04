import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_endpoints.dart';

Future<List<dynamic>> ambilData() async {
  final response = await http
      .get(Uri.parse(ApiEndpoints.ambilData))
      .timeout(const Duration(seconds: 10));

  final decoded = jsonDecode(response.body);

  if (response.statusCode == 200 && decoded is List) {
    return decoded;
  }
  if (decoded is Map && decoded['message'] != null) {
    throw Exception(decoded['message']);
  }
  throw Exception('Gagal mengambil data (${response.statusCode})');
}

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = ambilData();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureData = ambilData();
    });
    await _futureData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Barang')),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada data barang'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final item = data[i];
                return ListTile(
                  title: Text(item['nama_barang'].toString()),
                  subtitle: Text(
                    '${item['kategori']} • Stok: ${item['stok']} ${item['satuan']}',
                  ),
                  trailing: Text('Rp ${item['harga_jual']}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}