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

class Profile extends StatefulWidget {
  final String id;
  Profile({this.id});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController= TextEditingController();
  String _downloadUrl;
  StorageReference _reference;
  bool isUploaded = false;
  String _imageUrl;
  File _profilePic;

  Future getImage(bool isCamera) async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _profilePic = image;
      _imageUrl = Provider.of<User>(context).id+'image';
      uploadToCloud();
      downloadFromCloud();
      
    });
  }

  Future uploadToCloud() async{
    _reference = FirebaseStorage.instance.ref().child(_imageUrl);
    StorageUploadTask uploadTask = _reference.putFile(_profilePic);
    StorageTaskSnapshot snap = await uploadTask.onComplete;
    setState(() {
      isUploaded = true;
      print(isUploaded);
    });
  }

  Future downloadFromCloud() async{
    String address = await _reference.getDownloadURL();
    setState(() {
      _downloadUrl = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    nameController.text = currentUser.name ?? '';
    isUploaded = currentUser.imageUrl != 'none';
    print('current user name : ${currentUser.name}');
    print('User id ${widget.id}');
    print(_downloadUrl);
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                onPressed: (){}, 
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
      body: WillPopScope(
        onWillPop: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=> HomeScreen())),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20,20,20,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 50,
                            backgroundImage: currentUser.imageUrl != 'none' ? NetworkImage(currentUser.imageUrl) : _downloadUrl != null ? NetworkImage(_downloadUrl):
                            AssetImage('assets/images/icons8-customer-64.png'),
                          ),
                          SizedBox(height:20),
                          FlatButton.icon(
                            onPressed: ()=> _bottomSheet(context, height, width), 
                            icon: Icon(Icons.add_photo_alternate), 
                            label: Text('Upload image')),
                            SizedBox(height:20),
                            Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _textField(nameController, 'Name', nameValidator, false),
                          SizedBox(height:20),
                          FlatButton(
                            onPressed: (){
                              print(_downloadUrl);
                              if(_downloadUrl != null){
                            UserDatabaseService(id:widget.id).updateUserData(nameController.text, _downloadUrl);
                             Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=> HomeScreen()));
                            }
                            }, 
                            child: Text(
                              'Update profile',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ))
                        ]
                      )
                    ),
                            
            ]
          ),
        ),
      ),
      
    );
  }

   _textField(TextEditingController controller, String label, Function validator, bool obscure){
    return TextFormField(
      obscureText: obscure,
      validator: validator,
      controller: controller,
      decoration: decoration.copyWith(
        labelText: label,
      )
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
            color: Colors.grey[200],
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
                  color:Colors.black
                )
              ),
              SizedBox(width:40),
              Text(
                'Upload from gallery',
                style: TextStyle(
                  fontSize:16,
                  color:Colors.black
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