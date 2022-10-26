import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckController extends GetxController {
  static getURL() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('s') ?? '';
  }
  static setURL(String key, String nam) async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.setString(key, nam);
    }

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidDeviceInfo;
  var devinfo = DeviceInfoPlugin();

  Future Data ()async{
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
  }
  Future <bool> brand (bool value)async{

    final inffo = await devinfo.androidInfo;
    final infoT =value? inffo.brand.contains("google"): !inffo.isPhysicalDevice;

    return (infoT);
  }
  Future <bool> platform ()async{
    String? platformVersion;
    try{
      platformVersion = (
      await FlutterSimCountryCode.simCountryCode);
    }on PlatformException{
      platformVersion = 'Failed';
    }

    return platformVersion?.length !=2;
  }
  static getCore () async {
    String geti =await getURL();
    if(geti.isNotEmpty){
      return geti;
    }else{

    }
  }

}

//final check1 = await Brand(true);