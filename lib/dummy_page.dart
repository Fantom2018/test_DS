import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'model/product_data_model.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({Key? key}) : super(key: key);

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
    Future <List<ProductDataModel>>? newsFutures;

  @override
  void initState(){
   super.initState();
   newsFutures = getNews(context);
   print(newsFutures.toString());
  }

  static Future<List<ProductDataModel>> getNews(BuildContext context) async{
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/news.json');
    final body = jsonDecode(data);

    return body.map<ProductDataModel>(ProductDataModel.fromJson).toList();

 }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: FutureBuilder(
            future: ReadJsonData(),
            builder: (context,data){
              if(data.hasError){
                return Center(child: Text("${data.error}"));
              }else if(data.hasData){
                var items =data.data as List<ProductDataModel>;
                return ListView.builder(
                    itemCount: items == null? 0: items.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Image(image: NetworkImage(items[index].imageUrl.toString()),fit: BoxFit.fill,),
                              ),
                              Expanded(child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].name.toString(),style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),),),
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Price: \$" +items[index].price.toString()),
                                        Text("Residue:  " +items[index].residue.toString()),

                                      ],
                                    ),)
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    }
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
      );
    }
    Future<List<ProductDataModel>>ReadJsonData() async{
      final jsondata = await rootBundle.rootBundle.loadString('assets/news.json');
      final list = json.decode(jsondata) as List<dynamic>;

      return list.map((e) => ProductDataModel.fromJson(e)).toList();
    }

}
/*Center(
        child: Container(

          width: double.infinity,
          height: 200,
          color: Colors.red,
          child: Center(child: Text('Заглушка', style: TextStyle(fontSize: 30))),
        ),
      )*/