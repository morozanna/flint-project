import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  String id;
  int phoneNr;
  DateTime dateSend;
  DocumentReference wishRef;

  History({this.id = '', this.phoneNr, this.dateSend, this.wishRef});

  History.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.phoneNr = obj['phoneNr'];
    Timestamp timestamp = obj['dateSend'];
    this.dateSend = DateTime.parse(timestamp.toDate().toString());
    this.wishRef = obj['wish'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['phoneNr'] = phoneNr;
    map['dateSend'] = dateSend;
    map['wish'] = wishRef;

    return map;
  }

  @override
  String toString() {
    return 'id: ${this.id}, nr: ${this.phoneNr}, date: ${this.dateSend}, wish: ${this.wishRef}';
  }
}
