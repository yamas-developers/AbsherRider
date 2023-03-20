import 'dart:developer';

import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../models/query.dart';
import '../../providers/support/support_provider.dart';
import '../common_widgets/rounded_center_button.dart';

class SendRequestScreen extends StatefulWidget {
  SendRequestScreen();
  @override
  _SendRequestScreenState createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  @override
  void initState() {
    super.initState();
    getQueries();
  }

  TextEditingController commentController = TextEditingController();

  Future<void> getQueries() async {}
Query? query;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      return;
    }
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        query = args["query"]??'';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Send Your Request",
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
          SizedBox(height: 20,),
          Text("${query?.name??''}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: lightModeOn(context)
                    ? mediumGreyFontColor
                    : Colors.white,
                fontSize: 18,
              )),
          SizedBox(height: 30,),
          // Padding(
          //   padding: const EdgeInsets.only(left: 0),
          //   child: Text(
          //     "Provide Details",
          //     style: TextStyle(
          //         color: blackFontColor,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w600),
          //   ),
          // ),
          // SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              decoration:
              BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: darkGreyColor.withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 8)
                  ],
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
              ),
              child: TextField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: "Write your message here",
                    border: InputBorder.none
                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 34,
          ),
          RoundedCenterButtton(
            title: "Send",
            onPressed: () async {
              if(commentController.text.isEmpty){
                showToast('Message can not be empty');
                return;
              }

              showProgressDialog(context, 'Sending Request');
              try{
              String userId = context.read<UserProvider>().currentUser?.id??'';
              log('MK: here');
                bool res = await context.read<SupportProvider>()
                    .sendRequest(query?.name, commentController.text, userId, query?.id);
                if(res){
                  Navigator.pop(context);
                }
              }catch(e){
                log("error $e");
              }
              hideProgressDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
