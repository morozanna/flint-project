import 'package:flint_project/screens/wishList.dart';
import 'package:flutter/material.dart';

class WishesScreen extends StatefulWidget {
  WishesScreen({Key key}) : super(key: key);

  @override
  _WishesScreenState createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishes List'),
      ),
      body: WishList(),
    );
  }
}
