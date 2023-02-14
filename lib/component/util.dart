import 'package:timeago/timeago.dart'as timeago;
import 'package:intl/intl.dart';

dateFormat(date){
  return DateFormat("d/MM/yyyy").format(date);
}
timeFormat(date){
  return DateFormat("hh:mm a").format(date);
}

agoTimeByDate(date){
  return timeago.format(date);
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}