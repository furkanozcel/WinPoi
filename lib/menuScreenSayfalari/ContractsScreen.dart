import 'package:flutter/material.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sözleşmeler'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kullanıcı Sözleşmesi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bu sözleşme, kullanıcı ile uygulama arasında yapılan yasal bir anlaşmadır. Uygulamayı kullanarak bu sözleşmeyi kabul etmiş olursunuz...',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gizlilik Politikası',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kullanıcıların kişisel verileri gizli tutulacak ve üçüncü şahıslarla paylaşılmayacaktır. Gizlilik politikamızla ilgili daha fazla bilgiye...',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Veri Koruma ve Güvenlik',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Kullanıcıların verilerinin korunması ve güvenliği için uygulanan yöntemler ve alınan önlemler bu bölümde açıklanmıştır...',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hizmet Kullanım Koşulları',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bu uygulamanın sunduğu hizmetlerin kullanımı için gerekli şartlar ve kurallar burada belirtilmiştir...',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            // Kabul ve Geri Dön Butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Kullanıcı sözleşmeyi kabul ettiğinde yapılacak işlemler
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Kabul Et',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange, width: 2),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Geri dönme işlemi
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Geri Dön',
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
