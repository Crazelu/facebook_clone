import 'package:facebook_clone/screens/sign_in.dart';
import 'package:facebook_clone/screens/sign_up.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleView);
    }
    return SignUp(toggleView: toggleView);
  }
}