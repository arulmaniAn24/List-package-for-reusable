import 'dart:js_interop_unsafe';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GetData_Api extends StatefulWidget {
  const GetData_Api({super.key});

  @override
  State<GetData_Api> createState() => _GetData_ApiState();
}

class _GetData_ApiState extends State<GetData_Api> {
  final dio = Dio();
  List <dynamic> userData = [];
  void testData () async {
    final response  = await dio.get('https://reqres.in/api/users');
    // print(response.data.toString());
    setState(() {
      userData = response.data['data'];
    });
  }

  @override
  void initState(){
    testData ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: userData.length,
          itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                child: ListTile(
                  title: Text(userData[index]['first_name'] +" "+ userData[index]['last_name']),
                  subtitle: Text(userData[index]['email'] + "-" + userData[index]['id'].toString()),
                  leading: Image.network(userData[index]['avatar'].toString()),
                ),
              ),
              Container(
                  height: 30,
                  width: 30,
                  // padding: EdgeInsets.only(top:  30),
                  child: Image.network(userData[index]['avatar'].toString()),
                ),
            ],
          );
        }
        )
      );
  }
}
