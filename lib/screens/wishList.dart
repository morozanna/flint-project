import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/screens/forms/editForm.dart';
import 'package:flint_project/screens/forms/sendSMSForm.dart';
import 'package:flint_project/utils/auth/authService.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    List<Wish> list = [];
    return Container(
      child: Consumer<WishService>(builder: (context, service, child) {
        var _wishes = service.getWishes().then((value) {
          list = value;
        });
        return FutureBuilder(
          future: _wishes,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(); //TODO: add error screen
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var i = list[index].id;
                  Wish _wish;
                  return Card(
                    color: Colors.blueGrey[800],
                    elevation: 20,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: FutureBuilder(
                          future: service.getWish(i).then((wish) {
                            _wish = wish;
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container();
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text('${_wish.content}');
                            }
                            return Container();
                          }),
                      trailing: getButtons(list, index, service),
                    ),
                  );
                },
              );
            }
            return Container(); //TODO: add loading screen
          },
        );
      }),
    );
  }

  Widget getButtons(List list, int index, WishService service) {
    var _auth = Provider.of<Authentication>(context);
    Wish wish = list[index];
    if (_auth.getUser() != null) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (context) {
                return SMSForm(wish);
              },
            );
          },
        ),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await service.deleteWish(id: wish.id);
            }),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return EditForm(id: wish.id);
                  });
            }),
      ]);
    } else {
      return IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return SMSForm(wish);
            },
          );
        },
      );
    }
  }
}
