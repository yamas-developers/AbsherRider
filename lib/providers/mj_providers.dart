
import 'package:absher_rider/helpers/firebase/firebase_helper.dart';
import 'package:absher_rider/providers/order/order_detail_provider.dart';
import 'package:absher_rider/providers/shift/all_shifts_provider.dart';
import 'package:absher_rider/providers/shift/current_shift_provider.dart';
import 'package:absher_rider/providers/shift/today_shifts_provider.dart';
import 'package:absher_rider/providers/settings/settings_provider.dart';
import 'package:absher_rider/providers/support/support_provider.dart';
import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'location/location_provider.dart';
import 'order/up_coming_order_detail_provider.dart';
import 'shift/upcoming_shifts_provider.dart';


List<SingleChildWidget> providers = [
  ...independentProviders
];

List<SingleChildWidget> independentProviders = [
  ChangeNotifierProvider<UserProvider>(
    create: (_) => UserProvider(), lazy: false,),
  ChangeNotifierProvider<LocationProvider>(create: (_) => LocationProvider()),
  ChangeNotifierProvider<TodayShiftProvider>(create: (_) => TodayShiftProvider()),
  ChangeNotifierProvider<AllShiftProvider>(create: (_) => AllShiftProvider()),
  ChangeNotifierProvider<UpComingShiftProvider>(create: (_) => UpComingShiftProvider()),
  ChangeNotifierProvider<CurrentShiftProvider>(create: (_) => CurrentShiftProvider()),
  ChangeNotifierProvider<FirebaseHelper>(create: (_) => FirebaseHelper()),
  ChangeNotifierProvider<OrderDetailProvider>(create: (_) => OrderDetailProvider()),
  ChangeNotifierProvider<UpcomingOrderDetailProvider>(create: (_) => UpcomingOrderDetailProvider()),
  ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
  ChangeNotifierProvider<SupportProvider>(create: (_) => SupportProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
