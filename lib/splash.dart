import 'package:apiprovider/Provider/Databaserovider/db_provider.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Screens/Authentication/login.dart';
import 'Utils/routers.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
     PageNavigator(ctx: context).nextPage(page: LoginPage());
     DatabaseProvider().getToken().then((value) {
       if (value=="") {
         PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
       }
       else{
         PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
       }
     });

    }
    );
  }
}
