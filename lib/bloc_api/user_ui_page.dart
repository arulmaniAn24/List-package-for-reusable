import 'package:first_app/bloc_api/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUiPage extends StatefulWidget {
  const UserUiPage({super.key});

  @override
  State<UserUiPage> createState() => _UserUiPageState();
}

class _UserUiPageState extends State<UserUiPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    // UI Implementation
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "user not Fetch data"
                  )
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserInitial) {
            return Center(
                child: Text(
                    'Initial state, nothing loaded yet'
                )
            );
          } else if (state is UserLoading) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else if (state is UserSuccess) {
            return ListView.builder(
              itemCount: state.userData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: ListTile(
                        title: Text(state.userData[index]['first_name'] + " " + state.userData[index]['last_name']),
                        subtitle: Text(state.userData[index]['email'] + " - " + state.userData[index]['id'].toString()),
                        leading: Image.network(state.userData[index]['avatar']),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          else if(state is UserFailure){
            return Center(
                child: Text("No users found")
            );
          }
          else {
            return Center(
                child: Text('something went wrong!')
            );
          }
        },
      ),
    );

  }
}
