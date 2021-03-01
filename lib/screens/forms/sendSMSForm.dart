import 'package:flint_project/models/historyModel.dart';
import 'package:flint_project/models/wishModel.dart';
import 'package:flint_project/utils/services/historyService.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SMSForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  final fromController = TextEditingController();
  final Wish wish;

  SMSForm(this.wish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Send wish'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Selected wish:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 20),
                Text(
                  wish.content,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 20),
                Text(
                  'Send to:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Enter phone number'),
                  validator: (number) {
                    if (number.isEmpty || number.length != 9)
                      return 'Phone number must have 9 digits';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'From:',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: fromController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                  validator: (name) {
                    if (name.length < 3)
                      return 'Name must be at least 3 characters long';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  var _wishService = Provider.of<WishService>(
                                      context,
                                      listen: false);
                                  var _wish = _wishService.getDocRef(wish.id);
                                  var service = Provider.of<HistoryService>(
                                      context,
                                      listen: false);
                                  service.addHistory(History(
                                      dateSend: new DateTime.now(),
                                      phoneNr: int.parse(numberController.text),
                                      wishRef: _wish));
                                  //TODO:add send sms function

                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'Send',
                                style: TextStyle(fontSize: 22),
                              ))
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
