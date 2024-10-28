import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // Singleton instance of GoogleSignIn
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar', // Scope for accessing Google Calendar
    ],
  );

  /// Sign in and return the current Google user
  static Future<GoogleSignInAccount?> login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      return user;
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  /// Retrieve the currently signed-in user without prompting for sign-in
  static Future<GoogleSignInAccount?> getCurrentUser() async {
    return _googleSignIn.currentUser;
  }

  /// Sign out the current user
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
