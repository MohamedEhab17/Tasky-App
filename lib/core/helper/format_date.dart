import 'package:intl/intl.dart';

String getSmartDayLabel(DateTime date) {
  final now = DateTime.now();
  date = DateTime(
    date.year,
    date.month,
    date.day,
    date.hour,
    date.minute,
    date.second,
  );
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final tomorrow = today.add(const Duration(days: 1));

  final target = DateTime(date.year, date.month, date.day);

  if (target == today) return "Today At ${date.hour}:${date.minute}";
  if (target == yesterday) return "Yesterday At ${date.hour}:${date.minute}";
  if (target == tomorrow) return "Tomorrow At ${date.hour}:${date.minute}";

  // week check
  final startOfThisWeek = today.subtract(Duration(days: today.weekday - 1));
  final endOfThisWeek = startOfThisWeek.add(const Duration(days: 6));

  final startOfLastWeek = startOfThisWeek.subtract(const Duration(days: 7));
  final endOfLastWeek = startOfThisWeek.subtract(const Duration(days: 1));

  final startOfNextWeek = endOfThisWeek.add(const Duration(days: 1));
  final endOfNextWeek = startOfNextWeek.add(const Duration(days: 6));

  if (target.isAfter(startOfLastWeek) &&
      target.isBefore(endOfLastWeek.add(const Duration(days: 1)))) {
    return "Last week At ${date.hour}:${date.minute}";
  }

  if (target.isAfter(startOfNextWeek.subtract(const Duration(days: 1))) &&
      target.isBefore(endOfNextWeek.add(const Duration(days: 1)))) {
    return "Next week At ${date.hour}:${date.minute}";
  }

  // month check
  final startOfNextMonth = DateTime(now.year, now.month + 1, 1);
  final startOfLastMonth = DateTime(now.year, now.month - 1, 1);

  if (target.month == now.month && target.year == now.year) {
    return "This month At ${date.day}/${date.month}";
  }
  if (target.month == startOfLastMonth.month &&
      target.year == startOfLastMonth.year) {
    return "Last month At ${date.day}/${date.month}";
  }
  if (target.month == startOfNextMonth.month &&
      target.year == startOfNextMonth.year) {
    return "Next month At ${date.hour}:${date.month}";
  }

  // fallback → formatted date
  return DateFormat("dd MMM yyyy").format(date);
}
