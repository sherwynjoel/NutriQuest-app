import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider extends ChangeNotifier {

  AuthProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _clearError();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;

      if (_user != null) {
        await _createUserProfile();
      }

      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Sign in failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<void> _createUserProfile() async {
    if (_user == null) return;

    try {
      final userDoc = await _firestore.collection('users').doc(_user!.uid).get();
      
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(_user!.uid).set({
          'uid': _user!.uid,
          'email': _user!.email,
          'displayName': _user!.displayName,
          'photoURL': _user!.photoURL,
          'totalXP': 0,
          'level': 1,
          'badges': [],
          'streak': 0,
          'lastActive': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Update last active
        await _firestore.collection('users').doc(_user!.uid).update({
          'lastActive': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error creating user profile: $e');
    }
  }

  Future<void> signOut() async {
    try {
      _setLoading(true);
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      _user = null;
      _setLoading(false);
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
