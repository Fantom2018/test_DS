import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  get ada => remoteConfig.getString('myurl');
  @override
  void initState () {
    super.initState();
    var prefs = _prefs;
  }
  @override
  Widget build(BuildContext context) {
    //ada() => remoteConfig.getString('myurl');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: '${ada}',
      )

    );
  }
}
//***********
// Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Center(
//         child: Text('${ada}'),
//       )
//
//     ],
//   ),
// ),
// This trailing comma makes auto-formatting nicer for build methods.

// *****************

//var ada = title;
// remoteConfig.setDefaults(const {
//   "path": "",
// });
// path= remoteConfig.getString("myurl") ;
//
// WidgetsBinding.instance.addPostFrameCallback((_) async{
//
//   await remoteConfig.setConfigSettings(RemoteConfigSettings(
//     fetchTimeout: const Duration(seconds: 10),
//     minimumFetchInterval: Duration(seconds: 10),
//   ));
//   await remoteConfig.ensureInitialized();
//   await remoteConfig.fetchAndActivate();
//   print(remoteConfig.getString(""));
//   print(remoteConfig.getString("myurl"));
// });