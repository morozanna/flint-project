import 'package:flint_project/screens/forms/addForm.dart';
import 'package:flint_project/screens/forms/login_form.dart';
import 'package:flint_project/screens/historyScreen.dart';
import 'package:flint_project/screens/wishList.dart';
import 'package:flint_project/utils/auth/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishesScreen extends StatefulWidget {
  WishesScreen({Key key}) : super(key: key);

  @override
  _WishesScreenState createState() => _WishesScreenState();
}

class _WishesScreenState extends State<WishesScreen> {
  @override
  Widget build(BuildContext context) {
    var _auth = Provider.of<Authentication>(context);
    //var _user = _auth.getUser();

    return Scaffold(
        appBar: AppBar(
          title: Text('Wishes List'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                if (_auth.getUser() == null) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return LoginForm();
                    },
                  );
                } else
                  _auth.logout();
              },
              child: Text(
                () {
                  if (_auth.getUser() != null)
                    return 'Logout';
                  else
                    return 'Login';
                }(),
              ),
            )
          ],
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
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return HistoryView();
                          });
                    },
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
