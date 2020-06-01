import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/authenticate.dart';
import 'package:facebook_clone/screens/newsfeed.dart';
import 'package:facebook_clone/screens/profile.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService _auth = AuthService();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu), 
          color: Colors.blue[900],
          onPressed: () =>openDrawer(context),
         
          ),
        
        title: Text(
                'Facebook',
                style: TextStyle(
                  letterSpacing: .5,
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.bold,
                  fontSize:20
                )
              ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: FlatButton(
                color: Colors.blueGrey[800],
                onPressed: (){
                }, 
                child: Text(
                  'Clone Mode',
                  style: TextStyle(
                    color:Colors.grey[200]
                  )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(60)
                ),
                ),
          )
        ],
      ),
      drawer: Drawer(
        child: _drawer()
      ),
      body: StreamProvider<CurrentUser>.value(
        value: UserDatabaseService(id:Provider.of<User>(context).id).users,
        child: StreamProvider<List<Post>>.value(
          value: PostDatabaseService(id:Provider.of<User>(context).id).posts,
          child: NewsFeed()
        ),
      ),

      
        
    );
  }

  _drawer() {
    final userId = Provider.of<User>(context).id;
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
        child:Profile(id:userId),
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

  openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

}