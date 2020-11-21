import 'package:firebase_auth/firebase_auth.dart';

class authclass {

  FirebaseAuth _auth = FirebaseAuth.instance;
//stream provider
  Stream<User> get sreamuser {
    return _auth.authStateChanges().map((event) => event);
  }
//signing out
  Future signout() async {
    await _auth.signOut();
  }
//signing out
  Future signin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.message);
      }
    }
  }
//registration
  Future signup(String email, String password) async {
    try {
      UserCredential usercredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = usercredential.user;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (err.code == 'weak-password') {
        print('The password provided is too weak.');
      } else {
        print(err.code);
      }
    }
  }
}
