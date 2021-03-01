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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Edit wish'),
            ),
            body: Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: wishController,
                          decoration: InputDecoration(hintText: 'Enter wish'),
                          maxLines: null,
                          validator: (content) {
                            if (content.isEmpty || content.length < 3)
                              return 'Wish must be at least 3 characters long.';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel',
                                          style: TextStyle(fontSize: 22))),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          wish.content = wishController.text;
                                          var service =
                                              Provider.of<WishService>(context,
                                                  listen: false);
                                          service.editWish(wish);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 22),
                                      ))
                                ]))
                      ],
                    )),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
