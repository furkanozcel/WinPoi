import 'package:flutter/material.dart';

import 'ContactUsScreen.dart'; // Bize ulaşın sayfasını import ediyoruz

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
              SizedBox(height: 170),
              Center(
                // Beyaz logo burada kullanıldı
                child: Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
                    width: 80, height: 80),
              ),
              const SizedBox(height: 40),
              _buildMenuItem(Icons.person, 'Profil'),
              _buildMenuItem(Icons.payment, 'Ödeme yöntemi'),
              _buildMenuItem(Icons.history, 'Oyun geçmişi'),
              _buildMenuItem(Icons.help_outline, 'SSS'),
              _buildMenuItem(Icons.article, 'Sözleşmeler'),
              _buildMenuItem(Icons.contact_mail, 'Bize ulaşın', context),
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

      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          icon: Image.asset(
            'lib/assets/images/Setting.png', // Kullanıcıdan alınan görsel burada kullanıldı
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

  Widget _buildMenuItem(IconData icon, String text, [BuildContext? context]) {
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
          if (text == 'Bize ulaşın' && context != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsScreen()),
            );
          } else {
            // Diğer menü öğeleri için işlevler burada eklenebilir
          }
        },
      ),
    );
  }
}
