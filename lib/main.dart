import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:proweb_presentations_web/ui/app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDVzH9Cg4CWxQe1UTTjSY5VBZFTYwKaLNw",
      authDomain: "proweb-presentations-web.firebaseapp.com",
      projectId: "proweb-presentations-web",
      storageBucket: "proweb-presentations-web.appspot.com",
      messagingSenderId: "231413448039",
      appId: "1:231413448039:web:57fa9a0e19816b9a8043c2",
    ),
  );

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 1919);

  runApp(const MyApp());

}
