import 'package:apiprovider/Provider/Auth/authentication.dart';
import 'package:apiprovider/Utils/snack_message.dart';
import 'package:apiprovider/Widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/routers.dart';
import '../../Widgets/text_field.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'First Name',
                      controller: _firstName,
                      hint: 'Enter your first name',
                    ),
                    customTextField(
                      title: 'Last Name',
                      controller: _lastName,
                      hint: 'Enter your last name',
                    ),

                    customTextField(
                      title: 'Email',
                      controller: _email,
                      hint: 'Enter you valid email address',
                    ),
                    customTextField(
                      title: 'Password',
                      controller: _password,
                      hint: 'Enter your secured password',
                    ),
                    ///Button
                    Consumer<Auth>(
                      builder: (context, Authvalue, child) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

                          if (Authvalue.message.isNotEmpty) {
                            showMessage(
                                context: context,
                                message: Authvalue.message

                            );
                            Authvalue.Clear();
                          }
                        });
                        return customButton(
                            status: Authvalue.isLoading,
                            context: context,
                            tap: (){
                              if (_email.text.isEmpty||_password.text.isEmpty||_firstName.text.isEmpty||_lastName.text.isEmpty) {
                                showMessage(
                                  context: context,
                                  message: "All Fields Are Required",
                                );
                              }
                              Authvalue.registerUser(
                                  firstName: _firstName.text.trim(),
                                  lastName: _lastName.text.trim(),
                                  email: _email.text.trim(),
                                  password: _password.text.trim(),
                                  context: context
                              );
                                 },
                            text:"Register"

                        );
                      } ,

                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const LoginPage());
                      },
                      child: const Text('Login Instead'),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
