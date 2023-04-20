import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:maanstore/const/hardcoded_text.dart';
import 'package:maanstore/screens/profile_screen/profile_screen.dart';
import 'package:maanstore/screens/search_product_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/constant_1.dart';
import '../../const/constants.dart' as consts;
import '../../const/hardcoded_text_arabic.dart';
import '../Auth_Screen/auth_screen_1.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screens/home_screen.dart';
import '../order_screen/my_order.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int customerId = 0;

  Future<void> checkId() async {
    final prefs = await SharedPreferences.getInstance();
    customerId = prefs.getInt('customerId')!;
  }

  @override
  void initState() {
    checkId();
    super.initState();
  }

  final iconList = <IconData>[
    FeatherIcons.home,
    FeatherIcons.search,
    IconlyLight.document,
    FeatherIcons.user,
  ];
  int _bottomNavIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: consts.isRtl ? TextDirection.rtl : TextDirection.ltr,

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: watchMainColor,
          onPressed: () {
            const CartScreen().launch(context);
          },
          child: const Icon(
            // ignore: deprecated_member_use
            FontAwesomeIcons.shoppingBag,
            color: Colors.white,
          ),
        ),
        drawer: const HomeScreen(),
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            const HomeScreen(),
            const SearchProductScreen(),
            customerId != 0 ? const MyOrderScreen() : const AuthScreen(),
            customerId != 0 ? const ProfileScreen() : const AuthScreen(),
          ],
        ),
        // body: _widgetOptions.elementAt(_bottomNavIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(iconList[index],
                        color: _bottomNavIndex == index
                            ? watchMainColor
                            : watchGreyTextColor),
                    Text(
                      consts.isRtl ? HardcodedTextArabic.iconTitle[index] : HardcodedTextEng.iconTitle[index],
                      style: kTextStyle.copyWith(
                          color: _bottomNavIndex == index
                              ? watchMainColor
                              : watchGreyTextColor),
                    ),
                  ],
                ),
              ],
            );
          },
          backgroundColor: Colors.white,
          activeIndex: _bottomNavIndex,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
        ),
      ),
    );
  }
}
