import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Yöntemi'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mevcut Kartlar',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Mevcut Kartlar Listesi
            Expanded(
              child: ListView(
                children: [
                  _buildCreditCardItem(
                      'Alışveriş Kartı', '**** **** **** 1234', '12/23'),
                  _buildCreditCardItem(
                      'Kişisel Kart', '**** **** **** 5678', '05/24'),
                  // Diğer mevcut kartlar burada gösterilecek
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Yeni Kart Ekleme Butonu
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Yeni kart ekleme sayfasına yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewCardScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Yeni Kart Ekle'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mevcut kredi kartı görünümü
  Widget _buildCreditCardItem(
      String cardName, String cardNumber, String expiryDate) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.credit_card, color: Colors.orange),
        title: Text(cardName), // Kart ismi
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cardNumber),
            Text('Son Kullanma Tarihi: $expiryDate'),
          ],
        ),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }
}

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  // Yeni Kart Ekleme Formu için kontroller
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  void dispose() {
    // Bellek sızıntılarını önlemek için dispose ediyoruz
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Kart Ekle'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Kart Bilgileri',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Kart İsmi Giriş Alanı
              _buildTextField(
                controller: _cardNameController,
                labelText: 'Kart İsmi',
                hintText: 'Alışveriş Kartı, Kişisel Kart vb.',
              ),
              const SizedBox(height: 10),
              // Kart Numarası Giriş Alanı
              _buildTextField(
                controller: _cardNumberController,
                labelText: 'Kart Numarası',
                hintText: '1234 5678 9012 3456',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      labelText: 'Son Kullanma Tarihi',
                      hintText: 'AA/YY',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _cvvController,
                      labelText: 'CVV',
                      hintText: '123',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _cardHolderController,
                labelText: 'Kart Sahibi',
                hintText: 'Ad Soyad',
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Yeni kart eklendiğinde önceki ekrana geri dön
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Kartı Ekle',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TextField için yardımcı fonksiyon
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
