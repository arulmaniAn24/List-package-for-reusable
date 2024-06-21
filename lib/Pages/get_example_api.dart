import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class GetExample extends StatefulWidget {
  const GetExample({super.key});

  @override
  State<GetExample> createState() => _GetExampleState();
}

class _GetExampleState extends State<GetExample> {
  var userInfo = "";
  List<dynamic> users = [];
  final dio = Dio();
   void getUserInfo(int id) async {
     print('https://reqres.in/api/users/$id');
     if(mounted) {
       final response = await dio.get('https://reqres.in/api/users/$id');
       if (response.statusCode == 200) {
         setState(() {
           userInfo = response.data.toString();
           //print(userInfo);
         });
       }
     }
   }
  Future<void> getUsers() async {
     if(mounted){
       final response = await dio.get('https://reqres.in/api/users');
       if (response.statusCode == 200) {
         //print(response.data['data']);
         setState(() {
           users = response.data['data'];
         });
       }
     }
   }
   @override
   void initState(){
     getUsers();
   }

   @override
   void dispose() {
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(userInfo),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(users[index]['first_name'] + " " + users[index]['last_name']),
                    subtitle: Text(users[index]['email'] + "-" + users[index]['id'].toString()),
                    // trailing: IconButton(
                    //     onPressed: () {
                    //       getUserInfo(users[index]['id']);
                    //     },
                    //     icon: Icon(Icons.account_circle)
                    // ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
