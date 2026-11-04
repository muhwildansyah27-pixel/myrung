import 'package:flutter/material.dart';
import 'features/auth/views/login_screen.dart';
import 'features/splash/views/splash_screen.dart';
import 'features/dashboard/views/dashboard_screen.dart';

void main() {
  runApp(const WarungKuApp());
}

class WarungKuApp extends StatelessWidget {
  const WarungKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WarungKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Segoe UI'),
      home: const DashboardScreen(),
    );
  }
}
