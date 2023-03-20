import 'package:absher_rider/helpers/constants.dart';
import 'package:absher_rider/helpers/public_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/route_constants.dart';
import '../../providers/location/location_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../orders/order_detail_one_item.dart';
import 'header_widget.dart';

class DropoffScreen extends StatefulWidget {
  const DropoffScreen({Key? key}) : super(key: key);

  @override
  State<DropoffScreen> createState() => _DropoffScreenState();
}

class _DropoffScreenState extends State<DropoffScreen> {
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
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(builder: (context, settingsProvider, _) {
        return Consumer<LocationProvider>(builder: (context, locProvider, _) {
          return Column(
            // alignment: Alignment.bottomCenter,
            children: [
                    OrderHeaderSupportWidget(title: 'Drop-off'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment:
                          // MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "John Doe",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 19),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              color: mainColorLight,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.map_outlined),
                              color: mainColorLight,
                              onPressed: () {},
                            ),
                            // Text(
                            //   "3.4km ~ 6 min",
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 15),
                            // )
                          ],
                        ),
                        // Divider(),
                        const Text(
                          'Drop off at 8:10',
                        ),
                        SizedBox(height: 10,),
                        Divider(),
                        SizedBox(height: 10,),
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
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Order Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                        SizedBox(
                          height: 8,
                        ),

                        Container(
                          width: getWidth(context),
                          // color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order #1002",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 19),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "11 items",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Column(children: [
                                ...List.generate(
                                    23,
                                        (index) => OrderDetailOneItem(
                                      index: index > 2 ? 1 : index,
                                    )),
                              ],)
                            ],
                          ).marginSymmetric(horizontal: 0),
                        ),
                        SizedBox(
                          height: 16,
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                      ]).paddingSymmetric(horizontal: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0),
                height: 90,
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
                            Navigator.pushNamedAndRemoveUntil(context, main_screen, (val)=>false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: mainColorLight,
                                borderRadius: BorderRadius.circular(16)),
                            child: Text("Drop Off",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white))
                                .paddingSymmetric(vertical: 20, horizontal: 36),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20, vertical: 14),
                  ],
                ),
              ),
            ],
          );
        });
      }),
    );
  }
}