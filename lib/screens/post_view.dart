import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/models/time_converter.dart';

class PostView extends StatefulWidget {

  final Post post;
  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
                onPressed: (){
                  _auth.signOut();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25,20,25,0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.lightBlueAccent.withOpacity(.1),
                        backgroundImage: widget.post.userImageUrl != 'none' ? NetworkImage(widget.post.userImageUrl) :
                        AssetImage('assets/images/icons8-customer-64.png'),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.post.userName,
                            style: TextStyle(
                              fontSize:16,
                              color: Colors.black
                            )
                            ),
                          Text(
                            converter(widget.post.time),
                            style: TextStyle(
                              color: Colors.grey
                            )
                            ),
                        ],
                      )
                ],
              ),
              SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.post.text,
                  style: TextStyle(
                    fontSize: 16
                  )
                )
              ),
              SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                ),
                child: Image.network(widget.post.postImageUrl)
              )
          ],),
        )
      )
    );
  }
}