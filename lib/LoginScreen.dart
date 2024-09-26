import 'package:flutter/material.dart';

import 'ForgotPasswordEmailScreen.dart'; // Şifre sıfırlama ekranı için import
import 'StartGameScreen.dart'; // Oyun başlamadan önceki ekran için import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  bool _isEmailFormatValid = true; // E-posta formatı doğrulama değişkeni

  // E-posta formatını kontrol eden fonksiyon
  bool _validateEmailFormat(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _login() {
    setState(() {
      // Kullanıcı adı ve şifre boş mu kontrol et, ayrıca e-posta formatı doğru mu
      _isUsernameValid = _usernameController.text.isNotEmpty;
      _isPasswordValid = _passwordController.text.isNotEmpty;
      _isEmailFormatValid = _validateEmailFormat(_usernameController.text);
    });

    if (_isUsernameValid && _isPasswordValid && _isEmailFormatValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const StartGameScreen()), // Oyun ekranına geçiş
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Gölgeyi kaldırmak için
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context); // Geri dön
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Logo ve başlık
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/WinPoi Logo Beyaz.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tekrar hoş geldin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Kullanıcı adı/e-posta girişi
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı adı, e-posta veya cep numarası',
                  errorText: !_isUsernameValid
                      ? 'Bu alanı doldurunuz'
                      : !_isEmailFormatValid
                          ? 'Geçerli bir e-posta adresi giriniz'
                          : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: !_isUsernameValid || !_isEmailFormatValid
                          ? Colors.red
                          : Colors.grey, // Hata varsa kırmızı kenarlık
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = value.isNotEmpty;
                    _isEmailFormatValid = _validateEmailFormat(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              // Şifre girişi
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  errorText: _isPasswordValid ? null : 'Bu alanı doldurunuz',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPasswordValid ? Colors.grey : Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isPasswordValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Giriş yap yazısı
              Center(
                child: GestureDetector(
                  onTap: _login,
                  child: const Text(
                    'Giriş yap',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 450),
              // Şifreni mi unuttun yazısı
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordEmailScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Şifreni mi unuttun?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
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
