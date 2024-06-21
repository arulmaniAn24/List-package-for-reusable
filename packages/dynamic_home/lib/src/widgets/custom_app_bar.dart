import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.title, required this.appBarWidget});
  final String title;
  final AppbarWidget appBarWidget;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: renderAppbarActions(appBarWidget.actions),
      backgroundColor:
          Color(int.parse(appBarWidget.actionProps!.backgroundColor!)),
      elevation: appBarWidget.actionProps!.elevation!.toDouble(),
    );
  }
}

List<Widget> renderAppbarActions(List<ActionClass>? actions) {
  if (actions == null) return [];

  return actions.map((action) {
    final padding = action.actionProps?.padding;
    return Padding(
      padding: EdgeInsets.only(
        top: padding?.top?.toDouble() ?? 0,
        bottom: padding?.bottom?.toDouble() ?? 0,
        left: padding?.left?.toDouble() ?? 0,
        right: padding?.right?.toDouble() ?? 0,
      ),
      child: _buildActionIcon(action),
    );
  }).toList();
}

Widget _buildActionIcon(ActionClass action) {
  if (kDebugMode) {
    print("Action Fields${action.fieldType}");
  }
  switch (action.fieldType) {
    case 'circular_avatar':
      return CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: IconButton(
          icon: FaIcon(
            getIcon(action.icon!.iconName!),
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      );
    case 'icon_button':
      return IconButton(
        icon: Icon(
          getIcon(action.icon!.iconName!),
          color: Colors.grey,
        ),
        onPressed: () {},
      );
    default:
      return Container();
  }
}
