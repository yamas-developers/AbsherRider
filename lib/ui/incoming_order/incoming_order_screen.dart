import 'dart:async';

import 'package:absher_rider/helpers/constants.dart';
import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/route_constants.dart';
import '../../models/user.dart';
import '../../providers/location/location_provider.dart';
import '../../providers/order/up_coming_order_detail_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../common_widgets/app_color_button.dart';
import '../common_widgets/map_widget.dart';
import '../common_widgets/touchable_opacity.dart';

class IncomingOrderScreen extends StatefulWidget {
  const IncomingOrderScreen({Key? key}) : super(key: key);

  @override
  State<IncomingOrderScreen> createState() => _IncomingOrderScreenState();
}

class _IncomingOrderScreenState extends State<IncomingOrderScreen> {
  User? user;

  getPageData() async {
    var userProvider = context.read<UserProvider>();
    setState(() {
      user = userProvider.currentUser;
    });
    var data = ModalRoute.of(context)?.settings.arguments;
    if (data != null) {
      Map mapData = data as Map;
      String orderId = data['order'].toString();
      var upcomingOrderProvider = context.read<UpcomingOrderDetailProvider>();
      upcomingOrderProvider.orderId = orderId;
      upcomingOrderProvider.getData();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPageData();
    });
    startTimer();
    super.initState();
  }

  Timer? _timer;
  int? _start;
  int _timerValue = 30;

  void startTimer() {
    setState(() {
      _start = _timerValue;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timerValue == 0) {
          setState(() {
            timer.cancel();
            showToast("Order declined for not accepting on time");
            // Navigator.pop(context);
          });
        } else {
          setState(() {
            _timerValue--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: mainColor,
        ),
        body: Consumer<LocationProvider>(builder: (context, locProvider, _) {
          return Consumer<SettingsProvider>(
              builder: (context, settingsProvider, _) {
            return Consumer<UpcomingOrderDetailProvider>(
                builder: (key, provider, child) {
              return provider.loading
                  ? Center(child: CircularProgressIndicator())
                  : provider.orderItem == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Invalid order"),
                              SizedBox(
                                  width: 100,
                                  child: AppColorButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    fontSize: 10,
                                    name: "Go Back",
                                    elevation: 0,
                                  ))
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Text("Incoming Order",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: lightModeOn(context)
                                                    ? mediumGreyFontColor
                                                    : Colors.white,
                                                fontSize: 18,
                                              )),
                                          Text("Deliver in 30 minutes",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: lightModeOn(context)
                                                    ? mediumGreyFontColor
                                                    : Colors.white70,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Decline",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: mainColorLight)),
                                    )),
                                  ],
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 46,
                                    ),
                                    Container(
                                      height: 210,
                                      margin: EdgeInsets.all(0),
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                        )
                                      ]),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: MapWidget(
                                          markerLocation: locProvider
                                              .currentLocation, /*key: UniqueKey()*/
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 26,
                                    ),
                                    Text("Delivery Details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        )),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    if (provider.orderItem!.restaurant != null)
                                      Container(
                                        width: getWidth(context),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.storefront_rounded,
                                                  color: lightModeOn(context)
                                                      ? Colors.black54
                                                      : darkGreyColor,
                                                ),
                                                Container(
                                                  color: lightModeOn(context)
                                                      ? Colors.black54
                                                      : darkGreyColor,
                                                  height: 48,
                                                  width: 1,
                                                )
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Pickup",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 17),
                                                      ),
                                                      // Text(
                                                      //   "3.4km ~ 6 min",
                                                      //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                                      // )
                                                    ],
                                                  ).marginOnly(left: 10),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  if (provider.orderItem!
                                                          .restaurant!.name !=
                                                      null)
                                                    Text(
                                                      "${provider.orderItem!.restaurant!.name}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  if (provider
                                                          .orderItem!
                                                          .restaurant!
                                                          .address !=
                                                      null)
                                                    Text(
                                                      "${provider.orderItem!.restaurant!.address}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Container(
                                      width: getWidth(context),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.home_work,
                                                color: lightModeOn(context)
                                                    ? Colors.black54
                                                    : darkGreyColor,
                                              ),
                                              Container(
                                                color: lightModeOn(context)
                                                    ? Colors.black54
                                                    : darkGreyColor,
                                                height: 48,
                                                width: 1,
                                              )
                                            ],
                                          ),
                                          if (provider
                                                  .orderItem!.deliveryAddress !=
                                              null)
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Drop-off",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   "5.9km ~ 16 min",
                                                      //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                                      // )
                                                    ],
                                                  ).marginOnly(left: 10),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  if (provider
                                                          .orderItem!
                                                          .deliveryAddress!
                                                          .contactPersonName !=
                                                      null)
                                                    Text(
                                                      "${provider.orderItem!.deliveryAddress!.contactPersonName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15),
                                                    ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  if (provider
                                                          .orderItem!
                                                          .deliveryAddress!
                                                          .address !=
                                                      null)
                                                    Text(
                                                      "${provider.orderItem!.deliveryAddress!.address}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    )
                                  ]).paddingSymmetric(horizontal: 16),
                              // Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0),
                                height: 150,
                                decoration: BoxDecoration(
                                    color: lightModeOn(context)
                                        ? Colors.white
                                        : Colors.white10,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ]),
                                child: Column(
                                  children: [
                                    LinearProgressIndicator(
                                      color: mainColorLight,
                                      value: _timerValue / _start!,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "${_timerValue} seconds to auto-decline",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: _timerValue < 10
                                                ? Colors.red
                                                : lightModeOn(context)
                                                    ? Colors.blueGrey
                                                    : Colors.white)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("You will earn",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  // color: Colors.black87
                                                )),
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  text:
                                                      '${settingsProvider.zone?.zoneData?.first.currency_symbol} ',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: mainColorLight,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${provider.orderItem!.orderAmount}',
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          color: mainColorLight,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ).marginOnly(left: 16),
                                        TouchableOpacity(
                                          onTap: () async {
                                            if (user == null) {
                                              showToast(
                                                  "Cannot get user information");
                                              return;
                                            }
                                            showProgressDialog(
                                                context, "please wait");
                                            bool result =
                                                await provider.acceptOrder(
                                                    provider.orderItem!.id,
                                                    user!.id);
                                            hideProgressDialog(context);
                                            if (result) {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, order_detail_screen);
                                              // _timer?.cancel();
                                              // Navigator.pushNamed(context, arrive_at_vendor_screen);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: mainColorLight,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Text("Accept",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.white))
                                                .paddingSymmetric(
                                                    vertical: 20,
                                                    horizontal: 36),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(
                                        horizontal: 20, vertical: 20),
                                  ],
                                ),
                              ),
                            ]);
            });
          });
        }));
  }
}
