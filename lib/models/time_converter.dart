String converter(DateTime time){
  var now = DateTime.now();
  if (time.year - now.year == 0 && time.month - now.month == 0 && time.day - now.day == 0 && time.hour - now.hour == 0){
    if (time.minute - now.minute == 0){
      return time.second - now.second == 1 ? '${time.second - now.second} second ago': '${time.second - now.second} seconds ago';
    }
    return time.minute - now.minute == 1 ? '${time.minute - now.minute} minute ago': '${time.minute - now.minute} minutes ago';
  }
  else if (time.year - now.year == 0 && time.month - now.month == 0 && time.day - now.day == 0){
    return time.hour - now.hour == 1 ? '${time.hour - now.hour} hour ago': '${time.minute - now.minute} hours ago';
  }
  else if (time.year - now.year == 0 && time.month - now.month == 0){
    return time.day - now.day == 1 ? '${time.day - now.day} day ago': '${time.day - now.day} days ago';
  }
  else if (time.year - now.year == 0 ){
    return time.month - now.month == 1 ? '${time.month - now.month} month ago': '${time.month - now.month} months ago';
  }
  else{
    return time.year - now.year == 1 ? '${time.year - now.year} year ago': '${time.year - now.year} years ago';
  }
}