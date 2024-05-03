import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/facebook_auth_service.dart';
import '../services/google_auth_service.dart';
import '../services/twitter_auth_service.dart';
import 'home_screen.dart';

/// Screen for user login.
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthService _facebookAuthService = FacebookAuthService();
  final AuthService _twitterAuthService = TwitterAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'iStreet Technology',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const ScenicBackground(),
          const WaterEffect(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 320), // Move "Login" higher
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64, // Increased font size
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Increased spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      onPressed: () => _performGoogleAuthentication(context),
                      icon: 'assets/images/google.png',
                    ),
                    const SizedBox(width: 20),
                    _buildSocialButton(
                      onPressed: () => _performFacebookAuthentication(context),
                      icon: 'assets/images/facebook.png',
                      backgroundColor: Colors.blue.shade800,
                    ),
                    const SizedBox(width: 20),
                    _buildSocialButton(
                      onPressed: () => _performTwitterAuthentication(context),
                      icon: 'assets/images/x.png',
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Initiates Google authentication process.
  Future<void> _performGoogleAuthentication(BuildContext context) async {
    try {
      // Perform Google authentication with Login API
      var user = await LoginApi.login();
      if (user != null) {
        final userInfo = <String, dynamic>{
          'name': user.displayName ?? '',
          'email': user.email ?? '',
        };
        _navigateToHomeScreen(context, userInfo);
      }
    } catch (e) {
      debugPrint('Google authentication error: $e');
    }
  }

  /// Initiates Facebook authentication process.
  Future<void> _performFacebookAuthentication(BuildContext context) async {
    try {
      // Perform Facebook authentication
      final String? code = await _facebookAuthService.getAuthorizationCode();
      if (code != null) {
        final userInfo = await _facebookAuthService.authenticate(code);
        _navigateToHomeScreen(context, userInfo);
      }
    } catch (e) {
      debugPrint('Facebook authentication error: $e');
    }
  }

  /// Initiates Twitter authentication process.
  Future<void> _performTwitterAuthentication(BuildContext context) async {
    try {
      // Perform Twitter authentication
      final String? code = await _twitterAuthService.getAuthorizationCode();
      if (code != null) {
        final userInfo = await _twitterAuthService.authenticate(code);
        _navigateToHomeScreen(context, userInfo);
      }
    } catch (e) {
      debugPrint('Twitter authentication error: $e');
    }
  }

  /// Navigates to the home screen with user information.
  void _navigateToHomeScreen(BuildContext context, Map<String, dynamic> userInfo) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(userInfo: userInfo, userEmail: null),
      ),
    );
  }

  /// Builds a social login button.
  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String icon,
    Color backgroundColor = Colors.white,
    double iconSize = 100, // Specify default icon size
  }) {
    return Positioned(
      bottom: 20, // Adjust button position
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        elevation: 5,
        child: Image.asset(
          icon,
          width: iconSize,
          height: iconSize,
        ),
      ),
    );
  }
}

/// Widget for the scenic background.
class ScenicBackground extends StatelessWidget {
  const ScenicBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green.shade200, Colors.green.shade400], // Gradient background
        ),
      ),
    );
  }
}

/// Widget for the water effect.
class WaterEffect extends StatelessWidget {
  const WaterEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
      painter: WaterPainter(),
    );
  }
}

/// Custom painter for the water effect.
class WaterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.5) // Adjust opacity for water effect
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..lineTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.4, size.width, size.height * 0.5)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Draw fish
    final Paint fishPaint = Paint()
      ..color = Colors.orange // Fish color
      ..style = PaintingStyle.fill;

    const double fishWidth = 30;
    const double fishHeight = 20;

    final Path fishPath = Path()
      ..moveTo(size.width * 0.1, size.height * 0.6)
      ..lineTo(size.width * 0.1 + fishWidth, size.height * 0.6 - fishHeight / 2)
      ..lineTo(size.width * 0.1 + fishWidth, size.height * 0.6 + fishHeight / 2)
      ..close();

    canvas.drawPath(fishPath, fishPaint);

    final Path secondFishPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.7)
      ..lineTo(size.width * 0.3 + fishWidth, size.height * 0.7 - fishHeight / 2)
      ..lineTo(size.width * 0.3 + fishWidth, size.height * 0.7 + fishHeight / 2)
      ..close();

    canvas.drawPath(secondFishPath, fishPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
