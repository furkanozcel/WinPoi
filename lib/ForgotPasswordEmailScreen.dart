import 'package:flutter/material.dart';

import 'ForgotPasswordScreen.dart'; // Doğrulama kodu ekranı için import

class ForgotPasswordEmailScreen extends StatefulWidget {
  @override
  _ForgotPasswordEmailScreenState createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;

  // E-posta formatını doğrulamak için regex kullanıyoruz
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _sendVerificationCode() {
    setState(() {
      _isEmailValid = _validateEmail(_emailController.text);
    });

    if (_isEmailValid) {
      // E-posta geçerliyse doğrulama kodu ekranına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
                  width: 100, height: 100),
            ),
            SizedBox(height: 20),
            Text(
              'Şifreyi Yenile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Lütfen hesabınıza bağlı olan e-posta adresinizi girin. E-posta adresinize bir doğrulama kodu gönderilecektir.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // E-posta Girişi
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-posta adresi',
                errorText: _isEmailValid
                    ? null
                    : 'Geçerli bir e-posta adresi giriniz', // Hata mesajı
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _isEmailValid = _validateEmail(value);
                });
              },
            ),
            SizedBox(height: 20),
            // Kod Gönder Butonu
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: _sendVerificationCode, // E-posta doğrulama işlemi
                child: Text('Kod Gönder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
