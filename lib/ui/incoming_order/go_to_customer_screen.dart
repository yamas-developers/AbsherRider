import 'package:absher_rider/helpers/constants.dart';
import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/helpers/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../providers/location/location_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../common_widgets/map_widget.dart';
import 'header_widget.dart';

class GoToCustomerScreen extends StatefulWidget {
  const GoToCustomerScreen({Key? key}) : super(key: key);

  @override
  State<GoToCustomerScreen> createState() => _GoToCustomerScreenState();
}

class _GoToCustomerScreenState extends State<GoToCustomerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(builder: (context, settingsProvider, _) {
        return Consumer<LocationProvider>(builder: (context, locProvider, _) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderHeaderSupportWidget(title: 'Go to customer'),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: 26,
                        ),
                        Text("Customer Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: getWidth(context),
                          child: Column(
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "John Doe",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.map_outlined),
                                    color: mainColorLight,
                                    onPressed: (){},
                                  ),
                                    IconButton(
                                      icon: Icon(Icons.wifi_calling_3),
                                      color: mainColorLight,
                                      onPressed: (){},
                                    )
                                  // Text(
                                  //   "3.4km ~ 6 min",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w600,
                                  //       fontSize: 15),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Image.asset(
                                    'assets/icons/map_pin.png',
                                    scale: 6,
                                    color: lightModeOn(context)
                                        ? Colors.black54
                                        : darkGreyColor,
                                  ).marginOnly(top: 0),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Lorem ipsum dolor sit amet",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).marginSymmetric(horizontal: 0),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(),
                        Text("Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Collect Cash',),
                            Text('QAR 1200',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                          ],
                        ),
                        // Divider(),
                        SizedBox(
                          height: 16,
                        ),
                        Divider(),
                        Center(child: const Text('Arrive at 8:10',)).marginSymmetric(vertical: 10),
                        // Divider(),
                        SizedBox(
                          height: 16,
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
                          height: 14,
                        ),
                      ]).paddingSymmetric(horizontal: 16),
                  // Spacer(),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0),
                height: 100,
                decoration: BoxDecoration(
                    color: lightModeOn(context) ? Colors.white : Colors.white10,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 10)
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            Navigator.pushNamed(context, dropoff_screen);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: mainColorLight,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("Arrived at the Customer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white))
                                .paddingSymmetric(vertical: 20, horizontal: 12),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20, vertical: 20),
                  ],
                ),
              ),
            ],
          );
        });
      }),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.message),onPressed: (){
        Navigator.pushNamed(context, chat_screen,
            arguments: {"other_user_id": "16",
              "other_user_role": "customer",
              "other_user_name": "John Doe",
              "order_id": "1002",
            });
      },),
    );
  }
}


