import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proweb_presentations_web/domain/firebase/app_firebase_collections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  bool _hasAuth = false;
  bool get hasAuth => _hasAuth;

  Future<bool> googleLogIn() async {
    try {
      final curentUser = await googleSignIn.signIn();
      if (curentUser == null) return false;
      _user = curentUser;

      final googleAuth = await curentUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final admins = await AppFirebaseCollections.admins.get();

      bool _hasEmail = false;

      for (var admin in admins.docs) {
        final String? email = admin.get('email');
        if (email?.toLowerCase() == _user?.email.toLowerCase()) {
          _hasEmail = true;
        }
      }

      if (!_hasEmail) {
        _hasAuth = false;
        await setAuth(_hasAuth);
        notifyListeners();
        return false;
      }

      _hasAuth = true;
      await setAuth(_hasAuth);
      notifyListeners();
      return true;
    } catch (e) {
      _hasAuth = false;
      await setAuth(_hasAuth);
      return false;
    }
  }

  Future logOutwithGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    _hasAuth = false;
    await setAuth(_hasAuth);
  }

  Future setAuth(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('auth', value);
  }
}
