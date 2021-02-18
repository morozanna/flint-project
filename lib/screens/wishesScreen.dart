import 'package:flint_project/screens/forms/addForm.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'historyBtn',
                    onPressed: () {},
                    tooltip: 'Show history',
                    child: Icon(Icons.history),
                  ),
                  FloatingActionButton(
                    heroTag: 'addBtn',
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AddForm();
                        },
                      );
                    },
                    tooltip: 'Add new wish',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            )));
  }
}
