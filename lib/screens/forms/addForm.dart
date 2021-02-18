import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final wishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Add new wish:',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        print('działa?');
                        var service =
                            Provider.of<WishService>(context, listen: false);
                        service.addWish(Wish(content: wishController.text));
                        Navigator.of(context).pop();
                        // Consumer<WishService>(
                        //     builder: (context, service, child) {
                        //   var _addFun =
                        //       service.addWish(Wish(wishController.text));
                        //   return FutureBuilder(
                        //     future: _addFun,
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasError) {
                        //         return Container(); //TODO: add error screen
                        //       }
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.done) {
                        //         Navigator.of(context).pop();
                        //       }
                        //       return Container(); //TODO:add loading screen
                        //     },
                        //   );
                        // });
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 22),
                    ))
              ],
            )),
      ),
    );
  }
}
