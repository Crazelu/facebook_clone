import 'package:facebook_clone/screens/home_screen.dart';
import 'package:facebook_clone/screens/sign_in.dart';
import 'package:facebook_clone/screens/sign_up.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool showSignIn = true;
  bool showSignUp =false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      height: height,
      width: width,
      child: Column(
        children: [
        showSignIn ?  SignIn() : SignUp(),
        SizedBox(height:20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _button(showSignIn, _signIn, 'Sign in'),
            _button(showSignUp, _register, 'Register')
          ],)
        ]
      ),
    );
  }

  _button(bool isSignIn, Function pressed, String text){
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: 50,
      width: isSignIn ? width * .45 : width *.3,
      child: RaisedButton(
        color: isSignIn ? Colors.lightBlueAccent : Colors.blueGrey[900],
        onPressed: pressed,
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16
          )
          ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
        )
    );
  }

  void _signIn(){
    if (showSignIn){
      //Implement sign in auth and actions
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    }
    else
    setState(() {
      showSignIn = !showSignIn;
      showSignUp = !showSignUp;
    });
    
  }
  void _register(){
    if(!showSignIn){
      //Implement register auth and actions
    }
    else
    setState(() {
      showSignIn = !showSignIn;
      showSignUp = !showSignUp;
    });
  }
}