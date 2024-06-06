import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model_class/Model_Class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ModelClass> userList=[];


  getDataFunction() async {
    var data=await FirebaseFirestore.instance.collection('user').get();
    print(data.docs.length);
    for(var e in data.docs){
      setState(() {
        userList.add(ModelClass.fromData(e.data()));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context,index){
        return Column(
          children: [
            Text(userList[index].email!,style: TextStyle(fontSize: 25),),
          ],
        );
      }),
    );
  }
}
