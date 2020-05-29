import 'package:facebook_clone/constants/constants.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/new_post.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

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
        value: UserDatabaseService().users,
          child: NewPost(id:widget.id)
              );
  }

  

}