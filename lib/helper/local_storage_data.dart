import 'dart:convert';

import 'package:get/get.dart';
import 'package:karima/const.dart';
import 'package:karima/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData extends GetxController{
  Future<UserModel?> get getUser async{
    try {
      UserModel? userModel = await _getUserData();
      if(userModel == null){
        return null;
      }
      return userModel;
    } catch (e) {
        print(e.toString());
        return null;
    }
  }
  
  _getUserData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = pref.getString(CACHED_USER_DATA)!;
    return UserModel.fromjson(json.decode(value));
  }

  setUser(UserModel usermodel) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(CACHED_USER_DATA, json.encode(usermodel.tojson()));
  }

  void deleteUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}