import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // Giriş ekranına yönlendirme için import

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isNewPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _doPasswordsMatch = true;

  void _resetPassword() {
    setState(() {
      // Şifrelerin boş olup olmadığını kontrol et
      _isNewPasswordValid = _newPasswordController.text.isNotEmpty;
      _isConfirmPasswordValid = _confirmPasswordController.text.isNotEmpty;

      // Şifrelerin eşleşip eşleşmediğini kontrol et
      _doPasswordsMatch =
          _newPasswordController.text == _confirmPasswordController.text;
    });

    // Eğer şifreler boş değilse ve eşleşiyorsa giriş ekranına yönlendir
    if (_isNewPasswordValid && _isConfirmPasswordValid && _doPasswordsMatch) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Yenileme'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Yeni şifrenizi giriniz',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Yeni Şifre Girişi
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre',
                  border: const OutlineInputBorder(),
                  errorText: _isNewPasswordValid
                      ? null
                      : 'Bu alanı doldurunuz', // Şifre boşsa uyarı
                ),
                onChanged: (value) {
                  setState(() {
                    _isNewPasswordValid = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Yeni Şifre Onay Girişi
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifreyi Onayla',
                  border: const OutlineInputBorder(),
                  errorText: !_isConfirmPasswordValid
                      ? 'Bu alanı doldurunuz' // Şifre onayı boşsa uyarı
                      : !_doPasswordsMatch
                          ? 'Şifreler eşleşmiyor' // Şifreler eşleşmiyorsa uyarı
                          : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _isConfirmPasswordValid = value.isNotEmpty;
                    _doPasswordsMatch = _newPasswordController.text == value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Şifreyi Yenile Butonu
              ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                ),
                child: const Text('Şifreyi Yenile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
