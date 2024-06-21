import 'package:dynamic_home/dynamic_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DynamicHomeWidget extends StatefulWidget {
  const DynamicHomeWidget(
      {super.key,
      required this.homePageData,
      required this.leadingTitle,
      required this.currentLanguage});

  final String leadingTitle;
  final String currentLanguage;
  final HomePageData homePageData;

  @override
  State<DynamicHomeWidget> createState() => _DynamicHomeWidgetState();
}

class _DynamicHomeWidgetState extends State<DynamicHomeWidget> {
  late HomeWidgets _homeWidgets;
  late Home _home;
  late List<BodyWidget> _bodyWidget;
  late BottomNavigation _bottomNavigation;
  late TextEditingController _searchText;

  @override
  void initState() {
    super.initState();
    _home = widget.homePageData.home!;
    _homeWidgets = widget.homePageData.homeWidgets!;
    _bodyWidget = widget.homePageData.homeWidgets!.bodyWidget!;
    _bottomNavigation = widget.homePageData.homeWidgets!.bottomNavigation!;
    _searchText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> renderBodyWidgets({
      List<BodyWidget>? widgets,
      BuildContext? context,
      TextEditingController? search,
    }) {
      if (widgets == null) return [];
      return widgets.map((bodyWidget) {
        final type = bodyWidget.fieldValue;
        if (type == "favorite_list") {
          return Positioned(
            top: bodyWidget.bodyWidgetProps?.position?.top?.toDouble(),
            bottom: bodyWidget.bodyWidgetProps?.position?.bottom?.toDouble(),
            child: SizedBox(
              width: MediaQuery.of(context!).size.width,
              child: CustomFavoriteSlider(favWidget: bodyWidget),
            ),
          );
        } else if (type == "search_bar") {
          final hint = bodyWidget.placeHolder
              ?.firstWhere((x) => x.language == widget.currentLanguage)
              .value;
          void searchFuction(value) {
            if (kDebugMode) {
              print("Search Value $value");
            }
          }

          return Positioned(
            top: bodyWidget.bodyWidgetProps?.position?.top?.toDouble(),
            bottom: bodyWidget.bodyWidgetProps?.position?.bottom?.toDouble(),
            child: CustomSearchBar(
              controller: search!,
              hint: hint,
              onChanged: searchFuction,
              widget: bodyWidget,
              contentPadding: EdgeInsets.only(
                bottom:
                    bodyWidget.bodyWidgetProps!.padding!.bottom?.toDouble() ??
                        0,
                top: bodyWidget.bodyWidgetProps!.padding!.top?.toDouble() ?? 0,
                right:
                    bodyWidget.bodyWidgetProps!.padding!.right?.toDouble() ?? 0,
                left:
                    bodyWidget.bodyWidgetProps!.padding!.left?.toDouble() ?? 0,
              ),
            ),
          );
        }
        return Container();
      }).toList();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.leadingTitle,
        appBarWidget: _homeWidgets.appbarWidget!,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: renderBodyWidgets(
          widgets: _bodyWidget,
          context: context,
          search: _searchText,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigation: _bottomNavigation,
      ),
    );
  }
}
