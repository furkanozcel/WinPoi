import 'package:flutter/material.dart';

import 'game.dart'; // Oyun ekranı
import 'menu_screen.dart'; // Menü ekranını ekledik

class StartGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Oyun seçim ekranı
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Oyun 1: Iphone 15 Pro Max
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.orange, width: 1),
              ),
              child: ListTile(
                leading:
                    Icon(Icons.card_giftcard, color: Colors.black, size: 30),
                title:
                    Text('Iphone 15 Pro Max', style: TextStyle(fontSize: 18)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
                  child: Text('Oyna'),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Oyun 2: Playstation 5
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.orange, width: 1),
              ),
              child: ListTile(
                leading:
                    Icon(Icons.card_giftcard, color: Colors.black, size: 30),
                title: Text('Playstation 5', style: TextStyle(fontSize: 18)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
                  child: Text('Oyna'),
                ),
              ),
            ),
          ),
        ],
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
