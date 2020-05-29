class Post {
  String text;
  String userName;
  String postId;
  String userId;
  DateTime time;
  int likes;
  String userImageUrl;
  String postImageUrl;
  List likers;

  Post(
      {this.text,
      this.userName,
      this.postId,
      this.userId,
      this.time,
      this.likes,
      this.likers,
      this.userImageUrl,
      this.postImageUrl});
}
