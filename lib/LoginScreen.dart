import 'package:flutter/material.dart';

import 'ForgotPasswordScreen.dart'; // Güvenlik kodu ekranı için import
import 'StartGameScreen.dart'; // Oyun başlamadan önceki ekran için import

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isUsernameValid = true;
  bool _isPasswordValid = true;

  void _login() {
    setState(() {
      // Boş olup olmadığını kontrol et
      _isUsernameValid = _usernameController.text.isNotEmpty;
      _isPasswordValid = _passwordController.text.isNotEmpty;
    });

    // Eğer her iki alan da doluysa girişe izin ver
    if (_isUsernameValid && _isPasswordValid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartGameScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.orange),
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
              'Tekrar hoş geldin',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Kullanıcı Adı / E-Posta Girişi
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı adı, e-posta veya cep numarası',
                errorText: _isUsernameValid
                    ? null
                    : 'Bu alanı doldurunuz', // Hata mesajı
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isUsernameValid
                        ? Colors.grey
                        : Colors.red, // Kırmızı kenarlık
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isUsernameValid =
                      value.isNotEmpty; // Doldurulursa kırmızılık kalksın
                });
              },
            ),
            SizedBox(height: 20),
            // Şifre Girişi
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Şifre',
                errorText: _isPasswordValid
                    ? null
                    : 'Bu alanı doldurunuz', // Hata mesajı
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isPasswordValid
                        ? Colors.grey
                        : Colors.red, // Kırmızı kenarlık
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isPasswordValid =
                      value.isNotEmpty; // Doldurulursa kırmızılık kalksın
                });
              },
            ),
            SizedBox(height: 20),
            // Giriş Yap Butonu
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: _login, // Giriş işlemi
                child: Text('Giriş yap'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ForgotPasswordScreen()), // Güvenlik kodu ekranına yönlendirme
                  );
                },
                child: Text(
                  'Şifreni mi unuttun?',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
