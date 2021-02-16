import 'package:flint_project/models/wishModel.dart';
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
        service.getWishes().then((value) {
          list = value;
        });
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (context, index) {
            var i = list[index].id;
            return ListTile(
              title: Text('${service.getWish(i).then((wish) => wish.content)}'),
            );
          },
        );
      }),
    );
  }
}
