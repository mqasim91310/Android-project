import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Current User ───────────────────────────────────────────────────────────
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ─── SIGN UP ────────────────────────────────────────────────────────────────
  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Firebase Auth mein account banayein
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        // Display name set karein
        await user.updateDisplayName(name.trim());

        // Firestore mein user ka data save karein
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'naam': name.trim(),
          'email': email.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return null; // null = success, koi error nahi
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e.code);
    } catch (e) {
      return 'Kuch ghalat hua. Dobara koshish karein.';
    }
  }

  // ─── SIGN IN ────────────────────────────────────────────────────────────────
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null; // null = success
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e.code);
    } catch (e) {
      return 'Kuch ghalat hua. Dobara koshish karein.';
    }
  }

  // ─── SIGN OUT ───────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ─── PASSWORD RESET ─────────────────────────────────────────────────────────
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return _getErrorMessage(e.code);
    }
  }

  // ─── Error Messages (Urdu mein) ─────────────────────────────────────────────
  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Yeh email pehle se registered hai.';
      case 'invalid-email':
        return 'Email sahi nahi hai.';
      case 'weak-password':
        return 'Password kamzor hai — 6 harf se zyada likhein.';
      case 'user-not-found':
        return 'Yeh email registered nahi hai.';
      case 'wrong-password':
        return 'Password galat hai.';
      case 'too-many-requests':
        return 'Zyada koshishein — thodi der baad try karein.';
      case 'network-request-failed':
        return 'Internet connection check karein.';
      default:
        return 'Kuch ghalat hua ($code). Dobara koshish karein.';
    }
  }
}