import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/time_converter.dart';
import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsList extends StatefulWidget {
  final CurrentUser currentUser;
  final String postId;
  CommentsList({this.postId,  this.currentUser});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Comment> comments = Provider.of<List<Comment>>(context) ?? [];
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
        child: comments.length == 0
            ? SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(image: AssetImage('assets/images/nothing.png')),
                      SizedBox(
                        height: 20,
                      ),
                      Text('No comment to show',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: commentController,
                          decoration: InputDecoration(
                              hintText: 'Write comment...',
                              hintStyle: TextStyle(fontSize: 16),
                              suffix: IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.lightBlueAccent,
                                onPressed: () =>
                                    CommentDatabaseService(id: widget.postId+DateTime.now().toString())
                                        .updateCommmentData(
                                            widget.currentUser.name,
                                            widget.currentUser.imageUrl,
                                            DateTime.now().millisecondsSinceEpoch,
                                            commentController.text),
                              )))
                    ],
                  ),
                ),
            )
            : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          Comment comment = comments[index];
                          comments.forEach((element) =>print(element.text));
                          return Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Colors.lightBlueAccent.withOpacity(.1),
                                        backgroundImage: comment.imageUrl != 'none'
                                            ? NetworkImage(comment.imageUrl)
                                            : AssetImage(
                                                'assets/images/icons8-customer-64.png'),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(comment.userName,
                                              style: TextStyle(
                                                  fontSize: 16, color: Colors.black)),
                                          SizedBox(width: 10),
                                          Text(converter(comment.time),
                                              style: TextStyle(color: Colors.grey)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 62,
                                      ),
                                      Container(
                                          height: 30,
                                          width: MediaQuery.of(context).size.width * .7,
                                          child: Text(
                                            comment.text,
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                          )),
                                    ],
                                  )
                                ],
                              ));
                        }),
                  ),
                  SizedBox(height: 40,),
                  TextField(
                        controller: commentController,
                          decoration: InputDecoration(
                              hintText: 'Write comment...',
                              hintStyle: TextStyle(fontSize: 16),
                              suffix: IconButton(
                                icon: Icon(Icons.send),
                                color: Colors.lightBlueAccent,
                                onPressed: () =>
                                    CommentDatabaseService(id: widget.postId+DateTime.now().toString())
                                        .updateCommmentData(
                                            widget.currentUser.name,
                                            widget.currentUser.imageUrl,
                                            DateTime.now().millisecondsSinceEpoch,
                                            commentController.text),
                              )))
                ],
              ),
            ),
      ),
    );
  }
}
