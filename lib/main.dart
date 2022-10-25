import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:my_test_remote_config/stop_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // This widget is the root of your application.
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  final remoteConfig = FirebaseRemoteConfig.instance;


  late String path;
  late String path2;



  @override
  void initState () {
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        builder: (context, AsyncSnapshot<FirebaseRemoteConfig>snapshot) {
          if (path.isEmpty ){
            return DummyScreen();
          }else{
            return MyHomePage(title: '${path}');
          }
        }),
      );/*const MyHomePage(title: 'Flutter test Home Page')*/
    
  }
}

