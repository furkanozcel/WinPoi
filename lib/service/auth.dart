import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Kullanıcı kayıt olma fonksiyonu
  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Kullanıcı giriş yapma fonksiyonu
  Future<void> signin({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Kullanıcı çıkış yapma fonksiyonu
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // E-posta doğrulama gönderme fonksiyonu
  Future<void> sendEmailVerification(User user) async {
    await user.sendEmailVerification();
  }

  // E-posta doğrulanmış mı kontrol etme fonksiyonu
  bool isEmailVerified(User user) {
    return user.emailVerified;
  }
}
