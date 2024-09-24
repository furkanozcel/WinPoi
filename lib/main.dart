import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'SignUpScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      body: Column(
        children: [
          // Üstte siyah bir boşluk bırak
          Container(
            color: Colors.black, // Siyah renk
            height: MediaQuery.of(context)
                .padding
                .top, // Cihazın güvenli alanına göre dinamik boşluk
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/WinPoi Logo Turuncu.png',
                    width: 200,
                    height: 200,
                  ), // Logo için image
                  Text(
                    'WinPoi',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen()), // Giriş ekranına geçiş
                      );
                    },
                    child: Text('Giriş yap',
                        style: TextStyle(color: Color.fromARGB(255, 12, 5, 0))),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpScreen()), // Kayıt ekranına geçiş
                      );
                    },
                    child: Text('Kayıt ol',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 7, 4, 0))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
