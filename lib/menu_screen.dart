import 'package:flutter/material.dart';

import 'ContactUsScreen.dart'; // Bize ulaşın sayfasını import ediyoruz

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Sol üst köşedeki geri gitme işaretini kaldırıyoruz
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // Beyaz logo burada kullanıldı
              child: Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
                  width: 80, height: 80),
            ),
            SizedBox(height: 20),
            _buildMenuItem(Icons.person, 'Profil'),
            _buildMenuItem(Icons.payment, 'Ödeme yöntemi'),
            _buildMenuItem(Icons.history, 'Oyun geçmişi'),
            _buildMenuItem(Icons.help_outline, 'SSS'),
            _buildMenuItem(Icons.article, 'Sözleşmeler'),
            _buildMenuItem(Icons.contact_mail, 'Bize ulaşın', context),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Çıkış yap butonuna basınca geri dön
              },
              child: Text(
                'Çıkış yap',
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
            ),
          ],
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
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(text),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange, width: 1),
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
