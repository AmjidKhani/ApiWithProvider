import 'package:apiprovider/Screens/Authentication/login.dart';
import 'package:apiprovider/Utils/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier{
  final Future<SharedPreferences> _preferences= SharedPreferences.getInstance();
  //setter
  String _token="";
  String _email="";
  //getter
String get token=>_token;
String get email=>_email;

// For Save Token
void saveToken(String token)async{
  SharedPreferences value=await _preferences;
  value.setString('token', token);
}
       //For Save Email
  void saveEmail(String email)async{
  SharedPreferences value=await _preferences;
  value.setString('email', email);
}
    //getting Token
Future<String> getToken()async{
  SharedPreferences value=await _preferences;
  if (value.containsKey('token')) {
    var data=value.getString('token');
    _token=data!;
    notifyListeners();
    return data;
  }
  else
  {
    _token="";
    notifyListeners();
    return "";
  }
}
   //Getting Email
  Future<String> getEmail()async{
    SharedPreferences value=await _preferences;
    if (value.containsKey('email')) {
      var data=value.getString('email');
      _email=data!;
      notifyListeners();
      return data;
    }
    else
    {
      _email="";
      notifyListeners();
      return "";
    }
}
void logout(BuildContext context)async{
  SharedPreferences value=await _preferences;
  value.clear();
  PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
}
}