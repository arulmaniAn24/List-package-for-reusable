import 'package:first_app/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CounterUiPage extends StatefulWidget {
  const CounterUiPage({super.key});

  @override
  State<CounterUiPage> createState() => _CounterUiPageState();
}

class _CounterUiPageState extends State<CounterUiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<CounterBloc, CounterState >(
        builder: (context,state){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.count.toString(),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        context.read<CounterBloc>().add(CountDecremant());
                        },
                      child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40,
                    ),
                    ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        print("Increment Clicked");
                        context.read<CounterBloc>().add(CountIncremant());
                        },
                      child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
