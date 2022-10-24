import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  late String aurl;



  @override
  void initState () {
    super.initState();
    remoteConfig.setDefaults(const {
      "getUrl": "aa",
    });
    aurl= remoteConfig.getString("myurl") ;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('myUrl: ${aurl}'),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}