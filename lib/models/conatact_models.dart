import 'dart:convert';
import 'dart:io';

class Contact {
  String? fullName;
  String? phoneNo;
  String? chat;
  String? email;
  File? imageFile;
  String? date;
  String? time;

  Contact({
    this.fullName,
    this.phoneNo,
    this.chat,
    this.email,
    this.imageFile,
    this.date,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phoneNo': phoneNo,
      'chat': chat,
      'email': email,
      'date': date,
      'time': time,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      fullName: map['fullName'],
      phoneNo: map['phoneNo'],
      chat: map['chat'],
      email: map['email'],
      date: map['date'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));
}