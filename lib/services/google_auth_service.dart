import 'package:google_sign_in/google_sign_in.dart';

/// A class for handling login operations using Google Sign-In.
class LoginApi {
  /// Google Sign-In instance.
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1078304320518-0tl8qu4d65qv1iu9u2grd73p9st43qqn.apps.googleusercontent.com',
  );

  /// Performs Google Sign-In.
  ///
  /// Returns a [GoogleSignInAccount] if the sign-in is successful,
  /// otherwise returns null.
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  /// Signs out the current user.
  static Future signOut() => _googleSignIn.signOut();
}
