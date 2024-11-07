import 'package:flutter/material.dart';
import 'package:winpoipo/main.dart'; // main.dart dosyasını import edin

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Arka plan rengi hafif gri
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.orange, // Profil ekranı için özel renk
        elevation: 0, // AppBar'a gölge eklenmesini önlüyor
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Profil Fotoğrafı
            Center(
              child: Stack(
                children: [
                  // Siyah çerçeve eklemek için CircleAvatar'ı Container içine alıyoruz
                  Container(
                    width:
                        130, // Çerçeve boyutu (profil fotoğrafı artı dış sınır)
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black, // Siyah çerçeve rengi
                        width: 3.0, // Çerçeve kalınlığı
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60, // Profil fotoğrafı boyutu
                      backgroundImage:
                          const AssetImage('lib/images/WinPoi Logo Beyaz.png'),
                      backgroundColor:
                          Colors.grey[200], // Profil fotoğrafı arka plan rengi
                    ),
                  ),
                  // Düzenleme butonu (profil fotoğrafı değiştirme)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.white, size: 18),
                        onPressed: () {
                          // Profil fotoğrafı değiştirme işlevi
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Kullanıcı adı ve e-posta bilgileri, kart şeklinde tasarım
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Kullanıcı Adı',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'user@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Profil Bilgilerini Düzenle Butonu
            _buildProfileButton(
              icon: Icons.person,
              text: 'Profil Bilgilerini Düzenle',
              onPressed: () {
                // Profil düzenleme işlevi
              },
            ),
            // Şifre Değiştir Butonu
            _buildProfileButton(
              icon: Icons.lock,
              text: 'Şifre Değiştir',
              onPressed: () {
                // Şifre değiştirme işlevi
              },
            ),
            // Bildirim Ayarları Butonu
            _buildProfileButton(
              icon: Icons.notifications,
              text: 'Bildirim Ayarları',
              onPressed: () {
                // Bildirim ayarları işlevi
              },
            ),
            const SizedBox(height: 20),
            // Çıkış Yap Butonu
            _buildProfileButton(
              icon: Icons.exit_to_app,
              text: 'Çıkış Yap',
              color: Colors.redAccent,
              onPressed: () {
                // Çıkış yapma işlevi - main.dart dosyasına yönlendirir
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyApp(), // main.dart içindeki MyApp ana widget'ına yönlendirir
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Profil ekranında kullanılan butonları oluşturan yardımcı fonksiyon
  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.orange,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white, size: 24),
        label: Text(text, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
          backgroundColor: color,
          elevation: 5, // Hafif bir gölge
          shadowColor: Colors.black45, // Gölgenin rengi
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Yuvarlatılmış kenarlar
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
