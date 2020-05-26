import 'package:cloud_firestore/cloud_firestore.dart';

class PostDatabaseService{

  final CollectionReference postCollection = Firestore.instance.collection('posts');
  

}


class CommentDatabaseService{

  final CollectionReference commentCollection = Firestore.instance.collection('comments');


}

class UserDatabaseService{

  final String id;
  UserDatabaseService({this.id});

  final CollectionReference userCollection = Firestore.instance.collection('users');
  Future updateUserData(String name, String imageUrl) async{
    return await userCollection.document(id).setData(
      {
        "name": name,
        "imageUrl": imageUrl
      }
    );
  }
  

}