import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mzady/provider/main_provider.dart';
import 'package:mzady/screens/favorites/favorites_screen.dart';
import 'package:mzady/screens/home/home_screen.dart';
import 'package:mzady/screens/search/search_screen.dart';
import 'package:mzady/screens/settings/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../add_item_screen/add_item_screen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'homeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context, listen: false);
    if (provider.user == null) provider.initUserManually();
    // provider.getAdminID();
    if (provider.isDataLoaded == false) provider.getLocalProducts();
    print('=====Home layout build');
    return Scaffold(
      // body: kIsWeb ?HomeScreen():PersistentTabView(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Theme.of(context).colorScheme.background,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SearchScreen(),
      AddItemScreen(),
      FavoritesScreen(),
      ProfileScreen(),

      // Container(color: Colors.cyanAccent,child:Center(child: Text('Home Screen',style: TextStyle(fontSize:16),),)),
      // Container(color: Colors.lightBlueAccent,child:Center(child: Text('Search Screen',style: TextStyle(fontSize:16),),)),
      // Container(color: Colors.redAccent,child:Center(child: Text('Add Product',style: TextStyle(fontSize:16),),)),
      // Container(color: Colors.yellowAccent,child:Center(child: Text('Favorites',style: TextStyle(fontSize:16),),)),
      // Container(color: Colors.greenAccent,child:Center(child: Text('Settings',style: TextStyle(fontSize:16),),)),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: (AppLocalizations.of(context)!.home),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: (AppLocalizations.of(context)!.search),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        title: (AppLocalizations.of(context)!.add),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite_border_outlined),
        title: (AppLocalizations.of(context)!.favorites),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        title: (AppLocalizations.of(context)!.profile),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
