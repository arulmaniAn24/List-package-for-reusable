// import 'package:dynamic_home/src/themes/themes.dart';
import 'package:dynamic_home/dynamic_home.dart';
import 'package:dynamic_home/src/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({super.key});

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.white,
//       type: BottomNavigationBarType.shifting,
//       items: <BottomNavigationBarItem>[
//         _buildBottomNavigationBarItem(
//             icon: Icons.home, label: 'Home', isSelected: _selectedIndex == 0),
//         _buildBottomNavigationBarItem(
//             icon: Icons.headset_mic,
//             label: 'Support',
//             isSelected: _selectedIndex == 1),
//         _buildBottomNavigationBarItem(
//             icon: Icons.book, label: 'Learn', isSelected: _selectedIndex == 2),
//         _buildBottomNavigationBarItem(
//             icon: Icons.notifications,
//             label: 'Notifications',
//             isSelected: _selectedIndex == 3),
//       ],
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//     );
//   }
// }

// BottomNavigationBarItem _buildBottomNavigationBarItem(
//     {required IconData icon, required String label, required bool isSelected}) {
//   return BottomNavigationBarItem(
//     icon: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: isSelected ? Colors.grey[200] : Colors.transparent,
//         border: isSelected
//             ? Border.all(
//                 color: Colors.grey[300]!,
//                 width: 2.0,
//               )
//             : null,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Icon(
//             icon,
//             color: isSelected ? Colors.grey[700]! : Colors.grey,
//           ),
//           if (isSelected)
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(
//                 label,
//                 style: Styles.navigation(
//                     isSelected ? Colors.grey[700]! : Colors.grey),
//               ),
//             ),
//         ],
//       ),
//     ),
//     label: '',
//   );
// }

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.navigation, this.onTap});

  final BottomNavigation navigation;
  final void Function(int)? onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;
  late BottomNavigationProps _props;

  @override
  void initState() {
    super.initState();
    _props = widget.navigation.bottomNavigationProps!;
    _selectedIndex = _props.currentIndex ?? 0;
  }

  void _onItemTapped(int index) {
    if (kDebugMode) {
      print("tapped");
    }
    setState(() {
      _selectedIndex = index;
      // widget.onTap!(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> renderNavigationItem({
      List<Item>? items,
      BuildContext? context,
    }) {
      if (items == null) return [];

      return items.asMap().entries.map((entry) {
        int index = entry.key;
        Item item = entry.value;
        return _buildNavItem(
          icon: getIcon(item.icon!.iconName!),
          label: item.label!,
          index: index,
        );
      }).toList();
    }

    return Container(
      color: Colors.grey[200],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: renderNavigationItem(items: _props.items, context: context),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            maxRadius: 32,
            backgroundColor:
                isSelected ? Colors.grey.shade300 : Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  size: isSelected ? 30 : 24,
                  color: Colors.black,
                ),
                const SizedBox(height: 2.0),
                isSelected
                    ? const SizedBox()
                    : Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
