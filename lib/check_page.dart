
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:my_test_remote_config/dummy_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}


class _CheckPageState extends State<CheckPage> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  late String path;
  //late String brand;
  late String path2;
  // -- ** RemoteConfig ** --
  @override
  void initState () {
    super.initState();
    //print('${androidDeviceInfo?.brand}');
    remoteConfig.setDefaults(const {
      "path": "",

    });
    path= remoteConfig.getString("myurl") ;

    WidgetsBinding.instance.addPostFrameCallback((_) async{

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 10),
      ));
      await remoteConfig.ensureInitialized();
      await remoteConfig.fetchAndActivate();
      print(remoteConfig.getString("myurl"));
    });
  }

  // -- ** SharedPreferences ** --
  static getURL() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('s') ?? '';
  }
  static setURL(String key, String nam) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, nam);
  }

  // -- ** DeviceInfoPlugin ** --
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
   getCore () async {
    String geti =await getURL();
    print('${geti}');
    if(geti.isNotEmpty){
      return geti;
    }else{
      final get1 = await Brand(true);
      final get2 = await Brand(false);
      final  get = await platform();
      geti = await loadScore("url");
      if(geti.isNotEmpty|| get2||get1){
        return "";
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
/*      home: FutureBuilder(

        builder: (context, checkController) {
          if{
            checkController.connectionState;
          }
        }),
      );*/
        home: const DummyScreen(/*title: 'Flutter test Home Page'*/));

  }

  static Brand(bool bool) {}

  static loadScore(String s) {}
}
