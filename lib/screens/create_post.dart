import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/screens/new_post.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {

 final String id;
  CreatePost({this.id});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {


  @override
  Widget build(BuildContext context) {
     
    return StreamProvider<CurrentUser>.value(
      initialData: CurrentUser(),
        value: UserDatabaseService(id:widget.id).users,
          child: NewPost(id:widget.id)
              );
  }

  

}