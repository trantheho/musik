import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../internal/utils/app_assets.dart';
import '../internal/utils/style.dart';

enum MainTab{
  music('/feed'),
  favorite('/favorite'),
  search('/search'),
  profile('/profile');

  const MainTab(this.path);
  final String path;
}


class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({Key? key, required this.child}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.orange,
          unselectedItemColor: AppColors.grey177,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _item(MainTab.music),
            _item(MainTab.favorite),
            _item(MainTab.search),
            _item(MainTab.profile),
          ],
          currentIndex: _currentIndex,
          onTap: _tapBottomBar,
        ),
      ),
    );
  }

  void _tapBottomBar(int index) {
    String path = MainTab.music.path;
    if(index == 0) path = MainTab.music.path;
    if(index == 1) path = MainTab.favorite.path;
    if(index == 2) path = MainTab.search.path;
    if(index == 3) path = MainTab.profile.path;

    if(index != _currentIndex) context.go(path);
  }

  int getIndexFromTab(MainTab tab){
    switch(tab){
      case MainTab.music:
        return 0;
      case MainTab.favorite:
        return 1;
      case MainTab.search:
        return 2;
      case MainTab.profile:
        return 3;
      default:
        return 0;
    }
  }

  int _locationToTabIndex(String location) {
    final index = MainTab.values.indexWhere((tab) => location.startsWith(tab.path));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  BottomNavigationBarItem _item(MainTab tab){
    String icon;
    switch (tab) {
      case MainTab.music:
        icon = AppIcons.icMusical;
        break;
      case MainTab.favorite:
        icon = AppIcons.icHeart;
        break;
      case MainTab.search:
        icon = AppIcons.icSearch;
        break;
      case MainTab.profile:
        icon = AppIcons.icAccount;
        break;
      default:
        icon = AppIcons.icMusical;
        break;
    }

    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: Colors.black, width: 24, height: 24,),
      activeIcon: Image.asset(icon, color: AppColors.orange,width: 24, height: 24,),
      label: '',
    );
  }
}
