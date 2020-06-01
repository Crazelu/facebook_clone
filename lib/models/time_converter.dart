String converter(DateTime time){
  var now = DateTime.now();
  if (time.year - now.year == 0 && time.month - now.month == 0 && time.day - now.day == 0 && time.hour - now.hour == 0){
    if (time.minute - now.minute == 0){
      return (time.second - now.second).abs() == 1 ? '${(time.second - now.second).abs()} second ago': '${(time.second - now.second).abs()} seconds ago';
    }
    return (time.minute - now.minute).abs() == 1 ? '${(time.minute - now.minute).abs()} minute ago': '${(time.minute - now.minute).abs()} minutes ago';
  }
  else if (time.year - now.year == 0 && time.month - now.month == 0 && time.day - now.day == 0){
    return (time.hour - now.hour).abs() == 1 ? '${(time.hour - now.hour).abs()} hour ago': '${(time.minute - now.minute).abs()} hours ago';
  }
  else if (time.year - now.year == 0 && time.month - now.month == 0){
    if((time.day - now.day).abs() == 1 && time.minute < 10){
      var minute = time.minute.toString().padLeft(2,'0');
       return 'yesterday at ${time.hour}:$minute';
    }
    return 'yesterday at ${time.hour}:${time.minute}';
  }
  else if (time.year - now.year == 0 ){
    return (time.month - now.month).abs() == 1 ? '${(time.month - now.month).abs()} month ago': '${(time.month - now.month).abs()} months ago';
  }
  else{
    return (time.year - now.year).abs() == 1 ? '${(time.year - now.year).abs()} year ago': '${(time.year - now.year).abs()} years ago';
  }
}