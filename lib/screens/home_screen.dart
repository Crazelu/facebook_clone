import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/navigation/navigation_animation/animations.dart';
import 'package:facebook_clone/screens/drawer.dart';
import 'package:facebook_clone/screens/newsfeed.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool isForward;
  HomeScreen({this.isForward});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
                'Facebook',
                style: TextStyle(
                  letterSpacing: .2,
                  color: Colors.blue[700],
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
        child:StreamProvider<CurrentUser>.value(
        value: UserDatabaseService(id:Provider.of<User>(context).id).users,
        child: AppDrawer()
        )
      ),
      body: StreamProvider<CurrentUser>.value(
        value: UserDatabaseService(id:Provider.of<User>(context).id).users,
        child: StreamProvider<List<Post>>.value(
          value: PostDatabaseService(id:Provider.of<User>(context).id).posts,
          child: widget.isForward ? ForwardAnimation(child: NewsFeed()) : BackwardAnimation(child: NewsFeed())
        ),
      ),



    );
  }

}