import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_clone/models/comment.dart';
import 'package:facebook_clone/models/current_user.dart';
import 'package:facebook_clone/models/post.dart';

class PostDatabaseService {

  // id has to be uid + DateTime.now() for unique records

  final String id;
  PostDatabaseService({this.id});

  final CollectionReference postCollection =
      Firestore.instance.collection('posts');

  Future updatePostData({String name, String userImageUrl, String postImageUrl, int time, String uid,
      String text, List likers}) async {
    return await postCollection.document(id).setData({
      //try: with every uid, get user name and imageUrl from UserCollection Stream
      //that would make "name" and "imageUrl" fields useless

      "userName": name,
      "userImageUrl": userImageUrl,
      "postImageUrl": postImageUrl,
      "postId":id,
      'userId': uid,
      'time': time,
      'text': text,
      'likers': likers,
    });
  }

  List<Post> _postsFromCollection(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Post(
        text: doc.data['text'] ?? '',
        userName: doc.data['userName'] ?? '',
        userId: doc.data['userId'] ?? '',
        postId: doc.data['postId'] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(doc.data['time']) ?? DateTime.now().millisecondsSinceEpoch,
        likers: doc.data['likers'] ?? [],
        userImageUrl: doc.data['userImageUrl'] ?? 'none',
        postImageUrl : doc.data['postImageUrl'] ?? 'none',

      );
    }).toList();
  }

   Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postsFromCollection);
  }

}

class CommentDatabaseService {

  // id has to be postId + DateTime.now() for unique records

  final String id;
  CommentDatabaseService({this.id});

  final CollectionReference commentCollection =
      Firestore.instance.collection('comments');

   Future updateCommmentData(String name, String imageUrl, int time,
      String text) async {
    return await commentCollection.document(id).setData({
      'userName': name,
      'time': time,
      'text': text,
      'imageUrl': imageUrl
    });
  }

  Stream<List<Comment>> get comments {
    return commentCollection.snapshots().map(_commentsFromCollection);
  }

 List<Comment> _commentsFromCollection(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Comment(
        text: doc.data['text'] ?? '',
        userName: doc.data['userName'] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(doc.data['time']) ?? DateTime.now().millisecondsSinceEpoch,
        imageUrl: doc.data['imageUrl'] ?? 'none',


      );
    }).toList();
  }

}

class UserDatabaseService {
  final String id;
  UserDatabaseService({this.id});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  Future updateUserData(String name, String imageUrl) async {
    return await userCollection
        .document(id)
        .setData({"name": name, "imageUrl": imageUrl});
  }

  CurrentUser _userFromSnapshot(DocumentSnapshot snap){
      return CurrentUser(
        name: snap.data['name'],
        imageUrl: snap.data['imageUrl']
      );
  }

  Stream<CurrentUser> get users {
    return userCollection.document(id).snapshots().map(_userFromSnapshot);
  }

}
