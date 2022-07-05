import 'package:couple_jet/ui/reusable/gradient_round_button.dart';
import 'package:couple_jet/ui/screens/bottom_nav_bar/widgets/middle_button.dart';
import 'package:couple_jet/ui/screens/chat_list_screen/chat_list_screen.dart';
import 'package:couple_jet/ui/screens/feed_screen/feed_screen.dart';
import 'package:couple_jet/ui/screens/main_card_screen/main_card_screen.dart';
import 'package:couple_jet/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      FeedScreen(),
      MainCardSwiperScreen(),
      ChatListScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 0,
        icon: Icon(Icons.view_day_rounded),
        title: ("Discover"),
        activeColorPrimary: kBlue,
        inactiveColorPrimary: kBlue,
      ),
      PersistentBottomNavBarItem(
        iconSize: 80,
        icon: BottomNavButton(
            icon: Icons.view_carousel_rounded,
            width: 80,
            height: 80,
            iconSize: 36),
        title: (" "),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.question_answer_rounded),
        title: ("Messages"),
        activeColorPrimary: kTeal,
        inactiveColorPrimary: kTeal,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double widthScale = MediaQuery.of(context).size.width / 414;
    final double heightScale = MediaQuery.of(context).size.height / 896;
    return PersistentTabView(
      context,
      navBarHeight: 70 * heightScale,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          Theme.of(context).primaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20 * widthScale),
            topRight: Radius.circular(20 * widthScale)),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
