import 'package:flint_project/models/wishModel.dart';
import 'package:flutter/material.dart';

class SMSForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  final fromController = TextEditingController();
  final Wish wish;

  SMSForm(this.wish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Selected wish:',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(wish.content),
              Text('Send to:',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(hintText: 'Enter phone number'),
                validator: (number) {
                  if (number.length != 9) return 'Invalid phone number';
                  return null;
                },
              ),
              Text('From:',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: fromController,
                decoration: InputDecoration(hintText: 'Enter your name'),
                validator: (name) {
                  if (name.length < 3)
                    return 'Name must be at least 3 characters long';
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //TODO:add send sms function
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 22),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
