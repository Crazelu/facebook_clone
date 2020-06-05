import 'package:facebook_clone/services/database.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/post.dart';

class NewsFeedViewModel extends ChangeNotifier{
  List _likers;
  static BuildContext context;
  String userId;
  CurrentUser currentUser;
  List<Post> posts;
  NewsFeedViewModel({this.currentUser, this.posts, this.userId});

  static final screenHeight = MediaQuery.of(context).size.height;
  static final screenWidth = MediaQuery.of(context).size.width;

  //implement like feature
  updateLikes(Post post) {
    _likers = post.likers;
    _likers.contains(userId) ? _likers.remove(userId) : _likers.add(userId);
    PostDatabaseService(id: post.postId).updatePostData(
        name: post.userName,
        userImageUrl: post.userImageUrl,
        postImageUrl: post.postImageUrl,
        time: DateTime.fromMillisecondsSinceEpoch(
                post.time.millisecondsSinceEpoch)
            .millisecondsSinceEpoch,
        text: post.text,
        likers: _likers,
        uid: userId);
        notifyListeners();
  }

}
