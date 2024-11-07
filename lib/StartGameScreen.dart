import 'package:flutter/material.dart';

import 'game.dart'; // Oyun ekranı
import 'menu_screen.dart'; // Menü ekranını ekledik

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({super.key});

  @override
  _StartGameScreenState createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Arka plan beyaz yapıldı
      // Oyun seçim ekranı
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildGameCard(
                gameTitle: 'Iphone 15 Pro Max',
                isExpanded: _isExpanded1,
                onPressedExpand: () {
                  setState(() {
                    _isExpanded1 = !_isExpanded1;
                  });
                },
                onPressedPlay: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GameScreen(gameTitle: 'Iphone 15 Pro Max'),
                    ),
                  );
                },
                description: '''
Tarih: 25 Eylül 2024
Genel Bilgi: Bu oyun Iphone 15 Pro Max kazanma şansı sunuyor.
Ödül: 1 adet Iphone 15 Pro Max
''',
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildGameCard(
                gameTitle: 'Playstation 5',
                isExpanded: _isExpanded2,
                onPressedExpand: () {
                  setState(() {
                    _isExpanded2 = !_isExpanded2;
                  });
                },
                onPressedPlay: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GameScreen(gameTitle: 'Playstation 5'),
                    ),
                  );
                },
                description: '''
Tarih: 1 Ekim 2024
Genel Bilgi: Bu oyun Playstation 5 kazanma şansı sunuyor.
Ödül: 1 adet Playstation 5
''',
              ),
            ),
          ],
        ),
      ),

      // Alt kısım (Bottom Navigation Bar)
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Alt kısım beyaz yapıldı
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset(
                'lib/images/Gift.png', // Hediye simgesi
                width: 300,
                height: 100,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard({
    required String gameTitle,
    required bool isExpanded,
    required VoidCallback onPressedExpand,
    required VoidCallback onPressedPlay,
    required String description,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 102, 0),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Kart başlığına tıklayınca genişleme olur
          ListTile(
            leading:
                const Icon(Icons.card_giftcard, color: Colors.black, size: 30),
            title: GestureDetector(
              onTap:
                  onPressedExpand, // Başlığa tıklayınca genişletme fonksiyonu çalışır
              child: Text(gameTitle, style: const TextStyle(fontSize: 18)),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 102, 0),
              ),
              onPressed: onPressedPlay, // Oyna tuşuna tıklanınca oyunu başlatır
              child: const Text('Oyna'),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}
