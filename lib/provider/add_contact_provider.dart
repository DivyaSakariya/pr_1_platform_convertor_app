import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddContactProvider extends ChangeNotifier {
  String date = "";
  String time = "";
  DateTime cupertinoDate = DateTime.now();
  String newCupertinoDate = "";

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1965),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formatedDate = DateFormat("dd/MM/yyyy").format(pickDate);
      date = formatedDate;
    }
    notifyListeners();
  }

  showMyTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      TimeOfDay formattedTime =
          TimeOfDay(hour: newTime.hour, minute: newTime.minute);
      time = formattedTime.format(context);
    }
    notifyListeners();
  }

  showCupertinoDate(BuildContext context) async {
    cupertinoDate = (await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime value) {
            cupertinoDate = value;
            notifyListeners();
            print(value);
          },
          minimumYear: 1990,
          maximumYear: 2099,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
    ))!;

    newCupertinoDate = DateFormat("dd/MM/yyyy").format(cupertinoDate);
  }

  hotReload() {
    notifyListeners();
  }
}
