import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/authenticate.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Facebook Clone',
        home:Authenticate(),
      ),
    );
  }
}
