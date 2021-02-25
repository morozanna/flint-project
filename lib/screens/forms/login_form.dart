import 'package:flint_project/utils/auth/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Login to admin account:',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Enter e-mail', icon: Icon(Icons.mail)),
                  validator: (mail) {
                    if (mail.isEmpty) return 'E-mail is required';
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      icon: Icon(Icons.enhanced_encryption)),
                  validator: (password) {
                    if (password.isEmpty) return 'Password is required';
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var auth =
                            Provider.of<Authentication>(context, listen: false);
                        String result = await auth.login(
                            emailController.text, passwordController.text);
                        if (result.startsWith('Error:')) {
                          return showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content:
                                      Text(result.replaceFirst('Error: ', '')),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Try again'))
                                  ],
                                );
                              });
                        } else
                          Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 22),
                    ))
              ],
            )),
      ),
    );
  }
}
