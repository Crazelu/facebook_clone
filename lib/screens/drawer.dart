import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/authenticate.dart';
import 'package:facebook_clone/screens/profile.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userId = Provider.of<User>(context).id;
    final currentUser = Provider.of<CurrentUser>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(vertical:20, horizontal:20),
        color: Colors.white24,
        width: width * .4,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> 
                StreamProvider<CurrentUser>.value(
        initialData: CurrentUser(),
        value: UserDatabaseService(id:userId).users,
        child:Profile(id:userId, currentUser: currentUser),
        )
        ));
              },
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize:22,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            SizedBox(height:20),
            InkWell(
              onTap: (){ 
                _auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=> Authenticate()));
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize:22,
                  fontWeight: FontWeight.bold
                )
              )
            ),

          ],)
      ),
    );
  }
}