import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCEhem7uFpJqH2ApKyLQ3faeTr6O-bWR0w",
            authDomain: "sports-buddy-ijd63m.firebaseapp.com",
            projectId: "sports-buddy-ijd63m",
            storageBucket: "sports-buddy-ijd63m.firebasestorage.app",
            messagingSenderId: "595826050936",
            appId: "1:595826050936:web:2ae51d09075d5cc1a36a8d",
            measurementId: "G-HBZGJJTC8S"));
  } else {
    await Firebase.initializeApp();
  }
}
