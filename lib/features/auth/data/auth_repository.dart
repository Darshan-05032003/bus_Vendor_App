import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vendor_app/features/auth/domain/vendor_user.dart';
import 'package:vendor_app/core/services/local_storage.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LocalStorageService _localStorage;

  AuthRepository(this._localStorage);

  //--Helper to convert Fireabase User to our Domain User--
  VendorUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return VendorUser(
      uid: user.uid,
      email: user.email,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
    );
  }

  //--listen to auth state changes--
  Stream<VendorUser?> get authStateChanges =>
      _auth.authStateChanges().map(_mapFirebaseUser);

  //--1.Google Sign-In-
  Future<VendorUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _goggleSignIn.signIn();
      if (googleUser == null) return null; //user canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credentail(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final 
    } catch (e) {}
  }
}
