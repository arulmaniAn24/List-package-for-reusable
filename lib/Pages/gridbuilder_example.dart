import 'package:flutter/material.dart';
class GridBuliderExample extends StatefulWidget {
  const GridBuliderExample({super.key});

  @override
  State<GridBuliderExample> createState() => _GridBuliderExampleState();
}

class _GridBuliderExampleState extends State<GridBuliderExample> {
  List <String> names = ["Home", "Setting", "Map", "Note", "Print", "Contacts", "YouTube" , "Swiggy", "Facebook"];
  List <IconData> icons = [Icons.home,Icons.settings,Icons.map,Icons.note,Icons.print,Icons.contacts,Icons.youtube_searched_for,Icons.emoji_food_beverage_outlined,Icons.face,];
  List <Color> colors = [Colors.purpleAccent.shade200,Colors.yellow,Colors.blueGrey.shade200,Colors.green.shade200,Colors.red.shade200,Colors.green.shade200,Colors.orangeAccent.shade200,Colors.purple.shade200, Colors.blue.shade200,];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(
          child: Text(
            "Grid View Builder",
            style: TextStyle(
              color: Colors.white
            )
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
            ),
            itemCount: names.length,
            itemBuilder: (context, index){
              return Card(
                color: colors[index],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], size: 40,),
                    Text(names[index], style: TextStyle(
                      fontSize: 20,
                    ),),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}

