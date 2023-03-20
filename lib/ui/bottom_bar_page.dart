import 'dart:io';

import 'package:absher_rider/ui/orders/order_screen.dart';
import 'package:absher_rider/ui/shifts/status_screen.dart';
import 'package:absher_rider/ui/wallet/wallet_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase/firebase_helper.dart';
import '../helpers/public_methods.dart';
import '../helpers/route_constants.dart';
import '../models/user.dart';
import '../providers/user/user_provider.dart';
import '../search_screen.dart';
import 'account_screen.dart';
import 'home/home_screen.dart';
import 'home/map_view.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({Key? key}) : super(key: key);

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  int currentIndex = 1;
  User? user;
  getPageData() async {
    // int random = Random().nextInt(30);
    UserProvider userProvider = context.read<UserProvider>();
    FirebaseHelper firebaseHelperProvider = context.read<FirebaseHelper>();
    user = userProvider.currentUser;
    if(user != null){
      firebaseHelperProvider.initNewOrder(user!.id,onSuccess: (DatabaseEvent event) async {
        showToast("You have an incoming order");
        AudioPlayer player = AudioPlayer();
        await player.setSource(AssetSource('sounds/notification_sound.wav'));
        player.resume();
        Map data = event.snapshot.value as Map;
        if(data['order_id'] != null){
          Navigator.pushNamed(context, incoming_order_screen,arguments: {"order":data["order_id"]});
        }
      },onError: (error){

      });
    }
  }
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getPageData();
      getSettingsData(context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setCurrentIndex(int index) {
    if(index == currentIndex)return;
    currentIndex = index;
    setState(() {});
  }

  Widget getCurrentWidget() {
    if (currentIndex == 0) return SlideUpWidget(
        key: UniqueKey(),
        child: StatusScreen());
    if (currentIndex == 2) return SlideUpWidget(
        key: UniqueKey(),
        child: MapView());
    if (currentIndex == 1) return SlideUpWidget(
        key: UniqueKey(),
        child: OrderScreen());
    // if (currentIndex == 3) return WalletScreen();
    if (currentIndex == 4) return SlideUpWidget(
        key: UniqueKey(),
        child: AccountScreen());

    if (currentIndex == 3)
      return SlideUpWidget(
        key: UniqueKey(),
        child: WalletScreen(),
      );
    return SlideUpWidget(
        key: UniqueKey(),

        child: MapView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 1,
      ),
      body: getCurrentWidget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: SizedBox(
      //   width: getSize(context, .20, 120, 80),
      //   child: Visibility(
      //     visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //     child: FloatingActionButton.large(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           SizedBox(
      //             height: 0,
      //           ),
      //           Image.asset(
      //             "assets/icons/home.png",
      //             width: getSize(context, .09, 44, 30),
      //             height: 34,
      //             color: currentIndex == 5 ? mainColor : lightGreyColor,
      //           ),
      //           SizedBox(height: 4),
      //           Text(
      //             "Home",
      //             style: TextStyle(
      //               color: currentIndex == 5 ? mainColor : lightGreyColor,
      //               fontSize: getSize(context, .03, 14, 12),
      //               // fontWeight: FontWeight.bold
      //             ),
      //           )
      //         ],
      //       ),
      //       backgroundColor: Colors.white,
      //       onPressed: () {
      //         setCurrentIndex(5);
      //         // Overlay.of(context)!.insert(entry);
      //       },
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9.0,
        // color: Colors.transparent,
        // elevation: 0,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, .02, 10, 6)),
          height: getSize(context, .20, 80, 60),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: kIsWeb
                ? CrossAxisAlignment.center
                : Platform.isIOS
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
            children: <Widget>[

              GestureDetector(
                  onTap: () {
                    setCurrentIndex(0);
                  },
                  child: BottomBarItem(
                    currentIndex: currentIndex,
                    title: "Status",
                    icon: 'assets/icons/check.png',
                    itemIndex: 0,)),
              // SizedBox(height: 30,),
              GestureDetector(
                  onTap: () {
                    setCurrentIndex(1);
                  },
                  child: BottomBarItem(
                      currentIndex: currentIndex,
                      title: "Orders",
                      icon: 'assets/icons/order_icon.png',
                      itemIndex: 1)),
              GestureDetector(
                  onTap: () {
                    setCurrentIndex(2);
                  },
                  child: BottomBarItem(
                    currentIndex: currentIndex,
                    title: "Map",
                    icon: 'assets/icons/pin_on_map.png',
                    itemIndex: 2,)),
              GestureDetector(
                onTap: () {
                  setCurrentIndex(3);
                },
                child: BottomBarItem(
                    currentIndex: currentIndex,
                    icon: 'assets/icons/wallet.png',
                    title: "Wallet",
                    itemIndex: 3),
              ),
              GestureDetector(
                onTap: () {
                  setCurrentIndex(4);
                },
                child: BottomBarItem(
                    currentIndex: currentIndex,
                    icon: 'assets/icons/user.png',
                    title: "Account",
                    itemIndex: 4),
              ).marginOnly(right: 0),

            ],
          ),
        ),
      ),
    );
  }
}

class SlideUpWidget extends StatelessWidget {
  const SlideUpWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)),
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn,

        builder: (context, offset, _child) {
          return FractionalTranslation(
              translation: offset,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 400, end: 0),
                duration: const Duration(milliseconds:300),
                curve: Curves.easeIn,
                builder: (BuildContext context, double value, childd) {
                  return ClipRRect(
                    // borderRadius: BorderRadius.circular(value),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(value),
                      topLeft: Radius.circular(value),
                    ),
                    // clipper: MyClip(value: 30),
                    child: childd!,
                  );
                },
                child: child,
              ));
        });
  }
}

class MyClip extends CustomClipper<Rect> {
  const MyClip({
    Key? key,
    required this.value,
  });

  final double value;

  Rect getClip(Size size) {
    return Rect.fromPoints(Offset(100, 10), Offset(800, 0));
  }

  bool shouldReclip(oldClipper) {
    return true;
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key? key,
    required this.currentIndex,
    required this.itemIndex,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final int currentIndex;
  final int itemIndex;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: getSize(context, .1, 40, 30),
          color: currentIndex == itemIndex ? mainColorLight : lightGreyColor,
        ),
        Text(
          title,
          style: TextStyle(
            color: currentIndex == itemIndex ? mainColorLight : lightGreyColor,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
