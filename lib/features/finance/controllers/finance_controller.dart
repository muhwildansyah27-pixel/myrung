
import '../finance_data.dart';

class FinanceController {
  List<Map<String, dynamic>> get transactions {
    return FinanceData.transactions;
  }

  List<Map<String, dynamic>> getTransactionsByType(String type) {
    if (type == 'semua') {
      return transactions;
    }

    return transactions
        .where((transaction) => transaction['type'] == type)
        .toList();
  }

  int get totalPemasukan {
    return transactions
        .where((transaction) => transaction['type'] == 'pemasukan')
        .fold<int>(
          0,
          (total, transaction) =>
              total + (transaction['amount'] as int),
        );
  }

  int get totalPengeluaran {
    return transactions
        .where((transaction) => transaction['type'] == 'pengeluaran')
        .fold<int>(
          0,
          (total, transaction) =>
              total + (transaction['amount'] as int),
        );
  }

  int get saldoBersih {
    return totalPemasukan - totalPengeluaran;
  }

  void tambahTransaksi({
    required String title,
    required String type,
    required int amount,
    required String category,
    required DateTime date,
    String note = '',
  }) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Nama transaksi tidak boleh kosong.');
    }

    if (type != 'pemasukan' && type != 'pengeluaran') {
      throw ArgumentError('Jenis transaksi tidak valid.');
    }

    if (amount <= 0) {
      throw ArgumentError('Jumlah transaksi harus lebih dari nol.');
    }

    FinanceData.transactions.insert(0, {
      'title': title.trim(),
      'type': type,
      'amount': amount,
      'category': category,
      'date': date,
      'note': note.trim(),
    });
  }
}
   