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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Add new wish'),
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: wishController,
                    decoration: InputDecoration(hintText: 'Enter wish'),
                    validator: (content) {
                      if (content.length < 3)
                        return 'Wish must be at least 3 characters long.';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              Text('Cancel', style: TextStyle(fontSize: 22))),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              var service = Provider.of<WishService>(context,
                                  listen: false);
                              service
                                  .addWish(Wish(content: wishController.text));
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 22),
                          )),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
