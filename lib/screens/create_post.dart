import 'package:facebook_clone/constants/constants.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class CreatePost extends StatelessWidget {

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation:0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.blue[900],
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.replay)
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.grey,
          onPressed: (){
            if (textController.text.isNotEmpty){
              posts.add(Post(text:textController.text, likes: 0, id:'10', userName: 'Dummy', time: DateTime.now()));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
            }
          },
          icon: Icon(Icons.send)
          )
        ],
      ),
      body: Material(
        color: Colors.white,
        child: _postView(context)
      ),
    );
  }

  _postView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      height: height,
      width: width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.amber
              ),
              Container(
                width: width * .7,
                height: 200,
                child: TextField(
                  controller: textController,
                  maxLines: 20,
                  decoration: postDecoration.copyWith(
                    hintText: 'Write something...'
                  )
                )
              )
            ],
          ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: (){},
                iconSize: 40,
                color: Colors.grey,
                )
            ],
          ),

        ],)
    );
  }
}