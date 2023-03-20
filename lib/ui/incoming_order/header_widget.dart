
import 'package:absher_rider/helpers/route_constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../support/support_screen.dart';

class OrderHeaderSupportWidget extends StatelessWidget {
  const OrderHeaderSupportWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text("$title",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: lightModeOn(context)
                          ? mediumGreyFontColor
                          : Colors.white,
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                  child: IconButton(
                    icon: Icon(Icons.headset_mic_rounded),
                    padding: EdgeInsets.zero,
                    color: mainColorLight,
                    onPressed: (){
                      Navigator.pushNamed(context, support_screen);
                    },
                  )
              )),
        ],
      ),
    );
  }
}