abstract class AuthService {
  Future<String?> getAuthorizationCode() async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> authenticate(String code) async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    throw UnimplementedError();
  }
}