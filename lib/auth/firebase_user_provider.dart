import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BrwPocketFirebaseUser {
  BrwPocketFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

BrwPocketFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BrwPocketFirebaseUser> brwPocketFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BrwPocketFirebaseUser>(
        (user) => currentUser = BrwPocketFirebaseUser(user));
