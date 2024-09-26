import 'package:email_validator/email_validator.dart'; // E-posta doğrulama için ekledik
import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // Giriş ekranına yönlendirme için import

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;

  void _signUp() {
    setState(() {
      _isEmailValid = EmailValidator.validate(_emailController.text);
      _isUsernameValid = _usernameController.text.isNotEmpty;
      _isPasswordValid = _passwordController.text.isNotEmpty;
    });

    if (_isEmailValid && _isUsernameValid && _isPasswordValid) {
      // Eğer tüm alanlar doğruysa giriş ekranına yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
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
              Center(
                  child: Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
                      width: 100, height: 100)),
              const SizedBox(height: 20),
              const Text('Hoş geldin',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              // E-posta adresi girişi
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-posta adresi',
                  errorText: _isEmailValid ? null : 'Geçerli bir e-posta girin',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isEmailValid
                          ? Colors.grey
                          : Colors.red, // Hata durumunda kırmızı kenarlık
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = EmailValidator.validate(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              // Kullanıcı adı girişi
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Kullanıcı adı',
                  errorText:
                      _isUsernameValid ? null : 'Bu alan boş bırakılamaz',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isUsernameValid
                          ? Colors.grey
                          : Colors.red, // Hata durumunda kırmızı kenarlık
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = value.isNotEmpty;
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
                  errorText:
                      _isPasswordValid ? null : 'Bu alan boş bırakılamaz',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _isPasswordValid
                          ? Colors.grey
                          : Colors.red, // Hata durumunda kırmızı kenarlık
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
              // Tıklanabilir metin
              Center(
                child: GestureDetector(
                  onTap: _signUp,
                  child: const Text(
                    'Devam',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
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
