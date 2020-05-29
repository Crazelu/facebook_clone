import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/create_post.dart';
import 'package:facebook_clone/screens/post_view.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Post> posts = Provider.of<List<Post>>(context);
    var currentUser = Provider.of<CurrentUser>(context);
    return Padding(
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
                      backgroundColor: Colors.amber,
                      backgroundImage: currentUser.imageUrl != 'none' ? NetworkImage(currentUser.imageUrl):
                      AssetImage('assets/images/icons8-customer-64.png'),
                    ),
                    StreamProvider<CurrentUser>.value(
        initialData: CurrentUser(),
        value: UserDatabaseService().users,
        child: Container(
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
        )
                    
                  ],
                ),
                SizedBox(height:20),
                          Container(
                            height: height*.75,
                            
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: posts.length,
                              itemBuilder: (context, index){
                                return _listView(context, height, width, posts.reversed.toList()[index]);
                              }
                              ),
                          ),
              ],
            )
          ),
        );
  }

  _listView(BuildContext context, double height, double width, Post post){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> PostView(post)));
        },
      child: Container(
        color: Colors.white,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.amber,
                      backgroundImage: post.userImageUrl != 'none' ? NetworkImage(post.userImageUrl) : AssetImage('assets/images/icons8-customer-64.png'),
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
            post.postImageUrl != 'none' ?
            Container(
              width: width,
              height: height*.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(post.postImageUrl),
                  fit: BoxFit.cover
                ),
                color: Colors.pink,
                borderRadius: BorderRadius.circular(20)
              )

            ) : Container(),
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
            SizedBox(height:30)
          ],
        )
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