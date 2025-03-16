import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static String formatDate(DateTime inputDate, {int type = 0}) {
    final now = DateTime.now();
    if (inputDate.isAfter(now)) {
      return '';
    }

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final oneWeekAgo = today.subtract(const Duration(days: 7));

    // Case 1: Same day
    if (inputDate.isAfter(today) && type == 0) {
      return DateFormat('h:mm a').format(inputDate); // e.g., 11:20 AM
    }

    if (DateUtils.isSameDay(inputDate, today) && type == 1) {
      return 'Today';
    }

    // Case 2: Yesterday
    if (inputDate.isAtSameMomentAs(yesterday) ||
        (inputDate.isAfter(yesterday) && inputDate.isBefore(today))) {
      return 'Yesterday';
    }

    // Case 3: Within the past 7 days
    if (inputDate.isAfter(oneWeekAgo)) {
      return DateFormat('EEEE').format(inputDate); // e.g., Monday
    }

    // Case 4: More than 7 days ago, but within the current year
    if (inputDate.year == now.year && type == 0) {
      return DateFormat('d MMM').format(inputDate); // e.g., 12 Sep
    }

    if (inputDate.year == now.year && type == 1) {
      return DateFormat('d MMMM').format(inputDate); // e.g., 12 September
    }

    if (type == 1) {
      return DateFormat('d MMMM yyyy')
          .format(inputDate); // e.g., 12 September 2024
    }
    // Case 5: From a previous year
    return DateFormat('d MMM yyyy').format(inputDate); // e.g., 12 Sep 2024
  }
}
