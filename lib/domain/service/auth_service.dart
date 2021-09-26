import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _firebaseAuthInstance = auth.FirebaseAuth.instance;

  auth.User? get currentUser => _firebaseAuthInstance.currentUser;

  Stream<auth.User?> get authStateChanges =>
      _firebaseAuthInstance.authStateChanges();

  Future<auth.UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    var googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser?.authentication;

    var credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await auth.FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<auth.UserCredential> signInWithApple() async {
    // TODO
    return signInAnonymously();
  }

  Future<void> signOut() async {
    await _firebaseAuthInstance.signOut();
  }
}
