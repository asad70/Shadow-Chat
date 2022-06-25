import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ShadowChatFirebaseUser {
  ShadowChatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ShadowChatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ShadowChatFirebaseUser> shadowChatFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ShadowChatFirebaseUser>(
            (user) => currentUser = ShadowChatFirebaseUser(user));
