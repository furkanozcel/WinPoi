import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // LoginScreen'i doğru import ettiğinizden emin olun
import 'SignUpScreen.dart'; // SignUpScreen'i doğru import ettiğinizden emin olun

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6600), // Turuncu arka plan rengi
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height, // Ekranın tamamını kapla
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Logo ve butonlar arasında boşluk bırak
              children: [
                // Logo ve Başlık
                Column(
                  children: [
                    const SizedBox(height: 160), // Üstte boşluk bırakmak için
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/assets/images/WinPoi Logo Turuncu.png', // Logo için image
                            width: 250, // Logo genişliği
                            height: 250, // Logo yüksekliği
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
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),

                // Butonlar kısmı
                Column(
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
                                    LoginScreen(), // Giriş ekranına yönlendirme
                              ),
                            );
                          },
                          child: const Text(
                            'Giriş yap',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
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
                                    SignUpScreen(), // Kayıt ekranına yönlendirme
                              ),
                            );
                          },
                          child: const Text(
                            'Kayıt ol',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Veya
                    const Text(
                      'veya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Google logosu ile sadece ikon
                    IconButton(
                      iconSize: 50, // Icon boyutu
                      icon: Image.asset(
                        'lib/assets/images/Goole.png', // Google logosu için icon
                      ),
                      onPressed: () {
                        // Google ile giriş işlemleri burada olacak
                      },
                    ),
                    const SizedBox(height: 5),
                    // Google logosu ile sadece ikon
                    IconButton(
                      iconSize: 50, // Icon boyutu
                      icon: Image.asset(
                        'lib/assets/images/Apple.png', // Google logosu için icon
                      ),
                      onPressed: () {
                        // Google ile giriş işlemleri burada olacak
                      },
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const SizedBox(
                        height: 40), // Altta biraz daha boşluk bırakmak için
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
