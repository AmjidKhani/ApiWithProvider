import 'package:apiprovider/Provider/Databaserovider/db_provider.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
    actions: [
      IconButton(
          onPressed: (){
        DatabaseProvider().logout(context);
      }, icon: const Icon(Icons.logout)
      )
    ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Home Page")),
        ],
      ),
    );
  }
}
