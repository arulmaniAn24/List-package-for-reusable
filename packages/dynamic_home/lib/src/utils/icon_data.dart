import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIcon(String input) {
  switch (input) {
    case 'home':
      return Icons.home;
    case 'profile':
      return Icons.person;
    case 'help':
      return Icons.headset_mic;
    case 'learn':
      return FontAwesomeIcons.book;
    case 'alert':
      return Icons.notifications;
    case 'menu':
      return Icons.menu;
    case 'add':
      return Icons.add;
    case 'settings':
      return Icons.settings;
    case 'account':
      return Icons.account_circle;
    case 'user':
      return Icons.person;
    case 'employees':
      return Icons.group;
    case 'address':
      return Icons.account_tree;
    case 'roles':
      return Icons.supervisor_account;
    default:
      return Icons.error;
  }
}
