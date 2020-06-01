import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/post.dart';
import 'package:facebook_clone/models/user.dart';
import 'package:facebook_clone/screens/comments_list.dart';
import 'package:facebook_clone/screens/create_post.dart';
import 'package:facebook_clone/screens/post_view.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:facebook_clone/models/time_converter.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Post> posts = Provider.of<List<Post>>(context) ?? [];
    final currentUser = Provider.of<CurrentUser>(context) ??
        CurrentUser(imageUrl: 'none', name: '');
    return feed(context, currentUser, posts, width, height);
      }
    
      _listView(BuildContext context, double height, double width, Post post, CurrentUser currentUser) {
        List likers = post.likers;
        var userId = Provider.of<User>(context).id;
        return InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => PostView(post)));
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
                        backgroundColor: Colors.lightBlueAccent.withOpacity(.1),
                        backgroundImage: post.userImageUrl != 'none'
                            ? NetworkImage(post.userImageUrl)
                            : AssetImage('assets/images/icons8-customer-64.png'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(post.userName,
                              style: TextStyle(fontSize: 16, color: Colors.black)),
                          Text(converter(post.time),
                              style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: width,
                      child: Text(
                        post.text,
                        maxLines: 3,
                        overflow: TextOverflow.fade,
                      )),
                  post.postImageUrl != 'none'
                      ? Container(
                          width: width,
                          height: height * .25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  //TODO: Implement placeholder while image loads
                                  image: NetworkImage(post.postImageUrl),
                                  fit: BoxFit.cover),
                              color: Colors.lightBlueAccent.withOpacity(.1),
                              borderRadius: BorderRadius.circular(20)))
                      : Container(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            splashColor: Colors.transparent,
                              onPressed: () {
                                likers.contains(userId)
                                    ? likers.remove(userId)
                                    : likers.add(userId);
                                PostDatabaseService(id: post.postId).updatePostData(
                                    name: post.userName,
                                    userImageUrl: post.userImageUrl,
                                    postImageUrl: post.postImageUrl,
                                    time: DateTime.fromMillisecondsSinceEpoch(
                                            post.time.millisecondsSinceEpoch)
                                        .millisecondsSinceEpoch,
                                    text: post.text,
                                    likers: likers,
                                    uid: userId);
                              },
                              icon: Icon(
                                likers.contains(userId)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              )),
                          Text(post.likers.length == 1
                              ? '${post.likers.length} like'
                              : '${post.likers.length} likes',
                              style: TextStyle(
                                    color: Colors.black54, fontSize: 15),),
                        ],
                      ),
                      Container(
                          width: width * .5,
                          height: 50,
                          child: FlatButton(
                            onPressed: () {
                              //Implement draggable bottom sheet
                              _bottomSheet(context, height, width, post.postId, currentUser);
                            },
                            child: Text("Comments",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15)),
                          )),
                    ],
                  ),
                  SizedBox(height: 30)
                ],
              )),
        );
      }
    
      _bottomSheet(
          BuildContext context, double height, double width, String postId, CurrentUser currentUser) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return StreamProvider<List<Comment>>.value(
                value: CommentDatabaseService(id: postId).comments,
                child: Container(
                    width: width,
                    height: height * .8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: CommentsList(postId: postId, currentUser: currentUser,),
              ));
            });
      }
    
      Widget feed(BuildContext context, CurrentUser currentUser, List<Post> posts, double width, double height) {
        return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.lightBlueAccent.withOpacity(.1),
                    backgroundImage: currentUser.imageUrl != 'none'
                        ? NetworkImage(currentUser.imageUrl)
                        : AssetImage('assets/images/icons8-customer-64.png'),
                  ),
                  StreamProvider<CurrentUser>.value(
                    initialData: CurrentUser(),
                    value:
                        UserDatabaseService(id: Provider.of<User>(context).id)
                            .users,
                    child: Container(
                        color: Colors.white,
                        width: width * .7,
                        height: 50,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CreatePost(
                                        id: Provider.of<User>(context).id)));
                          },
                          child: Text("What's on your mind?",
                              style: TextStyle(color: Colors.grey[400])),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: Colors.grey)),
                        )),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: height * .75,
                child: posts.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return _listView(context, height, width,
                              posts.reversed.toList()[index], currentUser);
                        })
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image: AssetImage('assets/images/nothing.png')),
                            SizedBox(
                              height: 20,
                            ),
                            Text('No post to show',
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                      ),
              ),
            ],
          )),
    );
      }
 
}
