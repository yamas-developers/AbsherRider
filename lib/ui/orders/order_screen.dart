import '../../helpers/route_constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/build_slide_transition.dart';
import '../common_widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 18, 0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/icons/back_arrow_icon.png",
                                width: 24,
                                height: 24,
                                color: lightModeOn(context) ? mainColor :lightGreyColor,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          // height: 39,
                          padding: EdgeInsets.fromLTRB(4, 9, 4, 9),
                          decoration: BoxDecoration(
                              color: lightModeOn(context) ? Colors.white :Colors.black12,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  blurRadius: 6,
                                  spreadRadius: .1,
                                ),
                              ]),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                "assets/icons/search_icon.png",
                                width: 20,
                                height: 20,
                                color: lightModeOn(context) ? mainColor : Colors.white70,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Flexible(
                                  child: Text(
                                "Search",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: lightModeOn(context) ? mainColor : Colors.white70,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, notifications_screen);
                              },
                              child: Image.asset(
                                "assets/icons/notification.png",
                                width: 24,
                                color: lightModeOn(context) ? mainColor :lightGreyColor,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
              ]),
            ),
          ];
        },
        body: SizedBox(
          height: getHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: darkGreyColor.withOpacity(.35),
                          offset: Offset(0, 1),
                          blurRadius: 8,
                        )
                      ]
                      // border: Border.all(
                      //   color:  Color.fromRGBO(27, 189, 198, 1),
                      // ),
                      ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TabBar(
                      controller: tabController,
                      indicator: BoxDecoration(
                        color: lightModeOn(context) ? mainColor :lightGreyColor,
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [
                              mainColor,
                              mainColorLight.withOpacity(0.8)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: darkGreyColor,
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),

                      tabs: [
                        Tab(
                          text: 'Current Orders',
                        ),
                        Tab(
                          text: 'Past Orders',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // height: getHeight(context),
                child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 18, right: 12),
                    child: ListView(
                      children: [
                        ...List.generate(5, (index) {
                          if (index == 0) animationDuration = 0;
                          return BuildSlideTransition(
                            child: OrderItem(),
                            animationDuration: animationDuration += 300,
                            curve: Curves.easeInBack,
                          );
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 18, right: 12),
                    child: ListView(
                      children: [
                        ...List.generate(5, (index) {
                          if (index == 0) animationDuration = 0;
                          return BuildSlideTransition(
                            child: OrderItem(),
                            animationDuration: animationDuration += 300,
                            curve: Curves.easeInBack,
                            startPos: -1.0,
                          );
                        })
                      ],
                    ),
                  ),
                ]),
              ),
              // SizedBox(
              //   height: 35,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
