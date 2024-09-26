import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // LoginScreen'i doğru import ettiğinizden emin olun
import 'SignUpScreen.dart'; // SignUpScreen'i doğru import ettiğinizden emin olun

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFF6600), // Turuncu arka plan rengi
      body: SafeArea(
        child: SingleChildScrollView(
          // Kaydırma eklendi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo ve Başlık
              Column(
                mainAxisSize: MainAxisSize.min, // İçerik kadar yer kaplasın
                children: [
                  const SizedBox(height: 160), // Üstte boşluk bırakmak için
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/assets/images/WinPoi Logo Turuncu.png', // Logo
                          width: screenWidth * 0.5, // Ekranın %50 genişliğinde
                          height: screenWidth * 0.5, // Kare şeklinde
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'WinPoi',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),

              // Butonlar kısmı
              Column(
                mainAxisSize: MainAxisSize.min, // İçerik kadar yer kaplasın
                children: [
                  // Giriş yap ve Kayıt ol düğmeleri
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginScreen(), // Giriş ekranına yönlendirme
                            ),
                          );
                        },
                        child: Text(
                          'Giriş yap',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04, // Dinamik font boyutu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpScreen(), // Kayıt ekranına yönlendirme
                            ),
                          );
                        },
                        child: Text(
                          'Kayıt ol',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04, // Dinamik font boyutu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Veya
                  Text(
                    'veya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04, // Dinamik font boyutu
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Google logosu ile sadece ikon
                  IconButton(
                    iconSize: screenWidth * 0.12, // Dinamik icon boyutu
                    icon: Image.asset(
                      'lib/assets/images/Goole.png', // Google logosu için icon
                    ),
                    onPressed: () {
                      // Google ile giriş işlemleri burada olacak
                    },
                  ),
                  const SizedBox(height: 5),
                  // Apple logosu ile sadece ikon
                  IconButton(
                    iconSize: screenWidth * 0.12, // Dinamik icon boyutu
                    icon: Image.asset(
                      'lib/assets/images/Apple.png', // Apple logosu için icon
                    ),
                    onPressed: () {
                      // Apple ile giriş işlemleri burada olacak
                    },
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                      height: 50), // Altta biraz daha boşluk bırakmak için
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
