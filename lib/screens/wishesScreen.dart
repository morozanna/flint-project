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
      persistentFooterButtons: [
        FlatButton(
          onPressed: () {
            if (_auth.getUser() != null) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AddForm();
                },
              );
            } else {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Forbidden action'),
                      content: Text("Only admin can access this function."),
                      actions: [
                        TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.deepPurple[300]),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'))
                      ],
                    );
                  });
            }
          },
          child: Icon(Icons.add),
          // color: Colors.grey,
        ),
        FlatButton(
            onPressed: () {
              if (_auth.getUser() != null) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return HistoryView();
                    });
              } else {
                return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Forbidden action'),
                        content: Text("Only admin can access this function."),
                        actions: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.deepPurple[300]),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'))
                        ],
                      );
                    });
              }
            },
            child: Icon(Icons.history))
      ],
    );
  }
}
