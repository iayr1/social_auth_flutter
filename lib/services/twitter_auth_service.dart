import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'auth_service.dart';

/// Implementation of [AuthService] for Twitter authentication in a mobile application.
class TwitterAuthService extends AuthService {
  static const String clientId = 'ck9USm1xbGZkNndQUHhibmRLeTI6MTpjaQ';
  static const String clientSecret = '0u1K3I0mF3o7UJF7jeRSya1b0Du1PGxc15pyLiYtpwQ2wA1tlq';
  static const String redirectUri = 'http://localhost';
  static const String authorizationUrl = 'https://api.twitter.com/oauth/authenticate';
  static const String tokenUrl = 'https://api.twitter.com/oauth/access_token';
  static const String userInfoUrl = 'https://api.twitter.com/1.1/account/verify_credentials.json';

  @override
  Future<String?> getAuthorizationCode() async {
    // Twitter OAuth 1.0a authorization URL
    const authUrl = 'https://api.twitter.com/oauth/authenticate?oauth_token=1516752987405701120-UQJIgrdQiKaI020vc87Nb0JKaUOOR4';

    try {
      // Open a webview with the Twitter authorization URL
      final result = await FlutterWebAuth.authenticate(url: authUrl, callbackUrlScheme: 'http');

      // Extract the authorization code from the redirect URI
      final Uri uri = Uri.parse(result);
      final String? oauthVerifier = uri.queryParameters['oauth_verifier'];

      return oauthVerifier;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> authenticate(String code) async {
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
      },
      body: {
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      final accessToken = json.decode(response.body)['access_token'];
      return await getUserInfo(accessToken);
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse(userInfoUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user info');
    }
  }
}
