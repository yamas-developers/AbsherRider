import 'package:absher_rider/ui/incoming_order/incoming_order_screen.dart';
import '../helpers/route_constants.dart';
import '../shifts/all_shifts_screen.dart';
import '../ui/chat/chat_screen.dart';
import '../ui/home/home_screen.dart';
import '../ui/home/map_view.dart';
import '../ui/incoming_order/arrive_at_vendor_screen.dart';
import '../ui/incoming_order/dropoff_screen.dart';
import '../ui/incoming_order/go_to_customer_screen.dart';
import '../ui/incoming_order/pickup_screen.dart';
import '../ui/orders/thankyou_screen.dart';
import '../ui/profile/edit_profile.dart';
import '../ui/registeration/signup_screen.dart';
import '../ui/registeration/terms_and_condition_screen.dart';
import 'package:flutter/material.dart';

import '../search_screen.dart';
import '../ui/bottom_bar_page.dart';
import '../ui/intro_screens/language_screen.dart';
import '../ui/intro_screens/splash_screen.dart';
import '../ui/notification/notifications_screen.dart';
import '../ui/orders/order_detail_screen.dart';
import '../ui/orders/order_screen.dart';
import '../ui/registeration/login_screen.dart';
import '../ui/support/send_request_screen.dart';
import '../ui/support/support_screen.dart';
import 'animate_route.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (BuildContext buildContext) {
        return SplashScreen(); //splash screen
      });
    case main_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: BottomAppBarPage(), routeName: home_screen);
    case home_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: HomeScreen(), routeName: home_screen);
    case language_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: LanguageScreen(), routeName: language_screen);
    case login_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: LoginScreen(), routeName: login_screen);
    case signup_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: SignupScreen(), routeName: signup_screen);
    case restaurant_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: SearchScreen(),
          routeName: restaurant_detail_screen);

    case map_view:
      print(settings.name);
      return routeOne(
          settings: settings, widget: MapView(), routeName: map_view);


    case edit_profile_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: EditProfile(), routeName: edit_profile_screen);
    case terms_and_condition_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: TermsAndConditionScreen(), routeName: terms_and_condition_screen);
    case notifications_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: NotificationsScreen(),
          routeName: notifications_screen);

      case order_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: OrderScreen(),
          routeName: order_screen);
    case thankyou_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ThankyouScreen(),
          routeName: thankyou_screen);

      case order_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: OrderDetailScreen(),
          routeName: order_detail_screen);


    case incoming_order_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: IncomingOrderScreen(),
          routeName: incoming_order_screen);
    case all_shifts_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: AllShiftsScreen(),
          routeName: all_shifts_screen);
    case arrive_at_vendor_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ArriveAtVendorScreen(),
          routeName: arrive_at_vendor_screen);
    case pickup_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: PckupScreen(),
          routeName: pickup_screen);
    case goto_customer_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: GoToCustomerScreen(),
          routeName: goto_customer_screen);
    case dropoff_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: DropoffScreen(),
          routeName: dropoff_screen);
    case support_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: QueryListScreen(),
          routeName: support_screen);

    case send_request_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: SendRequestScreen(),
          routeName: send_request_screen);
    case chat_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ChatScreen(),
          routeName: chat_screen);

    default:
      print("default");
      return routeOne(
          settings: settings,
          widget: BottomAppBarPage(), //login screen
          routeName: home_screen);
  }
}
