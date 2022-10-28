import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}


class _CheckPageState extends State<CheckPage> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  late String path;
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

      print(remoteConfig.getString(""));
      print(remoteConfig.getString("myurl"));
    });
  }

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


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
