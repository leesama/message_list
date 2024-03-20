import 'package:intl/intl.dart';

class WechatDateFormat {
  /// Formats a date given in milliseconds since epoch. If [dayOnly] is true, only the date part is returned.
  /// - `millisecondsSinceEpoch`: The date to format, in milliseconds since epoch.
  /// - `dayOnly`: Whether to format only the date part without the time.
  static String format(int millisecondsSinceEpoch, {bool dayOnly = true}) {
    // The current date.
    DateTime nowDate = DateTime.now();
    // The target date to format.
    DateTime targetDate = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    String prefix = "";
    // Determine the date prefix based on the difference from the current date.
    if (nowDate.year != targetDate.year) {
      prefix = DateFormat("yyyy年M月d日").format(targetDate); // Different year.
    } else if (nowDate.month != targetDate.month) {
      prefix = DateFormat("M月d日").format(targetDate); // Different month.
    } else if (nowDate.day != targetDate.day) {
      if (nowDate.day - targetDate.day == 1) {
        prefix = '昨天'; // Yesterday.
      } else {
        prefix = DateFormat("M月d日").format(targetDate); // Different day within the same month.
      }
    }
    if (prefix.isNotEmpty && dayOnly) {
      return prefix; // Return only the date part if dayOnly is true.
    }

    // Determine the time of day for the prefix.
    int targetHour = targetDate.hour;
    String returnTime = "";
    String suffix = DateFormat("h:mm").format(targetDate); // Format the time part.
    if (targetHour >= 0 && targetHour < 6) {
      returnTime = '凌晨'; // Early morning.
    } else if (targetHour >= 6 && targetHour < 8) {
      returnTime = '早晨'; // Morning.
    } else if (targetHour >= 8 && targetHour < 11) {
      returnTime = '上午'; // Late morning.
    } else if (targetHour >= 11 && targetHour < 13) {
      returnTime = '中午'; // Noon.
    } else if (targetHour >= 13 && targetHour < 18) {
      returnTime = '下午'; // Afternoon.
    } else if (targetHour >= 18 && targetHour <= 23) {
      returnTime = '晚上'; // Evening.
    }

    return '$prefix $returnTime$suffix'; // Combine and return the full formatted string.
  }
}
