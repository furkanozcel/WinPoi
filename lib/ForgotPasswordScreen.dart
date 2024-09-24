import 'package:flutter/material.dart';

import 'LoginScreen.dart'; // Ana ekrana dönmek için import
import 'ResetPasswordScreen.dart'; // Şifre yenileme ekranı için import

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _codeController = TextEditingController();
  final List<TextEditingController> _codeInputControllers =
      List.generate(6, (index) => TextEditingController());
  int _remainingAttempts = 3; // Kalan deneme sayısı
  final String _correctCode = "123456"; // Doğru kodu belirliyoruz

  void _verifyCode() {
    String enteredCode =
        _codeInputControllers.map((controller) => controller.text).join();
    if (enteredCode == _correctCode) {
      // Eğer doğru kod girildiyse şifre yenileme ekranına geç
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
      );
    } else {
      // Eğer yanlış kod girildiyse
      setState(() {
        _remainingAttempts--; // Kalan hakkı azalt
      });

      if (_remainingAttempts > 0) {
        // Hatalı girişte tüm kutuları temizle ve uyarı göster
        _clearCodeInputs();
        _showSnackBar('Yanlış kod. Kalan deneme hakkı: $_remainingAttempts');
      } else {
        // Tüm haklar bittiğinde ana ekrana dön
        _showSnackBar('3 kez yanlış kod girdiniz. Ana ekrana dönüyorsunuz.');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      }
    }
  }

  void _clearCodeInputs() {
    // Tüm kutuları temizle
    for (var controller in _codeInputControllers) {
      controller.clear();
    }
    FocusScope.of(context).unfocus(); // Klavyeyi kapat
    FocusScope.of(context).requestFocus(FocusNode()); // İlk kutuya geri dön
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Anlık olarak görünsün
        behavior: SnackBarBehavior.floating, // Ekranda daha üstte görünür
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 150),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/WinPoi Logo Beyaz.png',
                width: 80, height: 80),
            const SizedBox(height: 30),
            const Text(
              'Doğrulama Kodu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lütfen e-posta adresinize gelen 6 haneli kodu giriniz.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  6, (index) => _buildCodeInputBox(context, index)),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Kod tekrar gönder fonksiyonu burada olacak
              },
              child: const Text(
                'Kodu tekrar gönder',
                style: TextStyle(
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInputBox(BuildContext context, int index) {
    return Container(
      width: 50, // Kutuların genişliği artırıldı
      height: 60, // Kutuların yüksekliği artırıldı
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: _codeInputControllers[index],
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(
              fontSize: 24, height: 1.5), // Yazılar biraz yukarı alındı
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            counterText: '', // Karakter sayısını gizle
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              if (index < 5) {
                FocusScope.of(context).nextFocus(); // Bir sonraki kutuya geç
              } else {
                FocusScope.of(context)
                    .unfocus(); // Son kutuya ulaşıldığında klavyeyi kapat
                _verifyCode(); // 6 haneli kod tamamlandığında kontrol et
              }
            }
          },
        ),
      ),
    );
  }
}
