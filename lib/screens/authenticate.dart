import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/home_screen.dart';
import 'package:facebook_clone/screens/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return LandingPage();
    }
    return HomeScreen();
  }
}