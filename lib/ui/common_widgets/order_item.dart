import 'package:absher_rider/helpers/public_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../providers/settings/settings_provider.dart';
import 'avatar.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, order_detail_screen);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: lightModeOn(context) ? Colors.white :Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 6,
                          spreadRadius: .1,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 12.0, right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(width: 6,),
                                Text(
                                  "Deliver by 10:38pm, 20.02.2022",
                                  style:
                                  TextStyle(fontSize: 12, color: darkGreyColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  RoundedAvatar(
                                      assetPath: 'assets/images/temp/dish.png',
                                      height: 60,
                                      width: 60),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 12,),
                                    Text(
                                      "Restaurant Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          // color: Colors.black
                                      ),
                                    ),
                                    Text(
                                      "${settingsProvider.zone?.zoneData?.first.currency_symbol} 635",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: mainColorLight),
                                    ),
                                    // SizedBox(height: 12,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 6,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order #23645955",
                              style: TextStyle(fontSize: 13, color: darkGreyColor),
                            ),
                            Image.asset(
                              "assets/icons/right_arrow.png",
                              color: darkGreyColor,
                              fit: BoxFit.fill,
                              width: 25,
                              // width: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: darkGreyColor))),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(color: darkGreyColor))),
                                child: Text(
                                  "Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Complete Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //   top: 14,
                //   right: 18,
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Image.asset(
                //         "assets/icons/done_icon.png",
                //         width: 38,
                //         height: 38,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      }
    );
  }
}
