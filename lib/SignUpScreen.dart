import 'package:email_validator/email_validator.dart'; // E-posta doğrulama için
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth için import
import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // Giriş ekranına yönlendirme için import

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isLoading = false;
  String? _errorMessage;

  void _signUp() async {
    setState(() {
      _isEmailValid = EmailValidator.validate(_emailController.text);
      _isPasswordValid = _passwordController.text.length >= 6;
      _errorMessage = null;
    });

    if (_isEmailValid && _isPasswordValid) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Firebase Auth ile kullanıcı oluşturma
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Başarılıysa giriş ekranına yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        // Hata durumunda mesaj göster
        setState(() {
          if (e.code == 'email-already-in-use') {
            _errorMessage = 'Bu e-posta adresi zaten kayıtlı.';
          } else if (e.code == 'invalid-email') {
            _errorMessage = 'Geçersiz e-posta adresi.';
          } else if (e.code == 'weak-password') {
            _errorMessage = 'Şifre çok zayıf. En az 6 karakter olmalı.';
          } else {
            _errorMessage = e.message;
          }
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Bir hata oluştu. Lütfen tekrar deneyin.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Bellek sızıntılarını önlemek için controller'ları dispose edin
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              // Hata mesajı gösterme
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
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
              // Şifre girişi
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  errorText:
                      _isPasswordValid ? null : 'Şifre en az 6 karakter olmalı',
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
                    _isPasswordValid = value.length >= 6;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Kayıt Ol butonu
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              // Zaten hesabınız var mı? Giriş Yap
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Zaten hesabınız var mı? Giriş Yap',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
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
