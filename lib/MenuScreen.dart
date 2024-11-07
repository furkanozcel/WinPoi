import 'package:flutter/material.dart';

import 'ContactUsScreen.dart'; // Bize ulaşın sayfasını import ediyoruz
import 'menuScreenSayfalari/ContractsScreen.dart'; // Sözleşmeler sayfasını import ediyoruz
import 'menuScreenSayfalari/FAQScreen.dart'; // SSS sayfasını import ediyoruz
import 'menuScreenSayfalari/GameHistoryScreen.dart'; // Oyun geçmişi sayfasını import ediyoruz
import 'menuScreenSayfalari/PaymentScreen.dart'; // Ödeme yöntemi sayfasını import ediyoruz
import 'menuScreenSayfalari/ProfileScreen.dart'; // Profil sayfasını import ediyoruz

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null, // Sol üst köşedeki geri gitme işaretini kaldırıyoruz
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 170),
              Center(
                // Beyaz logo burada kullanıldı
                child: Image.asset('lib/images/WinPoi Logo Beyaz.png',
                    width: 80, height: 80),
              ),
              const SizedBox(height: 40),
              _buildMenuItem(
                  Icons.person, 'Profil', context, const ProfileScreen()),
              _buildMenuItem(Icons.payment, 'Ödeme yöntemi', context,
                  const PaymentScreen()),
              _buildMenuItem(Icons.history, 'Oyun geçmişi', context,
                  const GameHistoryScreen()),
              _buildMenuItem(
                  Icons.help_outline, 'SSS', context, const FAQScreen()),
              _buildMenuItem(Icons.article, 'Sözleşmeler', context,
                  const ContractsScreen()),
              _buildMenuItem(Icons.contact_mail, 'Bize ulaşın', context,
                  const ContactUsScreen()),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Çıkış yap butonuna basınca geri dön
                },
                child: const Text(
                  'Çıkış yap',
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),

      // Alt kısım (BottomAppBar) beyaz yapıldı
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Alt çubuk arka planı beyaz yapıldı
        child: IconButton(
          icon: Image.asset(
            'lib/images/Setting.png', // Kullanıcıdan alınan görsel burada kullanıldı
            width: 700,
            height: 700,
          ),
          onPressed: () {
            Navigator.pop(context); // Geri butonu yerine bu işlev kullanıldı
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String text, BuildContext context, Widget targetScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(text),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
      ),
    );
  }
}
