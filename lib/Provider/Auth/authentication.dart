import 'dart:convert';
import 'dart:io';
import 'package:apiprovider/Constants/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  //crear message
  Clear(){
    _message="";
    notifyListeners();
  }
  // Register
  void registerUser(
      {
        required String firstName,
        required String lastName ,
        required String email,
        required String password,
        required BuildContext context,
})async
  {
    _isLoading=true;
    notifyListeners();
    String url="$postUrl/users/";

    final body={
      {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      }
    };
    try{
      http.Response response=await http.post(Uri.parse(url),
      body: json.encode(body));
      if (response.statusCode==200||response.statusCode==201) {
        if (kDebugMode) {
          print(response.body);
        }
        print('Success');
        _message="Account Created Successfully";
        notifyListeners();
      }  
      else{
        print(response.statusCode);

        print('Eroror ');
        final resserror=json.decode(response.body);
        print(resserror);
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
    final body={
      {
        "email": email,
        "password": password
      }
    };
    try{
      http.Response response=await http.post(Uri.parse("$postUrl+/users/login"),
        body: json.encode(body));
      if (response.statusCode==200||response.statusCode==201) {
        print(response.body);
        print('Success');
        _message="User Login Successfully";
        notifyListeners();
      }
      else{
        print('Eroror ');
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
      _isLoading=false;
      _message="Error During loading";
      notifyListeners();
    }
  }
}
