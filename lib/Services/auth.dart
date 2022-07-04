

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/Models/user.dart';
import 'package:firebase_tutorial/Services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ModelUser _userFromFireBase(User user) {
    return ModelUser(user.uid);
  }

  Stream<ModelUser?> get user {
    return _auth.authStateChanges()
        .map((event) {
      return ModelUser(event!.uid);
    });
  }

  ModelUser get currentUser{
    var result = _auth.currentUser;
    return _userFromFireBase(result!);
  }

  Future signInAnonymous() async {
    try {
      var result = await _auth.signInAnonymously(); // var as UserCredential
      var user = result.user; // var as User
      if(user != null) return _userFromFireBase(user);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      var user = result.user;
      if(user != null) return _userFromFireBase(user);
      return null;
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future registerEmailPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = result.user;
      if(user != null) {
        await DatabaseService(user.uid).createCollectionInUser();
        return _userFromFireBase(user);
      }
      return null;
    } catch(e) {
      print(e);
      return null;
    }
  }

}