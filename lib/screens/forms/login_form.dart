import 'package:flint_project/utils/auth/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login to admin account'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var auth = Provider.of<Authentication>(context,
                                    listen: false);
                                String result = await auth.login(
                                    emailController.text,
                                    passwordController.text);
                                if (result.startsWith('Error:')) {
                                  return showDialog(
                                      context: _scaffoldKey.currentContext,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(result.replaceFirst(
                                              'Error: ', '')),
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
                            )),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
