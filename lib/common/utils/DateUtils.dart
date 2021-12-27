class DateUtil {
  static final List<String> CN_UPPER_NUMBER = [
    "零",
    "壹",
    "贰",
    "叁",
    "肆",
    "伍",
    "陆",
    "柒",
    "捌",
    "玖"
  ];
  static final List<String> CN_WEEKDAY = ["一", "二", "三", "四", "五", "六", "日"];
  static String getNowTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    int day = dateTime.day;
    int nowDay = DateTime.now().day;
    if (day == nowDay) {
      return dateTime.hour.toString() + ":" + dateTime.minute.toString();
    }
    int week = dateTime.toLocal().weekday;
    return "星期" + CN_WEEKDAY[week - 1];
  }
}
