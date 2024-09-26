import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FaqItem> _faqItems = [
    FaqItem(
        question: "Nasıl kayıt olabilirim?",
        answer:
            "Kayıt olabilmek için anasayfadaki 'Kayıt Ol' butonuna tıklayarak adımları izleyebilirsiniz."),
    FaqItem(
        question: "Şifremi unuttum, ne yapmalıyım?",
        answer:
            "Şifrenizi unuttuysanız, giriş sayfasındaki 'Şifremi Unuttum' bağlantısına tıklayarak şifrenizi sıfırlayabilirsiniz."),
    FaqItem(
        question: "Uygulamada nasıl ödeme yapabilirim?",
        answer:
            "Ödeme yöntemleri sayfasından kredi kartı bilgilerinizi ekleyebilir ve ödeme yapabilirsiniz."),
    FaqItem(
        question: "Destek ile nasıl iletişime geçebilirim?",
        answer:
            "Bize ulaşın sayfasından müşteri destek ekibimize mesaj gönderebilirsiniz."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSS'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _faqItems.length,
          itemBuilder: (context, index) {
            return _buildFaqItem(_faqItems[index]);
          },
        ),
      ),
    );
  }

  // Her SSS maddesini genişleyebilir bir kartta göstermek için fonksiyon
  Widget _buildFaqItem(FaqItem item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ExpansionTile(
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(
          item.question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        iconColor: Colors.orange,
        children: [
          Text(
            item.answer,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// SSS maddesi için model sınıf
class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
