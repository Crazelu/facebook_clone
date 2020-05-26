import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/create_post.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AuthService _auth = AuthService();

  void delay(){
    Future.delayed(Duration(seconds: 5)).then((onValue){
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    delay();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(10,20,10,0),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.amber
                  ),
                  Container(
                    width: width *.7,
                    height: 50,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> CreatePost(id: Provider.of<User>(context).id)));
                      },
                      child: Text(
                        "What's on your mind?",
                        style: TextStyle(
                          color: Colors.grey[400]
                        )
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: Colors.grey
                        )
                      ),
                      )
                  ),
                ],
              ),
              SizedBox(height:20),
                        Container(
                          height: height*.75,
                          
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.length,
                            itemBuilder: (context, index){
                              var working = posts.reversed.toList();
                              return _listView(height, width, working[index]);
                            }
                            ),
                        ),
            ],
          )
        ),
      ),
    );
  }

  _listView(double height, double width, Post post){
    return Container(
      color: Colors.white,
      width: width,
      height: height*.55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.amber
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        post.userName,
                        style: TextStyle(
                          fontSize:16,
                          color: Colors.black
                        )
                        ),
                      Text(
                        post.time.toString(),
                        style: TextStyle(
                          color: Colors.grey
                        )
                        ),
                    ],
                  )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical:20),
            width: width,
            child: Text(
              post.text,
              maxLines: 3,
              overflow: TextOverflow.fade,
              )
          ),
          Container(
            width: width,
            height: height*.25,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20)
            )

          ),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                onPressed: (){},
                icon: Icon(Icons.favorite_border),
              ),
              Text('${post.likes} likes'),
                ],),
              
              Container(
                    width: width *.5,
                    height: 50,
                    child: FlatButton(
                      onPressed: (){
                        //Implement draggable bottom sheet
                        _bottomSheet(context, height, width);
                      },
                      child: Text(
                        "Comments",
                        style: TextStyle(
                          color: Colors.grey[400]
                        )
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: Colors.grey
                        )
                      ),
                      )
                  ),
            ],
          ),
        ],
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            )
          ),
          child: _commentListView()
          
        );
      });
  }

  _commentListView() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30,10,10,10),
        child: 
            ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index){
                Comment comment = comments[index];
                return Container(
                  height:80,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical:10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                       CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.amber
                          ),
                          SizedBox(width: 20,),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                comment.userName,
                                style: TextStyle(
                                  fontSize:16,
                                  color: Colors.black
                                )
                                ),
                                SizedBox(width:10),
                              Text(
                                comment.time.toString().substring(0,12),
                                style: TextStyle(
                                  color: Colors.grey
                                )
                                ),
                            ],
                          )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 62,),
                      Container(
                        height: 30,
                        width:MediaQuery.of(context).size.width*.7,
                        child: Text(
                          comment.text,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        )
                      ),
                    ],
                  )
                    ],
                  )
                );
              }
              ),
      ),
    );
  }

}