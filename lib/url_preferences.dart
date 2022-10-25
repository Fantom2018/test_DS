import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlPreferences{
  static const _keyUrl = 'path' ;
  // static Future init() async{
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  // }
  static SharedPreferences _preferences = SharedPreferences.getInstance() as SharedPreferences;

  static Future serUrl(String path) async =>
      await _preferences.setString(_keyUrl, path );
  print(path) {
    // TODO: implement print
    throw UnimplementedError();
  }
}