import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher_string.dart';
import 'auth_service.dart';

/// Implementation of [AuthService] for Facebook authentication.
class FacebookAuthService extends AuthService {
  static const String clientId = '355918634156260';
  static const String authorizationUrl = 'https://www.facebook.com/v12.0/dialog/oauth';
  static const String tokenUrl = 'https://graph.facebook.com/v12.0/oauth/access_token';
  static const String userInfoUrl = 'https://graph.facebook.com/v12.0/me';

  @override
  Future<String?> getAuthorizationCode() async {
    // Construct the authorization URL with necessary parameters
    const authUrl =
        '$authorizationUrl?client_id=$clientId&response_type=token&scope=email,public_profile';

    try {
      // Attempt to launch the authorization URL in a browser
      if (await canLaunchUrlString(authUrl)) {
        await launchUrlString(authUrl);
      } else {
        throw 'Could not launch $authUrl';
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>> authenticate(String code) async {
    // This method will not be used since we're handling authentication within the app
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    // Use the access token obtained from the authentication flow to fetch user info
    final response =
        await http.get(Uri.parse('$userInfoUrl?access_token=$accessToken'));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse and return the user info from the response body
      return json.decode(response.body);
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to get user info');
    }
  }
}
