import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flint_project/models/wishModel.dart';
import 'package:flutter/cupertino.dart';

class WishService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Wish> getWish(String id) async {
    var snap = await _db.collection('wishes').doc(id).get();

    return Wish.fromMap(snap.data());
  }

  Future<List<Wish>> getWishes() async {
    final List<Wish> list = [];
    var tmp = await _db.collection('wishes').get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) {
        print(element.data());
        var wish = Wish.fromMap(element.data());
        list.add(wish);
        print(wish.toString());
        print(list.length);
      });
      return list;
    });
    return list;
  }

  void addWish(Wish wish) {
    _db.collection('wishes').add(wish.toMap());
    notifyListeners();
  }

  bool editWish(Wish editedWish) {
    var result = false;
    _db.collection('wishes').doc(editedWish.id).set(
        {"content": editedWish.content}, SetOptions(merge: true)).then((_) {
      result = true;
    });
    notifyListeners();

    return result;
  }

  bool deleteWish(String id) {
    var result = false;
    _db.collection('wishes').doc(id).delete().then((_) {
      result = true;
    });
    notifyListeners();

    return result;
  }
}
