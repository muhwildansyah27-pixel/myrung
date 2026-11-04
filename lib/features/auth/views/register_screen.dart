
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/register_controller.dart';
import '../../../core/widgets/warungku_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _konfirmasiController = TextEditingController();

  final _registerController = RegisterController();
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _namaController.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _konfirmasiController.dispose();
    super.dispose();
  }

  void _daftar() {
    final valid = _registerController.isValidInput(
      nama: _namaController.text,
      identifier: _identifierController.text,
      password: _passwordController.text,
      konfirmasiPassword: _konfirmasiController.text,
    );

    setState(() {
      if (_namaController.text.trim().isEmpty ||
          _identifierController.text.trim().isEmpty ||
          _passwordController.text.isEmpty ||
          _konfirmasiController.text.isEmpty) {
        _errorMessage = 'Semua kolom wajib diisi.';
      } else if (!valid) {
        _errorMessage = 'Konfirmasi password tidak cocok.';
      } else {
        _errorMessage = null;
      }
    });

    if (!valid) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data valid. Registrasi belum terhubung ke server.'),
      ),
    );
  }

  InputDecoration _decoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD9DDE5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD9DDE5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.backgroundTop),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: WarungkuLogo(),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Buat Akun',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundTop,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Mulai kelola warungmu dengan mudah',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
              const SizedBox(height: 28),

              _label('Nama Lengkap *'),
              TextField(
                controller: _namaController,
                decoration: _decoration('Masukkan nama lengkap'),
              ),
              const SizedBox(height: 16),

              _label('Nomor HP / Email *'),
              TextField(
                controller: _identifierController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration('Masukkan nomor HP atau email'),
              ),
              const SizedBox(height: 16),

              _label('Password *'),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _decoration(
                  'Minimal 8 karakter',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _label('Konfirmasi Password *'),
              TextField(
                controller: _konfirmasiController,
                obscureText: _obscurePassword,
                decoration: _decoration('Ulangi password'),
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _daftar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundTop,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Sudah punya akun? Masuk',
                    style: TextStyle(color: AppColors.backgroundTop),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
