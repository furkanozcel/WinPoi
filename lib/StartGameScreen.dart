import 'package:flutter/material.dart';

import 'game.dart'; // Oyun ekranı
import 'menu_screen.dart'; // Menü ekranını ekledik

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 102, 0),
      // Oyun seçim ekranı
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Oyun 1: Iphone 15 Pro Max
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 255, 102, 0), width: 1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.card_giftcard,
                      color: Colors.black, size: 30),
                  title: const Text('Iphone 15 Pro Max',
                      style: TextStyle(fontSize: 18)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 102, 0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(gameTitle: 'Iphone 15 Pro Max'),
                        ), // GameScreen'e oyun başlığı ile geçiş
                      );
                    },
                    child: const Text('Oyna'),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 250),

            // Oyun 2: Playstation 5
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                      color: Color.fromRGBO(255, 255, 102, 1), width: 1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.card_giftcard,
                      color: Colors.black, size: 30),
                  title: const Text('Playstation 5',
                      style: TextStyle(fontSize: 18)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 102, 0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(gameTitle: 'Playstation 5'),
                        ), // GameScreen'e oyun başlığı ile geçiş
                      );
                    },
                    child: const Text('Oyna'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Altında sadece menüye gitme işlevi
      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          icon: Image.asset(
            'lib/assets/images/Gift.png', // Ayarlar simgesi
            width: 700,
            height: 700,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuScreen()), // Menü ekranına geçiş
            );
          },
        ),
      ),
    );
  }
}
