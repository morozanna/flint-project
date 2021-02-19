import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flint_project/models/historyModel.dart';
import 'package:flutter/material.dart';

class HistoryService extends ChangeNotifier {
  String collectionName = 'history';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<History> getHistory(String id) async {
    var snap = await _db.collection(collectionName).doc(id).get();
    return History.fromMap(snap.data());
  }

  Future<List<History>> getAllHistory() async {
    final List<History> list = [];
    await _db.collection(collectionName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var history = History.fromMap(element.data());
        list.add(history);
      });
      return list;
    });
    return list;
  }

  Future addHistory(History history) async {
    var result = await _db
        .collection(collectionName)
        .add(history.toMap())
        .then((value) async {
      history.id = value.id;
      var _result = await _db
          .collection(collectionName)
          .doc(value.id)
          .set({"id": value.id}, SetOptions(merge: true));
      return _result;
    });
    notifyListeners();
    return result;
  }
}
