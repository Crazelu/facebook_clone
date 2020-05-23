class Comment{

  String text;
  String userName;
  String id;
  DateTime time;

  Comment({this.text, this.userName, this.id, this.time});

}

List<Comment> comments = [
  Comment(text:'Nice stuff man', userName: 'Name Less', id:'1', time: DateTime.now()),
  Comment(text:'I love Lucky Dube too, lol', userName: 'Kelvin Lee', id:'1', time: DateTime.now()),
  Comment(text:'Where you at bro? I miss you.Loremp ipsum nals bufdalbnb;abn dzj fa; bibaznfb nrsfgiwusfbn obubylktrfg', userName: 'Akpan Uzochukwu', id:'1', time: DateTime.now()),
  Comment(text:'I see what you did there!', userName: 'Okey Nwagba', id:'1', time: DateTime.now()),
  Comment(text:'just passing by', userName: 'Enigma Sage', id:'1', time: DateTime.now()),
];