import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GameScreen extends StatefulWidget {
  final String gameTitle; // Oyun başlığı alıyoruz
  GameScreen({required this.gameTitle}); // Constructor

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPosition = LatLng(41.043038, 29.001945); // Başlangıç noktası
  LatLng _targetPosition = LatLng(41.0428, 29.0055); // Ödülün bulunduğu konum
  double _movementStep = 0.00002; // Normal hız (2 m/s)
  double _zoomLevel = 20.0; // En yakınlaştırılmış hal
  bool _isSpeedBoostActive = false; // Hız artırma durumu
  bool _isTeleportActive = false; // Işınlanma aktif mi?
  bool _canMoveMap = false; // Harita hareket ettirilebilir mi?

  LatLng? _teleportPosition; // Işınlanma için seçilen nokta
  bool _showTeleportConfirmButton = false; // Işınlanmayı onaylama butonu
  Color _proximityColor = Colors.transparent; // Başlangıçta şeffaf renk

  int _countdown = 15; // Geri sayım için başlangıç değeri
  bool _gameStarted = false; // Oyun başladı mı kontrolü
  bool _isBirdViewActive = false; // Kuş bakışı aktif mi?
  double _originalZoomLevel = 20.0; // Orijinal yakınlaştırma seviyesi

  @override
  void initState() {
    super.initState();
    _startCountdown(); // Geri sayımı başlat
  }

  // Geri sayım işlemini başlat
  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        setState(() {
          _gameStarted = true; // Oyun başlasın
        });
        timer.cancel();
      }
    });
  }

  // Mesafeyi hesaplayan fonksiyon
  double _calculateDistance(LatLng start, LatLng end) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((end.latitude - start.latitude) * p) / 2 +
        cos(start.latitude * p) *
            cos(end.latitude * p) *
            (1 - cos((end.longitude - start.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a)); // Mesafe kilometre cinsinden
  }

  // Oyuncunun ödüle yaklaşma durumunu kontrol eden fonksiyon
  void _checkProximity() {
    double distance = _calculateDistance(_currentPosition, _targetPosition);
    if (distance < 0.05) {
      setState(() {
        _proximityColor = Colors.red.withOpacity(0.5); // Sıcak (Kırmızı)
      });
    } else if (distance < 0.1) {
      setState(() {
        _proximityColor = Colors.orange.withOpacity(0.5); // Ilık (Turuncu)
      });
    } else {
      setState(() {
        _proximityColor = Colors.blue.withOpacity(0.5); // Soğuk (Mavi)
      });
    }
  }

  // Kuş bakışı modunu aktif hale getir
  void _activateBirdView() async {
    final GoogleMapController controller = await _controller.future;

    setState(() {
      _isBirdViewActive = true; // Kuş bakışı aktif
      _canMoveMap = false; // Hareket edemeyecek
      _originalZoomLevel = _zoomLevel; // Şu anki zoom seviyesini sakla
    });

    // Haritayı uzaklaştır (10 saniye boyunca)
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 15.0), // Uzaklaştır
      ),
    );

    // 10 saniye sonra kuş bakışı modundan çık
    await Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _isBirdViewActive = false; // Kuş bakışı modu sona erdi
      });

      // Eski yakınlaştırma seviyesine geri dön
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition, zoom: _originalZoomLevel),
        ),
      );
    });
  }

  // Işınlanma modunu aktif hale getir
  void _activateTeleport() {
    setState(() {
      _isTeleportActive = true; // Işınlanma aktif
      _canMoveMap = true; // Harita serbestçe hareket ettirilebilir
    });
  }

  // Işınlanmayı onayla
  void _confirmTeleport() {
    if (_teleportPosition != null) {
      setState(() {
        _currentPosition = _teleportPosition!; // Seçilen konuma ışınlan
        _isTeleportActive = false; // Işınlanma modu kapatıldı
        _canMoveMap = false; // Harita tekrar kilitlendi
        _showTeleportConfirmButton = false; // Onay butonu gizlendi
      });
      _checkProximity(); // Sıcak-soğuk efektini tekrar çalıştır
    }
  }

  // Hız artırma fonksiyonu (5 saniye boyunca hız artacak)
  void _activateSpeedBoost() {
    if (!_isSpeedBoostActive) {
      setState(() {
        _movementStep = 0.00008; // 8 m/s hız
        _isSpeedBoostActive = true; // Hız artırma aktif
      });

      // 5 saniye sonra hız normale dönecek
      Timer(Duration(seconds: 5), () {
        setState(() {
          _movementStep = 0.00002; // Hız normale dönüyor (2 m/s)
          _isSpeedBoostActive = false; // Hız artırma bitiyor
        });
      });
    }
  }

  // Çıkış ikonu için onay popup'ı
  Future<void> _showExitConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Kullanıcı dışına tıklayarak kapatamaz
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Çıkmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat ve oyuna devam et
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.pop(context); // Oyundan çık ve menüye dön
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameTitle), // Oyun başlığı üst kısımda gösteriliyor
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: _showExitConfirmationDialog, // Çıkış onay popup'ı
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: _zoomLevel, // Yakınlaştırma seviyesi
            ),
            markers: {
              Marker(
                markerId: MarkerId("currentPosition"),
                position: _currentPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue), // Oyuncu konumu
              ),
              Marker(
                markerId: MarkerId("targetPosition"),
                position: _targetPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen), // Ödül konumu
              ),
              if (_teleportPosition != null)
                Marker(
                  markerId: MarkerId("teleportPosition"),
                  position: _teleportPosition!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange), // Işınlanma hedefi
                ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: _isTeleportActive
                ? (LatLng position) {
                    setState(() {
                      _teleportPosition = position; // Tıklanan konumu kaydet
                      _showTeleportConfirmButton = true; // Onay butonunu göster
                    });
                  }
                : null, // Sadece ışınlanma modunda aktif
            scrollGesturesEnabled: _canMoveMap, // Haritayı kaydırabilme
            zoomGesturesEnabled: _canMoveMap, // Zoom yapabilme
          ),
          // Geri sayım ekranı (oyun başlamadan önce)
          if (!_gameStarted)
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Text(
                  'Oyun $_countdown saniye sonra başlayacak...',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          // Sıcak-soğuk efektleri
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0, 0.0),
                  radius: 0.5,
                  colors: [Colors.transparent, _proximityColor],
                  stops: [0.8, 1.0],
                ),
              ),
            ),
          ),
          // Hareket kontrol butonları
          if (_gameStarted)
            Positioned(
              bottom: 50,
              right: 20,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_upward),
                    color: Colors.black,
                    onPressed: _moveUp,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: _moveLeft,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        color: Colors.black,
                        onPressed: _moveRight,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    color: Colors.black,
                    onPressed: _moveDown,
                  ),
                ],
              ),
            ),
          // Hız artırma butonu sol altta
          if (_gameStarted)
            Positioned(
              bottom: 50, // Yerden yükseklik
              left: 20, // Soldan uzaklık (sol alt köşeye yerleşecek)
              child: IconButton(
                icon: Image.asset(
                    'lib/assets/images/Group.png'), // Hız artırma ikonu
                iconSize: 40,
                onPressed: _activateSpeedBoost, // Hız artırma fonksiyonu
              ),
            ),
          // Işınlanma butonu (sol altta)
          if (_gameStarted)
            Positioned(
              bottom: 50, // Yerden yükseklik
              left: 100, // Soldan uzaklık
              child: IconButton(
                icon: Icon(Icons.my_location, color: Colors.purple, size: 40),
                onPressed: _activateTeleport, // Işınlanma modunu aktif et
              ),
            ),
          // Kuş bakışı butonu (sağ alt köşe)
          if (_gameStarted)
            Positioned(
              bottom: 50, // Yerden yükseklik
              right: 100, // Sağdan uzaklık
              child: IconButton(
                icon: Image.asset(
                    'lib/assets/images/kusbaskısı.png'), // Kuş bakışı ikonu
                iconSize: 40,
                onPressed: _activateBirdView, // Kuş bakışı fonksiyonu
              ),
            ),
          // Işınlanmayı onayla butonu
          if (_showTeleportConfirmButton)
            //Furkan Özçelik ve Halil Eren Pabuçcu
            Positioned(
              bottom: 150,
              right: 20,
              child: ElevatedButton(
                child: Text("Işınlanmayı Onayla"),
                onPressed: _confirmTeleport,
              ),
            ),
        ],
      ),
    );
  }

  // Hareket fonksiyonları
  void _moveUp() {
    LatLng newPosition = LatLng(
        _currentPosition.latitude + _movementStep, _currentPosition.longitude);
    _smoothMove(_currentPosition, newPosition, 20); // 20 adımda kayarak gitme
  }

  void _moveDown() {
    LatLng newPosition = LatLng(
        _currentPosition.latitude - _movementStep, _currentPosition.longitude);
    _smoothMove(_currentPosition, newPosition, 20);
  }

  void _moveLeft() {
    LatLng newPosition = LatLng(
        _currentPosition.latitude, _currentPosition.longitude - _movementStep);
    _smoothMove(_currentPosition, newPosition, 20);
  }

  void _moveRight() {
    LatLng newPosition = LatLng(
        _currentPosition.latitude, _currentPosition.longitude + _movementStep);
    _smoothMove(_currentPosition, newPosition, 20);
  }

  // Haritayı kayarak hareket ettir
  Future<void> _smoothMove(LatLng from, LatLng to, int steps) async {
    final GoogleMapController controller = await _controller.future;

    double deltaLat = (to.latitude - from.latitude) / steps;
    double deltaLng = (to.longitude - from.longitude) / steps;

    for (int i = 0; i < steps; i++) {
      await Future.delayed(Duration(milliseconds: 50), () {
        double newLat = from.latitude + deltaLat * i;
        double newLng = from.longitude + deltaLng * i;
        LatLng newPosition = LatLng(newLat, newLng);

        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newPosition,
              zoom: _zoomLevel,
            ),
          ),
        );
        setState(() {
          _currentPosition = newPosition;
        });
      });
    }

    // Yaklaşma efektini kontrol et
    _checkProximity();
  }
}
