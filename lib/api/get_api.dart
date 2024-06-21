import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
class GetApi extends StatefulWidget {
  const GetApi({super.key});

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  final dio = Dio();
  String apiResponse = "";
   String id = "";
  String name= "";
  String email= "";


  void getData() async {
    final response = await dio.get('https://reqres.in/api/users/2');
    setState(() {
      final userInfo = response.data['data'];
      apiResponse = userInfo.toString();
      id = userInfo['id'].toString();
      name = userInfo['first_name'] + " " + userInfo['last_name'];
      email = userInfo['email'];
    });

  }
  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Text(apiResponse),
              Text("Name: " + name),
              Text("Email: " + email),
              Text("Id:" + id ),
            ],
          )
      ),

    );
  }
}
