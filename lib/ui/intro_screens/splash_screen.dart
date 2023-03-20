import 'package:absher_rider/helpers/session_helper.dart';
import 'package:absher_rider/models/user.dart';
import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../providers/location/location_provider.dart';
import '../../ui/common_widgets/build_slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/public_methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getPageData() async {
    // Future.delayed(Duration(seconds: 5)).then((value) =>);
    if(await getSession() == null){
      Navigator.pushReplacementNamed(context, "language_screen");
    }else{
      UserProvider provider = context.read<UserProvider>();
      await provider.fetchUser();
      if (provider.isLogin)
        Navigator.pushNamedAndRemoveUntil(
            context, main_screen, (val) => false);
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LocationProvider>().getCurrentLocation();
    });
    getPageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/splash_screen_bg.png",
                width: getWidth(context),
                fit: BoxFit.fill,
              )),
          BuildSlideTransition(
            animationDuration: 1100,
            curve: Curves.elasticInOut,
            child: Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 180,
                // height: 140,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
