class MenuItem {
  final String icon;
  final String title;
  final String releaseType;
  final List<SubMenu>? submenuItems;
  final String? routeName;

  MenuItem({
    required this.icon,
    required this.title,
    this.routeName,
    required this.releaseType,
    this.submenuItems,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      icon: json['icon'] ?? '',
      title: json['title'] ?? '',
      releaseType: json['release_type'] ?? '',
      submenuItems: (json['menu_items'] as List<dynamic>?)
          ?.map((e) => SubMenu.fromJson(e))
          .toList(),
      routeName: json['navigation_path'],
    );
  }
}

class SubMenu {
  final String title;
  final String releaseType;
  final List<SubMenu>? submenuItems;
  final String? routeName;
  SubMenu({
    required this.title,
    required this.releaseType,
    this.routeName,
    this.submenuItems,
  });

  factory SubMenu.fromJson(Map<String, dynamic> json) {
    return SubMenu(
      title: json['title'] ?? '',
      releaseType: json['release_type'] ?? '',
      submenuItems: (json['menu_items'] as List<dynamic>?)
          ?.map((e) => SubMenu.fromJson(e))
          .toList(),
      routeName: json['navigation_path'],
    );
  }
}
