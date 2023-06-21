import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class ContactProvider with ChangeNotifier {
//   List<Contact> contacts = [];
//
//   DateTime cupertinoDate = DateTime.now();
//   String newCupertinoDate = "";
//   String date = "";
//   String time = "";
//
//   Future<void> saveContact(Contact contact) async {
//     // Set the current date and time when saving the contact
//     contact.date = DateFormat("dd/MM/yyyy").format(DateTime.now());
//     contact.time = DateFormat("HH:mm").format(DateTime.now());
//
//     contacts.add(contact);
//     await _saveContacts();
//   }
//
//   Future<void> _saveContacts() async {
//     final preferences = await SharedPreferences.getInstance();
//     final contactsJson = contacts.map((contact) => contact.toJson()).toList();
//     preferences.setStringList('contacts', contactsJson);
//   }
//
//   Future<void> loadContacts() async {
//     final preferences = await SharedPreferences.getInstance();
//     final contactsJson = preferences.getStringList('contacts');
//     if (contactsJson != null) {
//       contacts = contactsJson.map((json) => Contact.fromJson(json)).toList();
//     }
//     notifyListeners();
//   }
//
//   showMyDate(BuildContext context) async {
//     DateTime? pickDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1965),
//       lastDate: DateTime(2999),
//     );
//
//     if (pickDate != null) {
//       String formattedDate = DateFormat("dd/MM/yyyy").format(pickDate);
//       date = formattedDate;
//       notifyListeners();
//     }
//   }
//
//   showCupertinoDate(BuildContext context) async {
//     cupertinoDate = (await showModalBottomSheet<DateTime>(
//       context: context,
//       builder: (context) => SizedBox(
//         height: MediaQuery.of(context).size.height / 4,
//         child: CupertinoDatePicker(
//           initialDateTime: DateTime.now(),
//           onDateTimeChanged: (DateTime value) {
//             cupertinoDate = value;
//             notifyListeners();
//             print(value);
//           },
//           minimumYear: 1990,
//           maximumYear: 2099,
//           mode: CupertinoDatePickerMode.date,
//         ),
//       ),
//     ))!;
//
//     if (cupertinoDate != null) {
//       newCupertinoDate = DateFormat("dd/MM/yyyy").format(cupertinoDate);
//     }
//   }
//
//   showMyTime(BuildContext context) async {
//     final TimeOfDay? newTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (newTime != null) {
//       TimeOfDay formattedTime =
//           TimeOfDay(hour: newTime.hour, minute: newTime.minute);
//       time = formattedTime.format(context);
//       notifyListeners();
//     }
//   }
// }

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

// showCupertinoDate(BuildContext context) async {
//   CupertinoDatePicker newCupertinoDate = await showModalBottomSheet(
//     context: context,
//     builder: (context) => SizedBox(
//       height: MediaQuery.of(context).size.height / 4,
//       child: CupertinoDatePicker(
//         initialDateTime: DateTime.now(),
//         onDateTimeChanged: (DateTime value) {
//           cupertinoDate = value.toString();
//           notifyListeners();
//           print(value);
//         },
//         minimumYear: 1990,
//         maximumYear: 2099,
//         mode: CupertinoDatePickerMode.date,
//       ),
//     ),
//   );
//   if (cupertinoDate != null) {
//     String formatedDate = DateFormat("dd/MM/yyyy").format(cupertinoDate as DateTime);
//     newCupertinoDate = formatedDate as CupertinoDatePicker;
//   }
// }
}
