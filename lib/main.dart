

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:my_test_remote_config/controllers/check_controller.dart';
import 'package:my_test_remote_config/dummy_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'check_page.dart';
import 'home_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CheckPage checkPage = const CheckPage();
  // This widget is the root of your application.
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  // *************
  final remoteConfig = FirebaseRemoteConfig.instance;
  // ************
  CheckController checkController = CheckController();
/*  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidDeviceInfo;
  var device = DeviceInfoPlugin();
  Future<AndroidDeviceInfo> getInfo()async{
    return await deviceInfo.androidInfo;
  }
  Future  Device ()async{
    if(Platform.isAndroid){
      var androidInfo = await device.androidInfo;
      return androidInfo.brand;
    }

  }*/







  // @override
  // void initState () {
  //   super.initState();
  //   //print('${androidDeviceInfo?.brand}');
  //   remoteConfig.setDefaults(const {
  //     "path": "",
  //
  //   });
  //   path= remoteConfig.getString("myurl") ;
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) async{
  //
  //     await remoteConfig.setConfigSettings(RemoteConfigSettings(
  //       fetchTimeout: const Duration(seconds: 10),
  //       minimumFetchInterval: Duration(seconds: 10),
  //     ));
  //     await remoteConfig.ensureInitialized();
  //     await remoteConfig.fetchAndActivate();
  //
  //     print(remoteConfig.getString(""));
  //     print(remoteConfig.getString("myurl"));
  //   });
  // }
  @override
  Widget build(BuildContext context) {

    return const CheckPage();

    
  }
}

