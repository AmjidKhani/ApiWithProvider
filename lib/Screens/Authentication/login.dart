import 'package:apiprovider/Provider/Auth/authentication.dart';
import 'package:apiprovider/Screens/Authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/routers.dart';
import '../../Utils/snack_message.dart';
import '../../Widgets/button.dart';
import '../../Widgets/text_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
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
                    /// Button Start
                    /// 
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
                         if (_email.text.isEmpty||_password.text.isEmpty) {
                           showMessage(
                             context: context,
                             message: "Email or password Must not be empty",
                           );
                         }  
                      Authvalue.loginUser(email: _email.text.trim(), password: _password.text.trim(), context: context);
                      },
                    text:"Login"

                        );
                        } ,

                    ),
                    /// button ends

                    const SizedBox(
                      height: 10,
                    ),

                    GestureDetector(
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: const RegisterPage());
                      },
                      child: const Text('Register Instead'),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
