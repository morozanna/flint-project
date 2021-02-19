import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flint_project/models/wishModel.dart';
import 'package:flutter/material.dart';

class WishService extends ChangeNotifier {
  String collectionName = 'wishes';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Wish> getWish(String id) async {
    var snap = await _db.collection(collectionName).doc(id).get();
    return Wish.fromMap(snap.data());
  }

  Future<List<Wish>> getWishes() async {
    final List<Wish> list = [];
    await _db.collection(collectionName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var wish = Wish.fromMap(element.data());
        list.add(wish);
      });
      return list;
    });
    return list;
  }

  Future addWish(Wish wish) async {
    var result = await _db
        .collection(collectionName)
        .add(wish.toMap())
        .then((value) async {
      wish.id = value.id;
      var _result = await _db
          .collection(collectionName)
          .doc(value.id)
          .set({"id": value.id}, SetOptions(merge: true));
      return _result;
    });
    notifyListeners();
    return result;
  }

  Future editWish(Wish editedWish) async {
    var result = await _db
        .collection(collectionName)
        .doc(editedWish.id)
        .set({"content": editedWish.content}, SetOptions(merge: true));
    notifyListeners();

    return result;
  }

  Future deleteWish(String id) async {
    var result = await _db.collection(collectionName).doc(id).delete();
    notifyListeners();

    return result;
  }
}
