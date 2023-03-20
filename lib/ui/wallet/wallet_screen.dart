import 'package:absher_rider/providers/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/avatar.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: Image.asset(
                      //           "assets/icons/back_arrow_icon.png",
                      //           width: 24,
                      //           height: 24,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 8,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                                  "Wallet",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: lightModeOn(context) ? mainColor :mainColorLight,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               Divider(),
                SizedBox(
                  height: 16,
                ),
                Row(children: [
                  RoundedAvatar(
                      assetPath: "assets/images/temp/person.jpg"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Welcome Rider",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: lightModeOn(context) ? Colors.blueGrey :lightGreyColor
                    ),
                  ),
                ],),
                SizedBox(
                  height: 10,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                        decoration: BoxDecoration(
                          color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                          borderRadius: BorderRadius.circular(14)

                        ),
                        child: Text(
                          "${DateFormat("MMMM dd, yyyy hh:mm a").format(DateTime.now())}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // color: mainColor
                          ),
                        ),
                      ),
                    )
                  ],),
                SizedBox(
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: mainColorLight,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Balance",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: '${settingsProvider.zone?.zoneData?.first.currency_symbol} ',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
                                        children: <TextSpan>[
                                          TextSpan(text: '300',
                                            style: TextStyle(
                                                fontSize: 19, color: Colors.white, fontWeight: FontWeight.w600),
                                          ),
                                        ]
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Text("Updated at 11:45 am",style: TextStyle(
                                        fontSize: 12, color: Colors.white70, fontWeight: FontWeight.w400),),
                                  ),

                                ],
                              ),

                              Icon(Icons.monetization_on_outlined, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Orders",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        // color: Colors.black54,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '12',
                                    style: TextStyle(
                                        fontSize: 18, color: lightModeOn(context) ? mainColor :mainColorLight, fontWeight: FontWeight.w600),

                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),

                                ],
                              ),

                              Image.asset("assets/icons/order_icon.png", height: 30, color: lightModeOn(context) ? mainColorLight :lightGreyColor,)
                            ],
                          ),
                        ),
                      ),
                    ],),
                ),

                SizedBox(
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cash Payments",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '12',
                                style: TextStyle(
                                    fontSize: 18, color: lightModeOn(context) ? mainColor :mainColorLight, fontWeight: FontWeight.w600),

                              ),
                              SizedBox(
                                height: 6,
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Online Payments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14,
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '6',
                                style: TextStyle(
                                    fontSize: 18, color: lightModeOn(context) ? mainColor :mainColorLight, fontWeight: FontWeight.w600),

                              ),
                              SizedBox(
                                height: 6,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],),
                ),
                SizedBox(
                  height: 10,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        // flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Payable Amount",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${settingsProvider.zone?.zoneData?.first.currency_symbol} 120',
                                style: TextStyle(
                                    fontSize: 18, color: lightModeOn(context) ? mainColor :mainColorLight, fontWeight: FontWeight.w600),

                              ),
                              SizedBox(
                                height: 6,
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? lightGreyColor.withOpacity(0.5) :lightestGreyColor,
                              borderRadius: BorderRadius.circular(14)

                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Bonus",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14,
                                    // color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${settingsProvider.zone?.zoneData?.first.currency_symbol} 70',
                                style: TextStyle(
                                    fontSize: 18, color: lightModeOn(context) ? mainColor :mainColorLight, fontWeight: FontWeight.w600),

                              ),
                              SizedBox(
                                height: 6,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Payment History", style: TextStyle(
                  // color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),),
                SizedBox(
                  height: 20,
                ),

                ...List.generate(4, (index) => Column(
                  children: [
                    PaymentHistoryItem(index: index),
                    SizedBox(
                      height: 10,
                    ),
                    Divider()
                  ],
                ))

                // SizedBox(
                //   height: 35,
                // ),
              ],
            ).marginSymmetric(horizontal: 20),
          );
        }
      ),
    );
  }
}

class PaymentHistoryItem extends StatelessWidget {
  const PaymentHistoryItem({
    Key? key, required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isOnline = index%2 == 0;
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        return Container(
          width: getWidth(context),
          child: Row(
            children: [
              Column(
                children: [
                  Icon(isOnline ? Icons.book_online_outlined : Icons.money_outlined,color: lightModeOn(context) ? Colors.black54 : mainColorLight,),
                  Container(
                    color: Colors.black54,
                    height: 40,
                    width: 1,
                  )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "John Doe",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,),
                        ),
                        Text(
                          "${isOnline ? "Online" : "Cash"} Payment",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: lightModeOn(context) ? mainColor :mainColorLight),
                        )
                      ],
                    ).marginOnly(left: 10),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID: 5454",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${settingsProvider.zone?.zoneData?.first.currency_symbol} ',
                              style: TextStyle(
                                  fontSize: 17, color: priceGreenColor, fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(text: '300',
                                  style: TextStyle(
                                      fontSize: 19, color: priceGreenColor, fontWeight: FontWeight.w600),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Text(
                      "${DateFormat("MMMM dd, yyyy hh:mm a").format(DateTime.now())}",
                      style: TextStyle(fontWeight: FontWeight.w500, color: mediumGreyColor, fontSize: 13),
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
