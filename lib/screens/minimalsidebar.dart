import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minimalpage/utils/json_loader.dart';
import 'package:minimalpage/utils/responsive.dart';
import 'package:minimalpage/widgets/dashedline.dart';
import 'package:minimalpage/models/menu.dart';

class MinimalPage extends StatefulWidget {
  const MinimalPage({super.key});

  @override
  _MinimalPageState createState() => _MinimalPageState();
}

class _MinimalPageState extends State<MinimalPage> {
  bool isExpanded = true;
  String? hoveredItem;
  String? selectedItem;
  String? selectedSubMenu;
  Offset hoveredPosition = Offset.zero;
  bool hoverContainerEntered = false;
  bool isHovered = false;
  Map<String, bool> subMenuExpandedState = {};
  List<String> breadcrumbs = ['Dashboard'];
  List<Widget> contentPages = [
    const Center(child: Text('Dashboard Content')),
  ];
  Map<String, GlobalKey> menuKeys = {
    'User': GlobalKey(),
    'Product': GlobalKey(),
    'Order': GlobalKey(),
    'Invoice': GlobalKey(),
    'Settings': GlobalKey(),
  };

  Map<String, bool> itemHoverState = {};

  List<MenuItem> menuItems = [];
  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    List<MenuItem> items = await loadMenuItems();
    setState(() {
      menuItems = items;
      for (var item in menuItems) {
        menuKeys[item.title] = GlobalKey();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: buildMobileLayout(),
      tablet: buildTabletLayout(),
      desktop: buildDesktopLayout(),
    );
  }

  Widget buildMobileLayout() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              //   const Text('Minimal Page'),
              _buildBreadcrumbsHeader(),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBreadcrumbHierarchy(),
              Expanded(
                child: contentPages.last,
              ),
            ],
          ),
        ),
        drawer: Drawer(
          width: 250,
          clipBehavior: Clip.none,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.green.shade50,
                  Colors.purple.shade50,
                ],
                stops: const [0.1, 0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logo.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Management",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return _buildMenuItemWithSubmenu(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          buildSidebar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBreadcrumbs(),
                Expanded(
                  child: contentPages.last,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          buildSidebar(),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBreadcrumbs(),
                      Expanded(
                        child: contentPages.last,
                      ),
                    ],
                  ),
                ),
                if (!isExpanded && hoveredItem != null)
                  Positioned(
                    top: _getHoverContainerPosition(menuKeys[hoveredItem]!).dy,
                    child: _buildHoverContainer(context),
                  ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        icon: Icon(
                          isExpanded
                              ? Icons.arrow_forward_ios
                              : Icons.arrow_back_ios,
                          color: Colors.grey,
                          size: 15,
                        ),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                            selectedItem = null;
                          });
                        },
                      ),
                    ),
                    const Expanded(
                      child: VerticalDashedLine(
                        height: 750,
                        color: Colors.grey,
                        dashWidth: 1.0,
                        dashGap: 3.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSidebar() {
    return AnimatedContainer(
      width: isExpanded ? 250 : 100,
      duration: const Duration(milliseconds: 300),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.04,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "images/logo.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                if (isExpanded)
                  const Text(
                    "Management",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return _buildMenuItemWithSubmenu(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedSubMenu != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedSubMenu!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: BreadCrumb(
              items: breadcrumbs.map((crumb) {
                final isLast = breadcrumbs.last == crumb;
                return BreadCrumbItem(
                  content: Text(
                    crumb,
                    style: TextStyle(
                      color: isLast ? Colors.black : Colors.grey,
                      fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    if (!isLast) {
                      setState(() {
                        while (breadcrumbs.last != crumb) {
                          breadcrumbs.removeLast();
                          contentPages.removeLast();
                        }
                        selectedSubMenu = breadcrumbs.last == selectedItem
                            ? selectedSubMenu
                            : null;
                      });
                      context.goNamed(crumb.toLowerCase().replaceAll(' ', ''));
                    }
                  },
                );
              }).toList(),
              divider: const Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuItemTap(int index) {
    if (index < 0 || index >= menuItems.length) {
      print('Invalid index: $index');
      return;
    }
    final menuItem = menuItems[index];

    setState(() {
      if (selectedItem != menuItem.title) {
        breadcrumbs.clear();
        breadcrumbs.add('Dashboard');
        breadcrumbs.add(menuItem.title);

        contentPages.clear();
        contentPages.add(Center(child: Text('${menuItem.title} Content')));

        selectedSubMenu = '';

        if (menuItem.routeName != null) {
          try {
            context.goNamed('/${menuItem.title.toLowerCase()}');
            selectedItem = menuItem.title;
          } catch (e) {
            print('Navigation error: $e');
          }
        } else if (menuItem.submenuItems?.isNotEmpty ?? false) {
          setState(() {
            subMenuExpandedState[menuItem.title] =
                !(subMenuExpandedState[menuItem.title] ?? false);
          });
          selectedItem = menuItem.title;
        } else {
          print(
              'Route name is null for ${menuItem.title} and no sub-menu items to expand');
        }
      } else {
        selectedItem = null;
      }
    });
  }

  Widget _buildBreadcrumbsHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (selectedSubMenu != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedSubMenu!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbHierarchy() {
    return BreadCrumb(
      items: breadcrumbs.map((crumb) {
        final isLast = breadcrumbs.last == crumb;
        return BreadCrumbItem(
          content: Text(
            textAlign: TextAlign.start,
            crumb,
            style: TextStyle(
              color: isLast ? Colors.black : Colors.grey,
              fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: () {
            if (!isLast) {
              setState(() {
                while (breadcrumbs.last != crumb) {
                  breadcrumbs.removeLast();
                  contentPages.removeLast();
                }
              });
            }
          },
        );
      }).toList(),
      divider: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  Widget _buildMenuItemWithSubmenu(int index) {
    final menuItem = menuItems[index];
    final isSelected = _isSelected(index);
    final isSubMenuVisible = selectedItem == menuItem.title;

    return MouseRegion(
      onEnter: (event) {
        if (!isExpanded) {
          setState(() {
            hoveredItem = menuItem.title;
            itemHoverState[menuItem.title] = true;
          });
        }
      },
      onExit: (event) {
        if (!isExpanded && !hoverContainerEntered) {
          setState(() {
            hoveredPosition = event.localPosition;
            itemHoverState[menuItem.title] = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _handleMenuItemTap(index);
              },
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    itemHoverState[menuItem.title] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    itemHoverState[menuItem.title] = false;
                  });
                },
                child: Container(
                  key: menuKeys[menuItem.title],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.green[300]?.withOpacity(0.2)
                        : itemHoverState[menuItem.title] ?? false
                            ? Colors.grey[300]?.withOpacity(0.2)
                            : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (isExpanded)
                            SizedBox(
                              height: 22.0,
                              width: 22.0,
                              child: SvgPicture.network(
                                menuItem.icon,
                                color: isSelected
                                    ? Colors.green[200]
                                    : Colors.grey,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (isExpanded) const SizedBox(width: 8),
                          if (isExpanded)
                            Text(
                              menuItem.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.green[200]
                                    : Colors.grey,
                              ),
                            ),
                          const Spacer(),
                          if (isExpanded)
                            Icon(
                              isSubMenuVisible
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey,
                              size: 20,
                            ),
                        ],
                      ),
                      if (!isExpanded)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child: SvgPicture.network(
                                      menuItem.icon,
                                      color: isSelected
                                          ? Colors.green[200]
                                          : Colors.grey,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    menuItem.title,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.green[200]
                                          : Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isExpanded)
                              Padding(
                                padding: const EdgeInsets.only(top: 7.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: isExpanded ? 14.0 : 12.0,
                                  color: isSelected
                                      ? Colors.green[200]
                                      : Colors.grey,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (isExpanded && isSubMenuVisible)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var subMenuItem in menuItem.submenuItems ?? [])
                    _buildSubMenuItem(menuItem, subMenuItem),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenuItem(MenuItem menuItem, SubMenu subMenuItem) {
    bool isSelected = selectedSubMenu == subMenuItem.title;
    bool isExpanded = subMenuExpandedState[subMenuItem.title] ?? false;

    return Padding(
      padding: const EdgeInsets.only(
        top: 6.0,
        left: 8,
      ),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            itemHoverState[subMenuItem.title] = true;
          });
        },
        onExit: (_) {
          setState(() {
            itemHoverState[subMenuItem.title] = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.green[100]?.withOpacity(0.1)
                : itemHoverState[subMenuItem.title] ?? false
                    ? Colors.grey[300]?.withOpacity(0.1)
                    : null,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: InkWell(
            onTap: () {
              setState(() {
                //  selectedSubMenu = subMenuItem.title;

                if (selectedItem != null) {
                  final currentMenuItemIndex =
                      breadcrumbs.indexOf(selectedItem!);
                  if (currentMenuItemIndex != 1) {
                    breadcrumbs.removeRange(
                        currentMenuItemIndex + 1, breadcrumbs.length);
                  }
                }
                breadcrumbs.add(subMenuItem.title);

                contentPages.clear();
                contentPages.add(
                  Center(
                    child: Text('${subMenuItem.title} Content'),
                  ),
                );

                context.go('/${menuItem.title.toLowerCase()}');

                if (subMenuItem.submenuItems?.isNotEmpty ?? false) {
                  subMenuExpandedState[subMenuItem.title] =
                      !(subMenuExpandedState[subMenuItem.title] ?? false);
                }
              });
              // final routeName =
              //     subMenuItem.title.toLowerCase().replaceAll(' ', '-');
              // if (routeName.isNotEmpty) {
              //   context.go('/$routeName');
              // }

              if (ResponsiveLayout.isMobile(context)) {
                Navigator.of(context).pop();
              }
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: isSelected ? Colors.green[200] : Colors.grey,
                      ),
                    ),
                    SizedBox(width: isExpanded ? 8 : 0),
                    Expanded(
                      child: Text(
                        subMenuItem.title,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.grey,
                          fontSize: isExpanded ? 14.0 : 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var subSubmenuItem
                            in subMenuItem.submenuItems ?? [])
                          _buildSubMenuItem(menuItem, subSubmenuItem),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoverContainer(BuildContext context) {
    List<Widget> subMenuItems = [];

    if (hoveredItem == 'User') {
      subMenuItems = [
        _buildClickableSubMenuItem('Profile'),
        _buildClickableSubMenuItem('Cards'),
        _buildClickableSubMenuItem('List'),
        _buildClickableSubMenuItem('Create'),
        _buildClickableSubMenuItem('Edit'),
        _buildClickableSubMenuItem('Account'),
      ];
    } else if (hoveredItem == 'Product') {
      subMenuItems = [
        _buildClickableSubMenuItem('List'),
        _buildClickableSubMenuItem('Details'),
        _buildClickableSubMenuItem('Create'),
        _buildClickableSubMenuItem('Edit'),
      ];
    } else if (hoveredItem == 'Order') {
      subMenuItems = [
        _buildClickableSubMenuItem('List'),
        _buildClickableSubMenuItem('Details'),
      ];
    } else if (hoveredItem == 'Invoice') {
      subMenuItems = [
        _buildClickableSubMenuItem('Pending'),
        _buildClickableSubMenuItem('Completed'),
      ];
    } else if (hoveredItem == 'Settings') {
      subMenuItems = [];
    } else {
      subMenuItems = [];
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoverContainerEntered = true;
        });
      },
      onExit: (_) {
        setState(() {
          hoveredItem = null;
          hoverContainerEntered = false;
        });
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Colors.green[50]!.withOpacity(0.5),
                Colors.white.withOpacity(0.5),
                Colors.pink[50]!.withOpacity(0.5),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subMenuItems,
          ),
        ),
      ),
    );
  }

  Widget _buildClickableSubMenuItem(String text) {
    bool isSelected = selectedSubMenu == text;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          itemHoverState[text] = true;
        });
      },
      onExit: (_) {
        setState(() {
          itemHoverState[text] = false;
        });
      },
      child: InkWell(
        onTap: () {
          setState(() {
            selectedSubMenu = text;

            int menuItemIndex =
                menuItems.indexWhere((item) => item.title == hoveredItem);

            selectedItem = menuItems[menuItemIndex].title;

            final currentMenuItemIndex = breadcrumbs.indexOf(selectedItem!);
            if (currentMenuItemIndex != 1) {
              breadcrumbs.removeRange(
                  currentMenuItemIndex + 1, breadcrumbs.length);
            }
            breadcrumbs.add(text);

            contentPages.clear();
            contentPages.add(Center(child: Text('$text Content')));
            // if (hoveredItem == 'User' && text == 'Edit') {
            //   context.go('user/profile/edit');
            // } else {
            //   context
            //       .go('/${selectedItem!.toLowerCase()}/${text.toLowerCase()}');
            // }

            context.go('/${selectedItem!.toLowerCase()}/${text.toLowerCase()}');
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green[100]?.withOpacity(0.1)
                  : itemHoverState[text] ?? false
                      ? Colors.grey[300]?.withOpacity(0.1)
                      : null,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: isSelected ? Colors.green[200] : Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isSelected(int index) {
    final menuItem = menuItems[index];
    return selectedItem == menuItem.title;
  }

  Offset _getHoverContainerPosition(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    return position;
  }
}
