import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GameScreen extends StatefulWidget {
  final String gameTitle;
  const GameScreen({super.key, required this.gameTitle});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  // Rastgele konum oluşturucu
  final Random _random = Random();

  // Rastgele konum aralıkları (Beşiktaş semti sınırları)
  final double _minLatitude = 41.0410;
  final double _maxLatitude = 41.0530;
  final double _minLongitude = 29.0000;
  final double _maxLongitude = 29.0250;

  // Rastgele başlangıç noktası
  LatLng _currentPosition =
      const LatLng(41.043038, 29.001945); // Başlangıç noktası
  LatLng _targetPosition =
      const LatLng(41.0428, 29.0055); // Ödülün bulunduğu konum
  double _movementStep = 0.00002; // Normal hız (2 m/s)
  final double _zoomLevel = 20.0; // En yakınlaştırılmış hal
  bool _isSpeedBoostActive = false; // Hız artırma durumu
  bool _isTeleportActive = false; // Işınlanma aktif mi?
  bool _canMoveMap = false; // Harita hareket ettirilebilir mi?
  bool _isMoving = false; // Hareket tamamlanana kadar yeni tıklamayı engelle
  bool _isBirdViewActive = false; // Kuş bakışı modu aktif mi
  double _originalZoomLevel = 20.0; // Zoom seviyesi saklama

  LatLng? _teleportPosition; // Işınlanma için seçilen nokta
  bool _showTeleportConfirmButton = false; // Işınlanmayı onaylama butonu
  Color _proximityColor = Colors.transparent; // Başlangıçta şeffaf renk

  int _countdown = 15; // Geri sayım için başlangıç değeri
  bool _gameStarted = false; // Oyun başladı mı kontrolü

  @override
  void initState() {
    super.initState();
    _setRandomPositions(); // Oyuncu ve ödül için rastgele konum ayarla
    _startCountdown();
  }

  // Oyuncu ve ödül için rastgele konum ayarla
  void _setRandomPositions() {
    _currentPosition = LatLng(
      _minLatitude + _random.nextDouble() * (_maxLatitude - _minLatitude),
      _minLongitude + _random.nextDouble() * (_maxLongitude - _minLongitude),
    );
    _targetPosition = LatLng(
      _minLatitude + _random.nextDouble() * (_maxLatitude - _minLatitude),
      _minLongitude + _random.nextDouble() * (_maxLongitude - _minLongitude),
    );
  }

  // Geri sayım işlemini başlat
  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
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

  // Geri sayım için animasyonlu bir daire ve yazı
  Widget _buildCountdownWidget() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arka planda animasyonlu daire
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 100 + (_countdown * 10),
            height: 100 + (_countdown * 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.withOpacity(0.5),
            ),
          ),
          // Ortadaki büyük geri sayım rakamı
          Text(
            '$_countdown',
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
    return 12742 * asin(sqrt(a));
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
      _isBirdViewActive = true;
      _canMoveMap = false;
      _originalZoomLevel = _zoomLevel;
    });

    // Haritayı uzaklaştır (6 saniye boyunca)
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 15.0),
      ),
    );

    // 6 saniye sonra kuş bakışı modundan çık
    await Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _isBirdViewActive = false;
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
  void _activateTeleport() async {
    final GoogleMapController controller = await _controller.future;

    setState(() {
      _isTeleportActive = true;
      _canMoveMap = true;
    });

    // Haritayı uzaklaştır (ışınlanma için)
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 15.0),
      ),
    );
  }

  // Işınlanmayı onayla ve tıklanan yere ışınlan
  void _confirmTeleport(LatLng newPosition) {
    setState(() {
      _currentPosition = newPosition;
      _isTeleportActive = false;
      _canMoveMap = false;
      _showTeleportConfirmButton = false;
    });
    _checkProximity();
  }

  // Işınlanma işlemi için onay popup'ı
  Future<void> _showTeleportConfirmationDialog(LatLng position) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bu noktaya ışınlanmak istiyor musunuz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmTeleport(position);
              },
            ),
          ],
        );
      },
    );
  }

  // Hız artırma fonksiyonu
  void _activateSpeedBoost() {
    if (!_isSpeedBoostActive) {
      setState(() {
        _movementStep = 0.00008; // 8 m/s hız
        _isSpeedBoostActive = true;
      });

      // 5 saniye sonra hız normale dönecek
      Timer(const Duration(seconds: 5), () {
        setState(() {
          _movementStep = 0.00002; // 2 m/s hız
          _isSpeedBoostActive = false;
        });
      });
    }
  }

  // Çıkış ikonu için onay popup'ı
  Future<void> _showExitConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkmak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
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
        title: Text(widget.gameTitle),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: _showExitConfirmationDialog,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: _zoomLevel,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("currentPosition"),
                position: _currentPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
              ),
              Marker(
                markerId: const MarkerId("targetPosition"),
                position: _targetPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
              ),
              if (_teleportPosition != null)
                Marker(
                  markerId: const MarkerId("teleportPosition"),
                  position: _teleportPosition!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange),
                ),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: _isTeleportActive && !_isMoving
                ? (LatLng position) {
                    _showTeleportConfirmationDialog(position);
                  }
                : null,
            scrollGesturesEnabled: _canMoveMap,
            zoomGesturesEnabled: _canMoveMap,
          ),
          // Geri sayım ekranı
          if (!_gameStarted)
            Center(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: _buildCountdownWidget(),
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
                  stops: const [0.8, 1.0],
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
                    icon: const Icon(Icons.arrow_upward),
                    color: Colors.black,
                    onPressed: !_isMoving ? _moveUp : null,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: !_isMoving ? _moveLeft : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        color: Colors.black,
                        onPressed: !_isMoving ? _moveRight : null,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward),
                    color: Colors.black,
                    onPressed: !_isMoving ? _moveDown : null,
                  ),
                ],
              ),
            ),
          // Hız artırma butonu sol altta
          if (_gameStarted)
            Positioned(
              bottom: 50,
              left: 20,
              child: IconButton(
                icon: Image.asset('lib/images/Group.png'),
                iconSize: 40,
                onPressed: _activateSpeedBoost,
              ),
            ),
          // Işınlanma butonu
          if (_gameStarted)
            Positioned(
              bottom: 50,
              left: 100,
              child: IconButton(
                icon: const Icon(Icons.my_location,
                    color: Colors.purple, size: 40),
                onPressed: _activateTeleport,
              ),
            ),
          // Kuş bakışı butonu
          if (_gameStarted)
            Positioned(
              bottom: 50,
              left: 180,
              child: IconButton(
                icon: Image.asset('lib/images/kusbaskısı.png'),
                iconSize: 40,
                onPressed: _activateBirdView,
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
    _smoothMove(_currentPosition, newPosition, 20);
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
    if (_isMoving) return;

    setState(() {
      _isMoving = true;
    });

    final GoogleMapController controller = await _controller.future;

    double deltaLat = (to.latitude - from.latitude) / steps;
    double deltaLng = (to.longitude - from.longitude) / steps;

    for (int i = 0; i < steps; i++) {
      await Future.delayed(const Duration(milliseconds: 50), () {
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

    setState(() {
      _isMoving = false;
    });

    _checkProximity();
  }
}
