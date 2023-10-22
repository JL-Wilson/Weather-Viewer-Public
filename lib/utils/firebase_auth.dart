import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static signOut() {
    FirebaseAuth.instance.signOut();
  }
}
