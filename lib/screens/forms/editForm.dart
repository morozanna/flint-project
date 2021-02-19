import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final id;

  EditForm({this.id});

  @override
  Widget build(BuildContext context) {
    Wish wish;
    var _wish = Provider.of<WishService>(context, listen: false)
        .getWish(id)
        .then((value) {
      wish = value;
    });
    return FutureBuilder(
      future: _wish,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(); //TODO: add error screen
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var wishController = TextEditingController(text: wish.content);
          return Scaffold(
            body: Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Edit wish:',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: wishController,
                        decoration: InputDecoration(hintText: 'Enter wish'),
                        validator: (content) {
                          if (content.isEmpty || content.length < 3)
                            return 'Wish must be at least 3 characters long.';
                          return null;
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              wish.content = wishController.text;
                              var service = Provider.of<WishService>(context,
                                  listen: false);
                              service.editWish(wish);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
