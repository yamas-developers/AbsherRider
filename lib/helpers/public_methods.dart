import 'package:absher_rider/helpers/color/light.dart';
import 'package:absher_rider/helpers/session_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui' as ui;
import '../providers/location/location_provider.dart';
import '../providers/settings/settings_provider.dart';
import '../ui/common_widgets/misc_widgets.dart';
import 'app_loader.dart';
import 'constants.dart';

enum AlertType { INFO, WARNING, ERROR, SUCCESS }

String infoIcon = 'assets/icons/alert/info.png';
String successIcon = 'assets/icons/alert/success.png';
String warningIcon = 'assets/icons/alert/warning.png';
String errorIcon = 'assets/icons/alert/error.png';

double getSize(
    BuildContext context, double width, double maxWidth, double minWidth) {
  double mwidth = MediaQuery.of(context).size.width * width;
  // print("width -> ${mwidth}->maxWidth ${maxWidth}-> minWidth ${minWidth}");
  double size = mwidth;
  if (mwidth > maxWidth) {
    size = maxWidth;
  }
  if (mwidth < minWidth) {
    size = minWidth;
  }
  // print("siax as ${size}");
  return size;
}

getWidth(context) {
  return MediaQuery.of(context).size.width;
}

getHeight(context) {
  return MediaQuery.of(context).size.height;
}

getLargestSide(context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return height > width ? height : width;
}

getSmallestSide(context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return height < width ? height : width;
}

isPortrait(context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}

Widget sbh(v) {
  return SizedBox(
    height: v.toDouble(),
  );
}

Widget sbw(v) {
  return SizedBox(
    width: v.toDouble(),
  );
}

String getString(String key) {
  key = key.toLowerCase();
  if (key != '') {
    return tr(key) != null ? tr(key) : '';
  } else {
    return '';
  }
}

double convertDouble(num) {
  try {
    // print(num);
    if (num is double) {
      return num;
    }
    if (num != null) {
      double? a = double.tryParse(num);
      // print("a");
      // print(a);
      return a == null ? 0 : a;
    } else {
      // print("herenum");
      return 0;
    }
  } catch (e) {
    print(e);
    return 0;
  }
}

int convertNumber(num) {
  try {
    // print(num);
    if (num is int) {
      return num;
    }
    if (num != null) {
      int? a = int.tryParse(num);
      // print("a");
      // print(a);
      return a == null ? 0 : a;
    } else {
      // print("herenum");
      return 0;
    }
  } catch (e) {
    print(e);
    return 0;
  }
}

showAlertDialog(context, title, message,
    {type = AlertType.INFO,
    okButtonText = 'Ok',
    onPress = null,
    showCancelButton = true,
    dismissible = true}) {
  String icon;

  switch (type) {
    case AlertType.INFO:
      icon = infoIcon;
      break;
    case AlertType.SUCCESS:
      icon = successIcon;
      break;
    case AlertType.WARNING:
      icon = warningIcon;
      break;
    case AlertType.ERROR:
      icon = errorIcon;
      break;
    default:
      icon = infoIcon;
  }

  showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder: (_, anim, __, child) {
        var begin = 0.5;
        var end = 1.0;
        var curve = Curves.bounceOut;
        if (anim.status == AnimationStatus.reverse) {
          curve = Curves.fastLinearToSlowEaseIn;
        }
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: anim.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext alertContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(dismissible);
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          // Center(
                          //   child: Image.asset(
                          //     icon,
                          //     width: 50,
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${title}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text("$message"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (showCancelButton)
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(alertContext).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                              if (onPress != null)
                                TextButton(
                                  onPressed: onPress,
                                  child: Text("$okButtonText"),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

showAlertDialogWithOutContext(title, message,
    {type = AlertType.INFO,
    okButtonText = 'Ok',
    onPress = null,
    showCancelButton = true,
    dismissible = true}) {
  String icon;

  switch (type) {
    case AlertType.INFO:
      icon = infoIcon;
      break;
    case AlertType.SUCCESS:
      icon = successIcon;
      break;
    case AlertType.WARNING:
      icon = warningIcon;
      break;
    case AlertType.ERROR:
      icon = errorIcon;
      break;
    default:
      icon = infoIcon;
  }

  GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(dismissible);
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Center(
                          child: Image.asset(
                            icon,
                            width: 50,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${title}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("$message"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (showCancelButton)
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  // Navigator.pop(globalKey.currentContext)
                                },
                                child: Text("Cancel"),
                              ),
                            if (onPress != null)
                              TextButton(
                                onPressed: onPress,
                                child: Text("$okButtonText"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
      navigatorKey: globalKey,
      transitionDuration: Duration(milliseconds: 400),
      transitionCurve: Curves.fastLinearToSlowEaseIn);
}

// BuildSlideTransition(child, animationDuration, {startPos = 1.0, endPos = 0.0, curve = Curves.easeInOut}){
//   animationDuration += 300;
//   return TweenAnimationBuilder(
//     tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
//     duration: Duration(milliseconds: animationDuration),
//     curve: curve,
//     builder: (context, Offset offset, child) {
//       return FractionalTranslation(
//         translation: offset,
//         child: child,
//       );
//     },
//     child: child,
//   );
// }

Widget smartRefreshFooter(BuildContext context, LoadStatus? mode) {
  Widget body;
  // print(mode);
  if (mode == LoadStatus.idle) {
    body = Text("pull up load");
  } else if (mode == LoadStatus.loading) {
    body = AppLoader(
      size: 30.0,
      strock: 1,
    );
  } else if (mode == LoadStatus.failed) {
    body = Text("Load Failed!Click retry!");
  } else if (mode == LoadStatus.canLoading) {
    body = Text("release to load more");
  } else {
    body = Text("No more Data");
  }
  return Center(child: body);
}

void showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0);
}

bool isLtr(context) {
  return Directionality.of(context).toString() == 'TextDirection.ltr';
}

getTextDirection(context) {
  return isLtr(context) ? ui.TextDirection.ltr : ui.TextDirection.rtl;
}

getTextAlignStart(context) {
  return isLtr(context) ? TextAlign.left : TextAlign.right;
}

Animation<Color?> createColorTween(AnimationController controller) {
  return controller.drive(
    ColorTween(
      begin: mainColor,
      end: mainColorLightest,
    ).chain(CurveTween(curve: Curves.easeInOutCubic)),
  );
}

String convertTimestampToAgo(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('h:mm a');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}

String capitalizeFirstLetter(String inputString) {
  if (inputString == null || inputString.isEmpty) {
    return '';
  }
  return inputString[0].toUpperCase() + inputString.substring(1);
}

showProgressDialog(context, message, {isDismissable = true}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    routeSettings: RouteSettings(name: "progress_dialog"),
    builder: (buildContext) => AlertDialog(
      content: Row(
        // direction: Axis.horizontal,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
              Image.asset(
                "assets/images/app_logo.png",
                width: 50,
                height: 50,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(child: Text("${message}")),
        ],
      ),
    ),
  );
}
showProgressDialogWithoutContext(message, {isDismissable = true}) {
  Get.dialog(
    AlertDialog(
        content: Row(
          // direction: Axis.horizontal,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
                Image.asset(
                  "assets/images/app_logo.png",
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(child: Text("${message}")),
          ],
        ),
      ),
    barrierDismissible: false,
    routeSettings: RouteSettings(name: "progress_dialog"),
    );
}
hideProgressDialogWithoutContext(){
  Get.back();
}

showSnakeBar(title, message,
    {type = AlertType.INFO,
    okButtonText = 'Ok',
    onPress = null,
    showCancelButton = true,
    dismissible = true}) {
  String icon;

  switch (type) {
    case AlertType.INFO:
      icon = infoIcon;
      break;
    case AlertType.SUCCESS:
      icon = successIcon;
      break;
    case AlertType.WARNING:
      icon = warningIcon;
      break;
    case AlertType.ERROR:
      icon = errorIcon;
      break;
    default:
      icon = infoIcon;
  }

  Get.snackbar(
    title,
    message,
    colorText: TmLight.permanentWhiteColor,
    icon: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Center(
        child: Image.asset(
          icon,
          width: 50,
        ),
      ),
    ),
    mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
        },
        child: Text(
          "Close",
          style: TextStyle(color: TmLight.permanentWhiteColor),
        )),
    backgroundColor: TmLight.primaryDarkColor.withOpacity(.4),
    duration: Duration(milliseconds: 4000),
    dismissDirection: DismissDirection.startToEnd,
  );
}

getDayMonthFromDate(date){
  try {
    DateTime dateTime = DateTime.parse('$date');
    String month = DateFormat('MMMM', 'en_US').format(dateTime);
    String day = dateTime.day.toString();
    return {"day": day, "month": month};
  }catch(e){
    return {"day": "", "month": ""};
  }
}

shiftTimeFormate(time) {
  try {
    DateTime dateTime = DateTime.parse('1970-01-01T$time');
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    if (formattedTime.isEmpty) {
      return '';
    }
    return formattedTime;
  } catch (e) {
    print(e);
    return '';
  }
}

String shiftTimeDifferenceHours(t1, t2) {
  try {
    DateTime dateTime = DateTime.parse('1970-01-01T$t2');
    DateTime dateTime2 = DateTime.parse('1970-01-01T$t1');
    var hours = dateTime.difference(dateTime2).inHours;
    return hours.toString();
  } catch (e) {
    return '';
  }
}

bool lightModeOn(context) => Theme.of(context).brightness == Brightness.light;

hideProgressDialog(context, {ModalRoute? route: null}) {
  Navigator.of(context).pop();
}

void logInfo(msg) {
  debugPrint('\x1B[34m$msg\x1B[0m');
}

// Green text
void logSuccess(msg) {
  debugPrint('\x1B[32m$msg\x1B[0m');
}

// Yellow text
void logWarning(msg) {
  debugPrint('\x1B[33m$msg\x1B[0m');
}

// Red text
void logError(msg) {
  debugPrint('\x1B[31m$msg\x1B[0m');
}

List<Widget> safeguardConnectivityAndService(
    {required BuildContext context, required List<Widget> widgets}) {
  SettingsProvider settingsProvider = context.read<SettingsProvider>();
  if (settingsProvider.loading) return [LoadingWidget()];
  if (!settingsProvider.locationPermission)
    return [NoLocationPermissionsWidget()];
  if (!settingsProvider.isConnected/*||true*/) return [NoNetworkWidget()];
  else if (!settingsProvider.operatingArea /*||true*/)
    return [NoServiceAreaWidget()];
  return widgets;
}

getSettingsData({required BuildContext context, showToast = false, bool shouldGetCurrentLocation = true}) async {
  LocationProvider locProvider = context.read<LocationProvider>();
  SettingsProvider settingsProvider = context.read<SettingsProvider>();

  if (!settingsProvider.isInitialized) settingsProvider.loading = true;
  await settingsProvider.requestPermissions(toast: showToast);

  if (settingsProvider.locationPermission) {
    logSuccess("location permission available");
    if(shouldGetCurrentLocation)
      await locProvider.getCurrentLocation();
    if (locProvider.currentLocation != null) {
      await settingsProvider.getSettings(locProvider.currentLocation);
    }
  }
  settingsProvider.loading = false;
}

getTokenParam() async {
  String token = (await getSession())??'';
  return '?token=$token';

}
