import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/screens/forms/editForm.dart';
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
                    color: Colors.blueGrey[300],
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
                      trailing: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {}, //TODO:add popup to send
                      ),
                      onTap: () {
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return EditForm(id: i);
                          },
                        );
                      },
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
}
