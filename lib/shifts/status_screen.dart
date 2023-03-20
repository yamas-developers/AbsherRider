import 'package:absher_rider/helpers/color/dark.dart';
import 'package:absher_rider/helpers/color/light.dart';
import 'package:absher_rider/helpers/constants.dart';
import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/helpers/route_constants.dart';
import 'package:absher_rider/models/shift.dart';
import 'package:absher_rider/providers/location/location_provider.dart';
import 'package:absher_rider/providers/shift/current_shift_provider.dart';
import 'package:absher_rider/providers/shift/today_shifts_provider.dart';
import 'package:absher_rider/providers/shift/upcoming_shifts_provider.dart';
import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:absher_rider/ui/common_widgets/app_color_button.dart';
import 'package:absher_rider/ui/common_widgets/touchable_opacity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/shift/all_shifts_provider.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  User? user;

  getPageData() {
    setState(() {
      user = context.read<UserProvider>().currentUser;
    });
    var shiftProvider = context.read<TodayShiftProvider>();
    var upcomingShiftProvider = context.read<UpComingShiftProvider>();
    var currentShiftProvider = context.read<CurrentShiftProvider>();
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    shiftProvider.getData(date);
    upcomingShiftProvider.getData(date);
    currentShiftProvider.getData(user!.id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPageData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      backgroundColor: lightModeOn(context) ? lightestGreyColor : darkGreyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                color: lightModeOn(context) ? lightWhite : darkWhite,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    // margin: EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: lightModeOn(context)
                          ? TmLight.successColor
                          : TmDark.successColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Online",
                      style: TextStyle(color: TmLight.permanentWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8.0, 20, 8),
              child: TouchableOpacity(
                onTap: (){
                  Navigator.pushNamed(context, all_shifts_screen);
                },
                child: AppColorButton(
                    name: "Search For Shifts",
                    fontSize: 20,
                    elevation: 0,
                    color: TmLight.primaryLightColor,
                    onPressed: null),
              ),
            ),
            Consumer<CurrentShiftProvider>(
                builder: (key, todayShiftProvider, child) {
              return todayShiftProvider.list.length < 1
                  ? SizedBox()
                  : Container(
                      width: getWidth(context),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thunderstorm,
                              ),
                              Text(
                                "Current Shift",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            }),
            SizedBox(
              height: 8,
            ),
            Container(
                width: getWidth(context),
                child: Consumer<CurrentShiftProvider>(
                    builder: (key, currentShiftProvider, child) {
                  return Column(
                    children: [
                      ...currentShiftProvider.list
                          .map((e) => CurrentShiftItem(
                                shift: e,
                              ))
                          .toList(),
                    ],
                  );
                })),
            Consumer<TodayShiftProvider>(
                builder: (key, todayShiftProvider, child) {
              return todayShiftProvider.list.length < 1
                  ? SizedBox()
                  : Container(
                      width: getWidth(context),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.thunderstorm,
                              ),
                              Text(
                                "Today's Shifts",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          TouchableOpacity(
                            onTap: () {
                              Navigator.pushNamed(context, all_shifts_screen);
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: TmLight.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
            SizedBox(
              height: 8,
            ),
            Container(
                width: getWidth(context),
                child: Consumer<TodayShiftProvider>(
                    builder: (key, todayShiftProvider, child) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: todayShiftProvider.list
                            .map((e) => ShiftHomeItem(
                                  shift: e,
                                ))
                            .toList(),
                      ));
                })),
            Consumer<UpComingShiftProvider>(
                builder: (key, upcomingShiftProvider, child) {
              return upcomingShiftProvider.list.length < 1
                  ? SizedBox()
                  : Container(
                      width: getWidth(context),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Upcoming Shifts",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TouchableOpacity(
                            onTap: () {
                              Navigator.pushNamed(context, all_shifts_screen);
                            },
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: TmLight.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
            Container(
                width: getWidth(context),
                child: Consumer<UpComingShiftProvider>(
                    builder: (key, upcomingShiftProvider, child) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...upcomingShiftProvider.list
                            .map((e) => HomeUpComingShiftItem(
                                  shift: e,
                                ))
                            .toList(),
                      ]);
                })),
          ],
        ),
      ),
    );
  }
}

class ShiftHomeItem extends StatefulWidget {
  final Shift shift;

  const ShiftHomeItem({Key? key, required this.shift}) : super(key: key);

  @override
  State<ShiftHomeItem> createState() => _ShiftHomeItemState();
}

class _ShiftHomeItemState extends State<ShiftHomeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: lightModeOn(context) ? TmLight.itemColor : TmDark.itemColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${shiftTimeFormate(widget.shift.startTime)} - ${shiftTimeFormate(widget.shift.endTime)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "${widget.shift.description}",
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
            decoration: BoxDecoration(
              color: TmLight.primaryLightColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "${widget.shift.status}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style:
                  TextStyle(color: TmLight.permanentWhiteColor, fontSize: 12),
            ),
          ),
          TouchableOpacity(
            onTap: () {
              if (widget.shift.isTaken) return;
              var riderId = context.read<UserProvider>().currentUser!.id;
              context
                  .read<AllShiftProvider>()
                  .takeShift(widget.shift.id, riderId);
            },
            child: AppColorButton(
              width: 130,
              fontSize: 12,
              onPressed: null,
              name: "Take Shift",
              elevation: 0,
              color: TmDark.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}

class HomeUpComingShiftItem extends StatefulWidget {
  Shift shift;

  HomeUpComingShiftItem({Key? key, required this.shift}) : super(key: key);

  @override
  State<HomeUpComingShiftItem> createState() => _HomeUpComingShiftItemState();
}

class _HomeUpComingShiftItemState extends State<HomeUpComingShiftItem> {
  bool isLoading = false;

  startShift() async {
    try {
      var locationProvider = context.read<LocationProvider>();
      showProgressDialogWithoutContext(getString("getting_current_location"),
          isDismissable: false);
      await locationProvider.getCurrentLocation();
      hideProgressDialogWithoutContext();
      setState(() {
        isLoading = true;
      });
      await context.read<UpComingShiftProvider>().startShift(
          shiftId: widget.shift.id,
          riderId: widget.shift.deliveryMan,
          lat: locationProvider.currentLocation.latitude,
          lng: locationProvider.currentLocation.longitude);
      setState(() {
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14, 0, 14, 8),
      decoration: BoxDecoration(
          color: lightModeOn(context)
              ? TmLight.themeLightColor
              : TmDark.themeLightColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                      decoration: BoxDecoration(
                          color: lightModeOn(context)
                              ? TmLight.themeBackgroundGreyColor
                              : TmDark.themeBackgroundGreyColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Text(
                            "${getDayMonthFromDate(widget.shift.shiftDate)['month']}",
                            maxLines: 1,
                            style: TextStyle(
                                color: lightModeOn(context)
                                    ? TmLight.primaryColor
                                    : TmDark.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                              "${getDayMonthFromDate(widget.shift.shiftDate)['day']}",
                              style: TextStyle(
                                  color: lightModeOn(context)
                                      ? TmLight.themeBlackColor
                                      : TmDark.themeBlackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text("today"),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${shiftTimeFormate(widget.shift.startTime)} - ${shiftTimeFormate(widget.shift.endTime)}  (${shiftTimeDifferenceHours(widget.shift.startTime, widget.shift.endTime)}h)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("${widget.shift.description}"),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Starting at ${shiftTimeFormate(widget.shift.startTime)}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: lightModeOn(context)
                                    ? TmLight.greenColor
                                    : TmDark.greenColor),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text("Are you ready?"),
            SizedBox(
              height: 6,
            ),
            TouchableOpacity(
              onTap: () {
                startShift();
              },
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : AppColorButton(
                      onPressed: null,
                      color: lightModeOn(context)
                          ? TmLight.primaryDarkColor
                          : TmDark.primaryDarkColor,
                      name: "Start Shift Now",
                      fontSize: 20,
                      elevation: 0,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CurrentShiftItem extends StatefulWidget {
  Shift shift;

  CurrentShiftItem({Key? key, required this.shift}) : super(key: key);

  @override
  State<CurrentShiftItem> createState() => _CurrentShiftItemState();
}

class _CurrentShiftItemState extends State<CurrentShiftItem> {
  bool isLoading = false;

  endShift() async {
    try {
      showAlertDialog(
          context, "Alert", "Are you sure you want to end the shift?",
          okButtonText: "Yes", type: AlertType.INFO, onPress: () async {
        setState(() {
          isLoading = true;
        });
        await context
            .read<AllShiftProvider>()
            .endShift(widget.shift.id, widget.shift.deliveryMan);
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14, 0, 14, 8),
      decoration: BoxDecoration(
          color: lightModeOn(context)
              ? TmLight.themeLightColor
              : TmDark.themeLightColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                      decoration: BoxDecoration(
                          color: lightModeOn(context)
                              ? TmLight.themeBackgroundGreyColor
                              : TmDark.themeBackgroundGreyColor,
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Text(
                            "${getDayMonthFromDate(widget.shift.shiftDate)['month']}",
                            maxLines: 1,
                            style: TextStyle(
                                color: lightModeOn(context)
                                    ? TmLight.primaryColor
                                    : TmDark.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                              "${getDayMonthFromDate(widget.shift.shiftDate)['day']}",
                              style: TextStyle(
                                  color: lightModeOn(context)
                                      ? TmLight.themeBlackColor
                                      : TmDark.themeBlackColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text("today"),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${shiftTimeFormate(widget.shift.startTime)} - ${shiftTimeFormate(widget.shift.endTime)}  (${shiftTimeDifferenceHours(widget.shift.startTime, widget.shift.endTime)}h)",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("${widget.shift.description}"),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            widget.shift.workingStatus == "Over"
                                ? "Already Over"
                                : "Will ends at ${shiftTimeFormate(widget.shift.endTime)}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: lightModeOn(context)
                                    ? TmLight.dangerColor
                                    : TmDark.dangerColor),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 6,
            ),
            if (widget.shift.workingStatus.isNotEmpty)
              Row(
                children: [
                  Text(
                    "Working Status: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: widget.shift.workingStatus == "Over"
                            ? lightModeOn(context)
                                ? TmLight.primaryColor
                                : TmDark.primaryColor
                            : lightModeOn(context)
                                ? TmLight.successColor
                                : TmDark.successColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.shift.workingStatus,
                        style: TextStyle(
                            color: TmLight.permanentWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )),
                ],
              ),
            SizedBox(
              height: 6,
            ),
            if (widget.shift.workingStatus == "Over")
              Text(
                "Note: click end shift if you are done.",
                style: TextStyle(color: TmLight.dangerColor),
              ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : TouchableOpacity(
                    onTap: () {
                      endShift();
                    },
                    child: AppColorButton(
                      onPressed: null,
                      color: lightModeOn(context)
                          ? TmLight.dangerColor
                          : TmDark.dangerColor,
                      name: "End Shift",
                      fontSize: 20,
                      elevation: 0,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
