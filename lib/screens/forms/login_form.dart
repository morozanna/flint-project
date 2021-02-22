import 'package:flutter/material.dart';

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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
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
