import 'package:facebook_clone/constants/constants.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'home_screen.dart';

class CreatePost extends StatefulWidget {

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController textController = TextEditingController();
  File _image;
  final DateTime _time = DateTime.now();

  Future getImage(bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

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
    return SingleChildScrollView(
      child: Container(
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
                  height: height *.3,
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
                  onPressed: (){
                    _bottomSheet(context, height, width);
                  },
                  iconSize: 40,
                  color: Colors.grey,
                  )
              ],
            ),
            _image == null ? Container():
            Container(
              height: height * .4,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(_image)
                  )
              ),
            )
          ],)
      ),
    );
  }

   _bottomSheet(BuildContext context, double height, double width){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_){
        return Container(
          width: width,
          height: height*.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera),
                iconSize: 50,
                onPressed: (){
                  getImage(true);
                  Navigator.pop(context);
                }
                ),
                SizedBox(width:120),
              IconButton(
                icon: Icon(Icons.add_photo_alternate),
                iconSize: 50,
                onPressed: (){
                  getImage(false);
                  Navigator.pop(context);
                }
                ),
            ],
          ),
          SizedBox(height:40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Upload from camera',
                style: TextStyle(
                  fontSize:16,
                  color:Colors.blue[900]
                )
              ),
              SizedBox(width:40),
              Text(
                'Upload from gallery',
                style: TextStyle(
                  fontSize:16,
                  color:Colors.blue[900]
                )
              ),
            ],
          )
            ],
          )
          
        );
      });
  }

}