

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exercise_day4/JsonPage.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liyana Exercise Day 4',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Liyana Flutter Layout')
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items =data.data as List<JsonPage>;
            return ListView.builder(
              itemCount: items == null? 0: items.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      //ROW
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                             child: CircleAvatar(
                               radius: 30,
                               backgroundColor: Colors.deepPurple[200],
                               backgroundImage: NetworkImage(items[index].avatar.toString()) ,
                               ),
                            //  child: CircleAvatar(backgroundColor: )
                            // Image(image: NetworkImage(items[index].avatar.toString())),
                          ),
                          Expanded(
                            child: Container(
                            padding: EdgeInsets.only(bottom: 8),
                            //COLUMN
                            child: Column (
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: [
                                Padding(
                                padding: EdgeInsets.only(left: 20,right: 8),
                                child: Text(items[index].first_name.toString() + " " + items[index].last_name.toString(),                          
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),
                                ),

                                Padding(padding: EdgeInsets.only(left: 20,right: 8, top:5),
                                child: Text(items[index].username.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                                ),),

                                Padding(padding: EdgeInsets.only(left: 20,right: 8, top: 5),
                                child: Text(
                                  items[index].status == null? " " : 
                                  items[index].status.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blueGrey,
                                  ),
                                  ),
                                )
                              ],
                            ),
                          ),),

                            Container(
                              child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: <Widget> [
                               Text(items[index].last_seen_time.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,),),
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.pink,
                                              child: Text(items[index].messages == null? "0" :items[index].messages.toString() ,
                                            style: TextStyle (color: Colors.white),
                                            )
                                            ),
                                            ], 
                              ), 
                               ),         
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

  Future<List<JsonPage>>ReadJsonData() async{
     final jsondata = await rootBundle.rootBundle.loadString('assets/MOCK_DATA_for_flutter_layouting.json');
     final list = json.decode(jsondata) as List<dynamic>;

     return list.map((e) => JsonPage.fromJson(e)).toList();
  }
  }



