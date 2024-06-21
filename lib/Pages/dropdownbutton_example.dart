// import 'package:flutter/material.dart';
// class DropDownExample extends StatefulWidget {
//   const DropDownExample({super.key});
//
//   @override
//   State<DropDownExample> createState() => _DropDownExampleState();
// }
//
// class _DropDownExampleState extends State<DropDownExample> {
//   List<String> subjects = ["Tamil","English", "Maths", "Science"];
//   String dropdownValue = "Tamil";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: DropdownButton(
//           style: TextStyle(color: Colors.red,fontSize: 30,),
//           dropdownColor: Colors.yellowAccent,
//           value: dropdownValue,
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownValue = newValue!;
//             });
//
//           },
//           items: subjects
//               .map<DropdownMenuItem<String>>((String value){
//                 return DropdownMenuItem(
//                   child: Text(value),
//                   value: value,
//                 );
//           }
//           ).toList(),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DropDownExample extends StatefulWidget {
  const DropDownExample({super.key});

  @override
  State<DropDownExample> createState() => _DropDownExampleState();
}

class _DropDownExampleState extends State<DropDownExample> {
  List<String> sub = ["evs", "gk", "VE", "English"];
  String dropdown = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: DropdownButton(
              isExpanded: true,
              borderRadius: BorderRadius.circular(20),
              value: dropdown,
              onChanged: (String? newValue){
                setState(() {
                  dropdown = newValue!;
                });
              },
              items: sub
                  .map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem(
                    child: Text(value),
                      value: value,
                    );
                  }
                ).toList(),
                ),
          ),
        ),
      ),
    );
  }
}
