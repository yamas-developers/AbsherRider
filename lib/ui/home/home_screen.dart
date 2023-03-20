import 'dart:convert';
import 'dart:math';

import 'package:absher_rider/providers/location/location_provider.dart';
import 'package:absher_rider/ui/common_widgets/avatar.dart';
import 'package:absher_rider/ui/common_widgets/touchable_opacity.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/public_methods.dart';
import '../../providers/settings/settings_provider.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/comon.dart';
import '../common_widgets/nearest_restaurant_item.dart';
import '../common_widgets/order_item.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCheckedIn = false;


  getPageData() async {
    int random = Random().nextInt(30);

    Future.delayed(Duration(seconds: random)).then((value) async {
      showToast("You have an incoming order");

      AudioPlayer player = AudioPlayer();
      await player.setSource(AssetSource('sounds/notification_sound.wav'));
      // await player.play(DeviceFileSource(localFile));
      player.resume();
      // player.play(AssetSource('assets/sounds/notification_sound.wav'));
      Navigator.pushNamed(context, incoming_order_screen);
    });
    // FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    // getPageData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
    Color foreGroundColor = isCheckedIn ? Colors.white : Colors.blueGrey;
    Color foreGroundColor2 = isCheckedIn ? mainColor : Colors.blueGrey;
    Color backGroundColor = isCheckedIn ? mainColorLight : Colors.white;
    
    if(!lightModeOn(context)){
      foreGroundColor = isCheckedIn ? Colors.white : Colors.white70 ;
      foreGroundColor2 = isCheckedIn ? mainColorLight : Colors.white70;
      backGroundColor = isCheckedIn ? mainColorLight.withOpacity(0.8) : Colors.black54;
    }
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // Container(
                    //   height: getLargestSide(context) * 0.09,
                    //   padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
                    //   child: Flex(
                    //     direction: Axis.horizontal,
                    //     children: [
                    //       Expanded(
                    //         flex: 6,
                    //         child: Container(
                    //           // height: 39,
                    //           padding: EdgeInsets.fromLTRB(8, 9, 4, 9),
                    //           decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: BorderRadius.circular(20),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Color.fromRGBO(0, 0, 0, 0.15),
                    //                   blurRadius: 6,
                    //                   spreadRadius: .1,
                    //                 ),
                    //               ]),
                    //           child: Row(
                    //             children: [
                    //               Image.asset(
                    //                 "assets/icons/location_pin.png",
                    //                 width: 20,
                    //                 height: 20,
                    //                 color: mainColor,
                    //               ),
                    //               SizedBox(
                    //                 width: 6,
                    //               ),
                    //               Flexible(
                    //                   child: Text(
                    //                 "Location",
                    //                 style: TextStyle(
                    //                     fontSize: 16,
                    //                     color: Color.fromRGBO(120, 22, 145, 1),
                    //                     fontWeight: FontWeight.w600),
                    //               )),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 Navigator.pushNamed(context, notifications_screen);
                    //               },
                    //               child: Image.asset(
                    //                 "assets/icons/notification.png",
                    //                 width: 24,
                    //                 height: 24,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Container(
                    //   height: getLargestSide(context) * (isPortrait(context) ? 0.16 : 0.2) ,
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Stack(
                    //     alignment: Alignment.bottomCenter,
                    //     children: [
                    //       CarouselSlider(
                    //         options: CarouselOptions(
                    //           height:
                    //               getSize(context, 0.30, getWidth(context) * .40, 120),
                    //           // aspectRatio: 16/9,
                    //           viewportFraction: .8,
                    //           initialPage: 0,
                    //           enableInfiniteScroll: true,
                    //           reverse: false,
                    //           autoPlay: true,
                    //           autoPlayInterval: Duration(seconds: 3),
                    //           autoPlayAnimationDuration: Duration(milliseconds: 800),
                    //           autoPlayCurve: Curves.fastOutSlowIn,
                    //           enlargeCenterPage: true,
                    //           onPageChanged: (int i, a) {
                    //             _current = i;
                    //             setState(() {});
                    //           },
                    //           scrollDirection: Axis.horizontal,
                    //         ),
                    //         items: [
                    //           Container(
                    //             width: getSmallestSide(context),
                    //             child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(14),
                    //                 child: Stack(
                    //                   alignment: Alignment.bottomCenter,
                    //                   children: [
                    //                     Image.asset(
                    //                       'assets/images/banner1.jpeg',
                    //                       width: getSmallestSide(context),
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                           gradient: LinearGradient(
                    //                               end: Alignment.bottomCenter,
                    //                               begin: Alignment.topCenter,
                    //                               colors: [
                    //                             Color.fromRGBO(188, 55, 222, 0),
                    //                             Color.fromRGBO(188, 55, 222, 0),
                    //                             Color.fromRGBO(120, 22, 145, 0.82),
                    //                           ])),
                    //                     )
                    //                   ],
                    //                 )),
                    //           ),
                    //           Container(
                    //             width: getSmallestSide(context),
                    //             child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(14),
                    //                 child: Stack(
                    //                   alignment: Alignment.bottomCenter,
                    //                   children: [
                    //                     Image.asset(
                    //                       'assets/images/banner2.jpeg',
                    //                       width: getSmallestSide(context),
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                           gradient: LinearGradient(
                    //                               end: Alignment.bottomCenter,
                    //                               begin: Alignment.topCenter,
                    //                               colors: [
                    //                             Color.fromRGBO(188, 55, 222, 0),
                    //                             Color.fromRGBO(188, 55, 222, 0),
                    //                             Color.fromRGBO(120, 22, 145, 0.82),
                    //                           ])),
                    //                     )
                    //                   ],
                    //                 )),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [0, 1, 2].map(
                    //           (index) {
                    //             return Container(
                    //               width: 8.0,
                    //               height: 8.0,
                    //               margin: EdgeInsets.symmetric(
                    //                   vertical: 10.0, horizontal: 2.0),
                    //               decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: _current == index
                    //                       ? Color.fromRGBO(239, 0, 255, 1.0)
                    //                       : Color.fromRGBO(252, 227, 255, 1.0)),
                    //             );
                    //           },
                    //         ).toList(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),

                    Container(
                      // height: getLargestSide(context) * 0.38,
                      width: getWidth(context),
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      decoration: BoxDecoration(
                          color: backGroundColor,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: foreGroundColor.withOpacity(0.4),
                                blurRadius: 20,
                                offset: Offset(4, 4)
                                // spreadRadius: 10
                                )
                          ]),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome ${userProvider.currentUser?.fName??'Rider'}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: foreGroundColor),
                                  ),
                                  Text(
                                    "Good Afternoon",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, incoming_order_screen);
                                  },
                                  child: RoundedNetworkAvatar(
                                      url: userProvider.currentUser?.image,
                                      prefix: MJ_Apis.profileImgPath,
                                      )),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                  Text(
                                    "${settingsProvider.zone?.zoneData?.first.currency_symbol} 2000",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: foreGroundColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Active Orders",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                  Text(
                                    "2",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: foreGroundColor),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  // AudioPlayer player = AudioPlayer();
                                  // await player.setSource(AssetSource('sounds/notification_sound.wav'));
                                  // // // await player.play(DeviceFileSource(localFile));
                                  // player.resume();
                                  setState(() {
                                    isCheckedIn = !isCheckedIn;
                                  });
                                },
                                child: Text(
                                  isCheckedIn ? "Checkout" : "Check In",
                                  style: TextStyle(
                                      color:
                                          isCheckedIn ? mainColorLight : Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        isCheckedIn ? Colors.white : mainColorLight)),
                              )
                            ],
                          ).marginSymmetric(vertical: 00, horizontal: 0),
                          Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Text(
                                    "Shift Started At",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                  Text(
                                    "01:30 pm",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: foreGroundColor),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shift Ends At",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                  Text(
                                    "08:30 pm",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: foreGroundColor),
                                  ),
                                ],
                              ),
                            ],
                          ).marginSymmetric(vertical: 8, horizontal: 0),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(height: 6,),
                          TouchableOpacity(
                            onTap: (){
                              modalBottomSheetLocation(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/icons/pin.png', color: foreGroundColor,height: 25,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    context.watch<LocationProvider>().address?? "N/A",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: foreGroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20, vertical: 0),

                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: getLargestSide(context) * 0.045,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Today's Highlights",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                      Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, notifications_screen);
                                      },
                                      child: Image.asset(
                                        "assets/icons/notification.png",
                                        width: 24,
                                        height: 24,

                                      ),
                                    ),
                                  ],
                                ),)

                        ],
                      ),
                    ).marginSymmetric(vertical: 10),

                    Container(
                      width: getWidth(context),
                      height: getLargestSide(context) * 0.12,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeItemWidget(
                              onPress: () {
                                Navigator.pushNamed(context, order_screen);
                              },
                              value: '10',
                              title: 'Completed Orders',
                              color: isCheckedIn ? mainColor : foreGroundColor,
                              fontcolor: foreGroundColor2,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: HomeItemWidget(
                              onPress: () {
                                //go to store
                                Navigator.pushNamed(context, order_screen);
                              },
                              value: '2',
                              title: 'Cancelled Orders',
                              color: isCheckedIn ? Colors.red : foreGroundColor,
                              fontcolor: foreGroundColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: Row(children: [
                    //     Expanded(
                    //       child: HomeItemBanner(
                    //           onPress: () {
                    //             Navigator.pushNamed(context, express_delivery_screen);
                    //           },
                    //           image: 'assets/images/express_delivery_image.jpg',
                    //           title: 'Absher Express'),
                    //     ),
                    //   ]),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      width: getWidth(context),
                      height: getLargestSide(context) * 0.178,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeItemWidget(
                              onPress: () {},
                              value: 'QAR 1500',
                              title: 'Collected Amount',
                              color: isCheckedIn ? priceGreenColor : foreGroundColor,
                              fontcolor: foreGroundColor2,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: HomeItemWidget(
                              onPress: () {
                                // Navigator.pushNamed(context, services_screen);
                              },
                              value: 'QAR 500',
                              title: 'Earned Amont',
                              color: isCheckedIn ? Colors.greenAccent : foreGroundColor,
                              fontcolor: foreGroundColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //
                    //   height: getLargestSide(context)(context)/getSmallestSide(context)*140,
                    //   // constraints: BoxConstraints.expand(),
                    //   // height: getLargestSide(context)(context),
                    //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: GridView.count(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 8,
                    //     mainAxisSpacing: 10,
                    //     childAspectRatio: getLargestSide(context)(context)/getSmallestSide(context)*0.6,
                    //     // childAspectRatio: 1.2,
                    //     children: [
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 24,
                    // ),
                    // Container(
                    //   height: getLargestSide(context) * 0.03,
                    //   padding: const EdgeInsets.symmetric(horizontal: 18),
                    //   child: Text(
                    //     "Top Picks",
                    //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 2,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 6, right: 18),
                    //   height: getLargestSide(context) * 0.18,
                    //   child: Row(
                    //     // scrollDirection: Axis.horizontal,
                    //     children: [
                    //       Expanded(
                    //         child: HomeTopPickItems(
                    //             onPress: () {
                    //               Navigator.pushNamed(context, order_screen);
                    //             },
                    //             image: 'assets/icons/past_order.png',
                    //             title: "Past Order"),
                    //       ),
                    //       // SizedBox(width: 8,),
                    //       Expanded(
                    //         child: HomeTopPickItems(
                    //             onPress: () {
                    //               Navigator.pushNamed(context, order_screen);
                    //             },
                    //             image: 'assets/icons/happy_hours.png',
                    //             title: "Past Order"),
                    //       ),
                    //       // SizedBox(width: 8,),
                    //       Expanded(
                    //         child: HomeTopPickItems(
                    //             onPress: () {},
                    //             image: 'assets/icons/offers.png',
                    //             title: "Offers"),
                    //       ),
                    //       // SizedBox(width: 8,),
                    //       Expanded(
                    //         child: HomeTopPickItems(
                    //             onPress: () {},
                    //             image: 'assets/icons/choices.png',
                    //             title: "Choices"),
                    //       ),
                    //       // SizedBox(width: 8,),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 18),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Resturents nearby",
                    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //       ),
                    //       Text(
                    //         "View All",
                    //         style: TextStyle(
                    //           color: Color.fromRGBO(155, 28, 187, 1),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 6),
                    //   width: getLargestSide(context),
                    //   height: 200,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: [
                    //       NearestResturentItem(
                    //         onPress: () {},
                    //         image: 'assets/images/home_img1.png',
                    //         title: 'Lorem Ipsum',
                    //         distance: "9.5",
                    //         placeName: "Place Name",
                    //         rating: "4.6",
                    //         timeDuration: "40-50",
                    //         price: "2",
                    //         centerImageheight: 110,
                    //         maxWidth: 300,
                    //         widthFraction: 0.7,
                    //         adjustOnLandscape: false,
                    //       ),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //       NearestResturentItem(
                    //         onPress: () {},
                    //         image: 'assets/images/home_img1.png',
                    //         title: 'Lorem Ipsum',
                    //         distance: "9.5",
                    //         placeName: "Place Name",
                    //         rating: "4.6",
                    //         timeDuration: "40-50",
                    //         price: "2",
                    //         centerImageheight: 110,
                    //         maxWidth: 300,
                    //         widthFraction: 0.7,
                    //         adjustOnLandscape: false,
                    //       ),
                    //       SizedBox(
                    //         width: 8,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),

                    ...List.generate(2, (index) {
                      return OrderItem().paddingSymmetric(horizontal: 20);
                    }),

                    SizedBox(
                      height: 35,
                    ),
                    // HomeItemWidget(onPress: (){}, image: 'assets/images/type1.png', title: 'Restaurant'),
                  ],
                ),
              );
            }
          );
        }
      ),
    );
  }
}

class HomeItemWidget extends StatelessWidget {
  final onPress;
  final String value;
  final String title;
  final Color color;
  final Color fontcolor;

  const HomeItemWidget({
    Key? key,
    required this.onPress,
    required this.value,
    required this.title,
    required this.color,
    required this.fontcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: mainColor.withOpacity(0.06),
                blurRadius: 10,
                spreadRadius: 4)
          ],
          color: lightModeOn(context) ? Colors.white :Colors.black26,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: getSmallestSide(context),
            height: 100,
            decoration: BoxDecoration(
                // color: lightestGreyColor.withOpacity(0.18),
                boxShadow: []
                // gradient: LinearGradient(
                //     end: Alignment.bottomCenter,
                //     begin: Alignment.topCenter,
                //     colors: [
                //   Color.fromRGBO(188, 55, 222, 0.05),
                //   Color.fromRGBO(188, 55, 222, 0.1),
                //   Color.fromRGBO(120, 22, 145, 0.2),
                // ]),
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: fontcolor,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${value}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: fontcolor,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 10)
                          ],
                          color: Colors.white,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ).marginSymmetric(horizontal: 5),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTopPickItems extends StatelessWidget {
  final onPress;
  final String image;
  final String title;

  const HomeTopPickItems(
      {Key? key,
      required this.onPress,
      required this.image,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
        child: Column(
          children: [
            Container(
              width: getSmallestSide(context) * 0.25,
              height: getLargestSide(context) * 0.1,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      // rgba(155, 28, 187, 0.25)
                      color: Color.fromRGBO(155, 28, 187, 0.25),
                      spreadRadius: .4,
                      blurRadius: 4,
                    ),
                  ]),
              child: Image.asset(
                '$image',
                fit: BoxFit.fitWidth,
                // width: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "$title",
              style: TextStyle(
                color: Color.fromRGBO(120, 22, 145, 1),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class NearestResturentItem1 extends StatelessWidget {
//   final Function onPress;
//   final String image;
//   final String title;
//
//   const NearestResturentItem1(
//       {Key? key,
//       required this.onPress,
//       required this.image,
//       required this.title})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 8, 0, 8),
//       child: Column(
//         children: [
//           Container(
//             width: getSize(context, .7, 300, 0),
//             // height: 160,
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     // rgba(155, 28, 187, 0.25)
//                     color: Color.fromRGBO(0, 0, 0, 0.2),
//                     spreadRadius: .2,
//                     blurRadius: 2,
//                   ),
//                 ]),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         "$title",
//                         maxLines: 1,
//                         style: TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                           color: Color.fromRGBO(120, 22, 145, 1),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           "assets/icons/location_pin_grey.png",
//                           width: 16,
//                           height: 16,
//                         ),
//                         Container(
//                           width: 80,
//                           child: Text(
//                             "Place Name",
//                             maxLines: 1,
//                             style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Image.asset(
//                         '$image',
//                         width: getSmallestSide(context),
//                         height: 110,
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8, bottom: 2.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(155, 28, 187, 0.85),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Image.asset(
//                                     "assets/icons/star.png",
//                                     width: 14,
//                                     height: 14,
//                                   ),
//                                   SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     "4.6",
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Flex(
//                               direction: Axis.horizontal,
//                               children: [
//                                 Expanded(
//                                   flex: 3,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/time.png",
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           "40-50 Mints",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               overflow: TextOverflow.ellipsis,
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/kilometer.png",
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           "9.5 km",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                             overflow: TextOverflow.ellipsis,
//                                               fontSize: 12, color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/rider.png",
//                                         width: 22,
//                                         height: 22,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Text(
//                                         "\$2",
//                                         style: TextStyle(
//                                             fontSize: 12, color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(
//           //   height: 10,
//           // ),
//         ],
//       ),
//     );
//   }
// }
