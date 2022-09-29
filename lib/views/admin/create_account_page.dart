import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turks/views/admin/admin_home.dart';
import 'package:turks/widgets/appbar_widget.dart';
import 'package:turks/widgets/button_widget.dart';
import 'package:turks/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class CreateAccountPage extends StatelessWidget {
  late String name;
  late String username;
  late String password;
  late String confirmPassword;

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Crew'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/profile.png',
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  onChanged: (_input) {
                    name = _input;
                  },
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Name:', fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  onChanged: (_input) {
                    username = _input;
                  },
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Username:', fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (_input) {
                    password = _input;
                  },
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Password:', fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (_input) {
                    confirmPassword = _input;
                  },
                  decoration: InputDecoration(
                    label: TextRegular(
                        text: 'Confirm Password:',
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonWidget(
                  onPressed: () {
                    if (password == confirmPassword) {
                      if (password.length > 6) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: const Text(
                                    'Account Created Succesfully!',
                                    style: TextStyle(fontFamily: 'QRegular'),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () async {
                                        if (box.read('createAccount') ==
                                            'Crew') {
                                          try {
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: username.trim() +
                                                        '@crew.com',
                                                    password: password.trim());
                                          } catch (e) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      content: Text(
                                                        e.toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'QRegular'),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                            'Close',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'QRegular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                        } else {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: username.trim() +
                                                      '@admin.com',
                                                  password: password.trim());
                                        }
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminHome()));
                                      },
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: const Text(
                                    'Password too short',
                                    style: TextStyle(fontFamily: 'QRegular'),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: const Text(
                                  'Password do not match',
                                  style: TextStyle(fontFamily: 'QRegular'),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    }
                  },
                  text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}