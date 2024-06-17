import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

class DateSeparator extends StatelessWidget {
  final DateTime date;

  const DateSeparator({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    // Convert Gregorian date to Jalali date
    final jalaliDate = Jalali.fromDateTime(date);
    final formattedDate =
        "${jalaliDate.formatter.wN} ${jalaliDate.year}/${jalaliDate.month.toString().padLeft(2, '0')}/${jalaliDate.day.toString().padLeft(2, '0')}";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: const Divider(thickness: 1, color: Styles.grey30)
                .marginOnly(right: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              formattedDate,
              style: Styles.normalText(color: Styles.grey28),
            ),
          ),
          Expanded(
            child: const Divider(thickness: 1, color: Styles.grey30)
                .marginOnly(left: 18),
          ),
        ],
      ),
    );
  }
}
