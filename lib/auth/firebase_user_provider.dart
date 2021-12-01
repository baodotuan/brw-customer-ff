import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BrwCustomerFirebaseUser {
  BrwCustomerFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

BrwCustomerFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BrwCustomerFirebaseUser> brwCustomerFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<BrwCustomerFirebaseUser>(
        (user) => currentUser = BrwCustomerFirebaseUser(user));
