import 'package:flutter/material.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Geçmişi'),
      ),
      body: Center(
        child: Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
            width: 150, height: 150),
      ),
    );
  }
}
