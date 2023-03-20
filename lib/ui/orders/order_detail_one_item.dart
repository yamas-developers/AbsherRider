import 'package:flutter/material.dart';

class OrderDetailOneItem extends StatelessWidget {
  const OrderDetailOneItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // SizedBox(
          //   width: 6,
          // ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/temp/order_item${index}.png",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ],
              )),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 12,),
                  Text(
                    "\$ 2.99",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      // color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet  et dolore",
                    style: TextStyle(
                        fontSize: 12,
                        // color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),

                  // SizedBox(height: 12,),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    "Qty",
                    style: TextStyle(
                        fontSize: 12,
                        // color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "${index}",
                    style: TextStyle(
                        fontSize: 14,
                        // color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}