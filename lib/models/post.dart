class Post {
  String text;
  String userName;
  String id;
  DateTime time;
  int likes;

  Post({this.text, this.userName, this.id, this.time, this.likes});
}

List<Post> posts = [
  Post(
      text: 'Today is a very good day to be alive.',
      userName: 'Akpan Uyo',
      id: '1',
      time: DateTime.now(),
      likes: 20),
  Post(
      text: 'A poem by Lucky Dube.',
      userName: 'Lucky Ebere',
      id: '1',
      time: DateTime.now(),
      likes: 2),
  Post(
      text:
          "I'm listening to a very nice jam by Lukas Graham now and then Ariana comes up, lol. It's a fucking great day...",
      userName: 'Peace Idoh',
      id: '1',
      time: DateTime.now(),
      likes: 56),
  Post(
      text: 'No caption.',
      userName: 'Akpan Uyo',
      id: '1',
      time: DateTime.now(),
      likes: 10),
];
