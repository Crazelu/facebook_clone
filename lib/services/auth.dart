import 'package:facebook_clone/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Auth stream for determining whether user is signed in or not
  Stream<User> get user{
   return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  //Convert FirebaseUser object to custom User object
  User userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(id: user.uid) : null;
  }

  //Sign in with email and password
  Future signIn(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  //register
  Future register(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    }
    catch (e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}