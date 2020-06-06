
import 'package:facebook_clone/navigation/navigation_animation/animations.dart';
import 'package:facebook_clone/screens/authenticate.dart';
import 'package:flutter/material.dart';

class Navigation{

///Navigates from a base screen to another screen with backward animation
pushFrom(BuildContext context, Widget child){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> BackwardAnimation(child:child)));
}

///Navigates from a base screen to another screen with forward animation
pushTo(BuildContext context, Widget child){
  Navigator.push(context, MaterialPageRoute(builder: (_)=> ForwardAnimation(child:child)));
}

///Navigates from a base screen to another screen with forward animation and with replacement
pushToAndReplace(BuildContext context, Widget child){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> ForwardAnimation(child:child)));
}

///Navigates from a base screen to former screen with backward animation
//popFrom(BuildContext context){
//  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> BackwardAnimation(child:_lastScreen)));
//}

///Exits application
pop(BuildContext context){

}

goToLanding(BuildContext context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> BackwardAnimation(child:Authenticate())));

}

}