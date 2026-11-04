

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

import '../controllers/login_controller.dart';
import 'register_screen.dart';



class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});



  @override

  State<LoginScreen> createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController =

      TextEditingController();



  final TextEditingController _passwordController =

      TextEditingController();



  final LoginController _loginController = LoginController();

      String? _errorMessage;



  bool _obscurePassword = true;

  bool _rememberMe = true;



  @override

  void dispose() {

    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: LayoutBuilder(

          builder: (context, constraints) {

            return SingleChildScrollView(

              padding: const EdgeInsets.symmetric(

                horizontal: 24,

                vertical: 24,

              ),

              child: ConstrainedBox(

                constraints: BoxConstraints(

                  minHeight: constraints.maxHeight - 48,

                ),

                child: IntrinsicHeight(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [

                      const SizedBox(height: 20),



                      // Logo aplikasi

                      Center(

                        child: Container(

                          width: 48,

                          height: 48,

                          decoration: BoxDecoration(

                            color: AppColors.backgroundTop,

                            borderRadius: BorderRadius.circular(13),

                          ),

                          child: const Icon(

                            Icons.storefront_rounded,

                            color: Colors.white,

                            size: 29,

                          ),

                        ),

                      ),



                      const SizedBox(height: 25),



                      const Text(

                        'Masuk',

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 28,

                          fontWeight: FontWeight.bold,

                          color: Color(0xFF141B2D),

                        ),

                      ),



                      const SizedBox(height: 25),



                      const Text(

                        'Kelola stok dan keuangan warung dengan mudah',

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 14,

                          color: Color(0xFF454545),

                        ),

                      ),



                      const SizedBox(height: 25),



                      _buildLabel('Nomor HP / Email'),



                      const SizedBox(height: 8),



                      TextField(

                        controller: _emailController,

                        keyboardType: TextInputType.emailAddress,

                        onChanged: (_) {
                          if (_errorMessage != null) {
                            setState(() {
                              _errorMessage = null;
                            });
                          }
                        },

                        decoration: _inputDecoration(

                          hint: 'Contoh: 08123456789 / budi@email.com',

                        ),

                      ),



                      const SizedBox(height: 18),



                      _buildLabel('Password'),



                      const SizedBox(height: 8),



                      TextField(

                        controller: _passwordController,

                        obscureText: _obscurePassword,

                        decoration: _inputDecoration(

                          hint: 'Masukkan password',

                        ).copyWith(

                          suffixIcon: IconButton(

                            onPressed: () {

                              setState(() {

                                _obscurePassword = !_obscurePassword;

                              });

                            },

                            icon: Icon(

                              _obscurePassword

                                  ? Icons.visibility_off_outlined

                                  : Icons.visibility_outlined,

                              color: const Color(0xFF718096),

                            ),

                          ),

                        ),

                      ),



                      if (_errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],

                      const SizedBox(height: 10),

                      Row(
                        children: [

                          SizedBox(

                            width: 24,

                            height: 24,

                            child: Checkbox(

                              value: _rememberMe,

                              activeColor: AppColors.backgroundTop,

                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(5),

                              ),

                              onChanged: (value) {

                                setState(() {

                                  _rememberMe = value ?? false;

                                });

                              },

                            ),

                          ),



                          const SizedBox(width: 8),



                          const Text(

                            'Ingat saya',

                            style: TextStyle(fontSize: 14),

                          ),



                          const Spacer(),



                          TextButton(

                            onPressed: () {

                              // Fitur lupa password dibuat nanti.

                            },

                            style: TextButton.styleFrom(

                              padding: EdgeInsets.zero,

                              minimumSize: const Size(0, 36),

                              tapTargetSize:

                                  MaterialTapTargetSize.shrinkWrap,

                            ),

                            child: const Text(

                              'Lupa password?',

                              style: TextStyle(

                                color: Color(0xFF1A2949),

                                fontWeight: FontWeight.w600,

                                fontSize: 13,

                              ),

                            ),

                          ),

                        ],

                      ),



                      const Spacer(),



                      const SizedBox(height: 40),



                      SizedBox(

                        height: 52,

                        child: ElevatedButton(

                          onPressed: () {
                            final isValid = _loginController.isValidInput(
                              identifier: _emailController.text,
                              password: _passwordController.text,
                            );

                            setState(() {
                              _errorMessage = isValid
                                  ? null
                                  : 'Nomor HP/email dan password wajib diisi.';
                            });

                            if (!isValid) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Input valid. Login ke server belum dihubungkan.',
                                ),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(

                            backgroundColor: AppColors.backgroundTop,

                            foregroundColor: Colors.white,

                            elevation: 2,

                            shape: RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(16),

                            ),

                          ),

                          child: const Text(

                            'Masuk',

                            style: TextStyle(

                              fontSize: 16,

                              fontWeight: FontWeight.w600,

                            ),

                          ),

                        ),

                      ),



                      const SizedBox(height: 12),



                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          const Text(

                            'Belum punya akun? ',

                            style: TextStyle(

                              color: Color(0xFF718096),

                              fontSize: 14,

                            ),

                          ),



                          TextButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },

                            style: TextButton.styleFrom(

                              padding: EdgeInsets.zero,

                              minimumSize: const Size(0, 36),

                              tapTargetSize:

                                  MaterialTapTargetSize.shrinkWrap,

                            ),

                            child: const Text(

                              'Daftar',

                              style: TextStyle(

                                color: Color(0xFF1A2949),

                                fontSize: 14,

                                fontWeight: FontWeight.w600,

                              ),

                            ),

                          ),

                        ],

                      ),



                      const SizedBox(height: 10),

                    ],

                  ),

                ),

              ),

            );

          },

        ),

      ),

    );

  }



  Widget _buildLabel(String text) {

    return Text.rich(

      TextSpan(

        text: text,

        style: const TextStyle(

          fontSize: 13,

          fontWeight: FontWeight.w500,

          color: Color(0xFF141B2D),

        ),

        children: const [

          TextSpan(

            text: ' \*',

            style: TextStyle(color: Colors.red),

          ),

        ],

      ),

    );

  }



  InputDecoration _inputDecoration({required String hint}) {

    return InputDecoration(

      hintText: hint,

      hintStyle: const TextStyle(

        color: Color(0xFF718096),

        fontSize: 13,

      ),

      filled: true,

      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(

        horizontal: 15,

        vertical: 17,

      ),

      border: OutlineInputBorder(

        borderRadius: BorderRadius.circular(13),

        borderSide: const BorderSide(

          color: Color(0xFFE0E6EF),

        ),

      ),

      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(13),

        borderSide: const BorderSide(

          color: Color(0xFFE0E6EF),

        ),

      ),

      focusedBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(13),

        borderSide: const BorderSide(

          color: Color(0xFF1A2949),

          width: 1.5,

        ),

      ),

    );

  }

}
