import 'dart:convert';
import 'dart:io';
import 'package:apiprovider/Constants/url.dart';
import 'package:apiprovider/HomePage.dart';
import 'package:apiprovider/Provider/Databaserovider/db_provider.dart';
import 'package:apiprovider/Screens/Authentication/login.dart';
import 'package:apiprovider/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Auth extends ChangeNotifier{

  // setter
  String _message="";
  bool _isLoading=false;
 String postUrl= AppUrl.baseUrl;
      //getter
  String get message{
    return _message;
  }
  bool get isLoading {
   return  _isLoading;
  }


  // Register
  void registerUser(
      {

        required String email,
        required String password,
        required BuildContext context,
})async
  {
    _isLoading=true;
    notifyListeners();
    String url="$postUrl/api/register";

     Map body={
       "email":email,
        "password": password

    } ;
    try{
      http.Response response=await http.post(Uri.parse(url),
      body: body

      );
      if (response.statusCode == 200||response.statusCode==201) {
        //print(response.body);
        //for seeing token
var data=jsonDecode(response.body.toString());
print(data['token']);
print(data);
        print('Success');
        print(response.statusCode);
        _message="Account Created Successfully";
        _isLoading=false;

        notifyListeners();
void navigate() {
  Future.delayed(const Duration(seconds: 3), () {
    PageNavigator(ctx: context).nextPage(page: LoginPage());
});
  }  }
      else{
        print(response.statusCode);
        print('Eroror message ');
        //final resserror=json.decode(response.body);
        //print(resserror);
        _isLoading=false;
        notifyListeners();
      }
    }
    on SocketException catch(_){
      print(' Socket Errororo');
     _isLoading=false;
      _message="Error Please check internet connection";
     notifyListeners();
    }
    catch(e){
      print('Catch Errororo');
      print(e.toString());
      _isLoading=false;
      _message="Error During loading";
      notifyListeners();
    }
  }

  //Login

  void loginUser(
      {
        required String email,
        required String password,
        required BuildContext context,
      })async
  {
    _isLoading=true;
    notifyListeners();
    Map body={

        "email": email,
        "password": password
    };
    String url="$postUrl/api/login";
    try{
      http.Response response=await http.post(Uri.parse(url),
        body:body

      );
      if (response.statusCode==200||response.statusCode==201) {
        print(response.body);
        print('Success');
        _message="User Login Successfully";
        _isLoading=false;

        var data=json.decode(response.body);
        print(data);
        notifyListeners();
        var userToken=data['token'];
        print("UserToken is =$userToken");
        DatabaseProvider().saveToken(userToken);

        PageNavigator(ctx: context).nextPage(page: HomePage());



      }
      else{
        print('Eroror ');

        print(response.statusCode);
        //final resserror=json.decode(response.body);
        //print(resserror);
        //_message=resserror['message'];
        _isLoading=false;
        notifyListeners();
      }
    }
    on SocketException{
      print('Errororo');
      _isLoading=false;
      _message="Error Please check internet connection";
      notifyListeners();
    }
    catch(e){
      print('Errororo');
      print(e.toString());
      _isLoading=false;
      _message="Error During loading";
      notifyListeners();
    }
  }
  Clear(){
    _message="";
    notifyListeners();
  }
}
