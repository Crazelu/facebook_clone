import 'dart:io';

import 'package:facebook_clone/constants/constants.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/home_screen.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  final String id;
  NewPost({this.id});
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController textController = TextEditingController();
  String _imageUrl;
  String errorMessage = '';
  File _image;
  String _downloadUrl;
  StorageReference _reference;
  final DateTime _time = DateTime.now();
  bool isUploaded = false;
  bool isVisible = false;

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
      _imageUrl = widget.id + _time.toString();
      uploadToCloud();
      if (isUploaded) {
        downloadFromCloud();
      }
      isVisible = false;
    });
  }

  Future uploadToCloud() async {
    _reference = FirebaseStorage.instance.ref().child(_imageUrl);
    StorageUploadTask uploadTask = _reference.putFile(_image);
    StorageTaskSnapshot snap = await uploadTask.onComplete;
    setState(() {
      print('Upload done');
      isUploaded = true;
    });
  }

  Future downloadFromCloud() async {
    String address = await _reference.getDownloadURL();
    setState(() {
      print(_downloadUrl);
      _downloadUrl = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserImage =
        Provider.of<CurrentUser>(context).imageUrl ?? 'none';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            color: Colors.blue[900],
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.replay)),
        actions: <Widget>[
          _iconButton(context)
        ],
      ),
      body: Material(
          color: Colors.white, child: _postView(context, currentUserImage)),
    );
  }

  _postView(BuildContext context, String image) {
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
                    radius: 20,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(.1),
                    backgroundImage: image != 'none'
                        ? NetworkImage(image)
                        : AssetImage('assets/images/icons8-customer-64.png'),
                  ),
                  Container(
                      width: width * .75,
                      height: height * .3,
                      child: TextField(
                          controller: textController,
                          maxLines: 20,
                          decoration: postDecoration.copyWith(
                              hintText: 'Write something...')))
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      _bottomSheet(context, height, width);
                    },
                    iconSize: 40,
                    color: Colors.grey,
                  )
                ],
              ),
              SizedBox(height: 15),
              Visibility(
                  visible: isVisible,
                  child: Text(errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16))),
              SizedBox(height: 15),
              _image == null
                  ? Container()
                  : Container(
                      height: height * .4,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: FileImage(_image))),
                    )
            ],
          )),
    );
  }

  _bottomSheet(BuildContext context, double height, double width) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return Container(
              width: width,
              height: height * .8,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.camera),
                          iconSize: 50,
                          onPressed: () {
                            getImage(true);
                            Navigator.pop(context);
                          }),
                      SizedBox(width: 120),
                      IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          iconSize: 50,
                          onPressed: () {
                            getImage(false);
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Upload from camera',
                          style:
                              TextStyle(fontSize: 16, color: Colors.blue[900])),
                      SizedBox(width: 40),
                      Text('Upload from gallery',
                          style:
                              TextStyle(fontSize: 16, color: Colors.blue[900])),
                    ],
                  )
                ],
              ));
        });
  }

  _iconButton(BuildContext context) {
    return IconButton(
              color: Colors.grey,
              onPressed: () {

                if (errorMessage.isNotEmpty && _downloadUrl == null){
                  downloadFromCloud();
                }

                if (!isUploaded || _downloadUrl == null) {
                  setState(() {
                    errorMessage = 'Error uploading image, try again';
                    isVisible = true;
                  });
                  return 0;
                }

                if (textController.text.isEmpty && _downloadUrl == null) {
                  showDialog(
                    context: context,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal:20),
                          height: 50,
                          color: Colors.blue[700],
                          child: Center(
                            child: Text(
                              'Post cannot be empty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                color: Colors.white
                              )
                              ),
                          ),
                        ),
                      ));
                        return 0;
                  //Alert user to post an image or text
                  
                } 
              

                else {
                  var user = Provider.of<User>(context);
                  var current = Provider.of<CurrentUser>(context);
                  PostDatabaseService(id: user.id + DateTime.now().toString())
                      .updatePostData(
                          userImageUrl: current.imageUrl,
                          postImageUrl: _downloadUrl ?? 'none',
                          likers: [],
                          text: textController.text ?? '',
                          uid: user.id,
                          name: current.name,
                          time: DateTime.now().millisecondsSinceEpoch);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                }
              },
              icon: Icon(Icons.send));
  }
}
