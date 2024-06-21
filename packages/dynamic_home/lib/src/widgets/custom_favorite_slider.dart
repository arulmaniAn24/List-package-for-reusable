import 'package:dynamic_home/dynamic_home.dart';
import 'package:dynamic_home/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFavoriteSlider extends StatefulWidget {
  const CustomFavoriteSlider({super.key, required this.favWidget});
  final BodyWidget favWidget;

  @override
  CustomFavoriteSliderState createState() => CustomFavoriteSliderState();
}

class CustomFavoriteSliderState extends State<CustomFavoriteSlider> {
  int _currentIndex = 0;

  static Widget _buildFunctionalityItem(
      IconData icon, String label, double? size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: size ?? 30,
          backgroundColor: Colors.grey.shade700,
          child: FaIcon(
            icon,
            size: size ?? 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final int? favFlex = widget.favWidget.favFlex;
    final double iconSize = widget
            .favWidget.favorite?.menuItemProps?.size?.grid?.height!
            .toDouble() ??
        30;
    final favList = [
      _buildFunctionalityItem(getIcon('user'), 'Create Users', iconSize),
      _buildFunctionalityItem(
          getIcon('employees'), 'Manage Employees', iconSize),
      _buildFunctionalityItem(
          getIcon('address'), 'Create Address Hierarchy', iconSize),
      _buildFunctionalityItem(getIcon('roles'), 'Create Users roles', iconSize),
      _buildFunctionalityItem(
          getIcon('employees'), 'Manage Employees', iconSize),
      _buildFunctionalityItem(
          getIcon('address'), 'Create Address Hierarchy', iconSize),
      _buildFunctionalityItem(getIcon('roles'), 'Create Users roles', iconSize),
    ];

    final pages = favList.fold<List<List<Widget>>>([], (list, x) {
      if (list.isEmpty || list.last.length == (favFlex ?? 4)) {
        list.add([x]);
      } else {
        list.last.add(x);
      }
      return list;
    });

    return Column(
      children: [
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
            child: Text(
              "Functionalities",
              textAlign: TextAlign.start,
              style: Styles.heading_1,
            ),
          ),
        ),
        const SizedBox(height: 5),
        CarouselSlider.builder(
          itemCount: pages.length,
          itemBuilder: (BuildContext context, int pageIndex, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: pages[pageIndex].map((item) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / (favFlex ?? 4),
                  child: item,
                );
              }).toList(),
            );
          },
          options: CarouselOptions(
            height: 90 + iconSize,
            viewportFraction: 1.0,
            aspectRatio: 4 / 2,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pages.map((page) {
            int pageIndex = pages.indexOf(page);
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == pageIndex
                    ? const Color.fromRGBO(0, 0, 0, 0.9)
                    : const Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
