import 'dart:developer';

import 'package:absher_rider/helpers/route_constants.dart';
import 'package:absher_rider/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../models/query.dart';
import '../../providers/support/support_provider.dart';

class QueryListScreen extends StatefulWidget {
  QueryListScreen();

  @override
  _QueryListScreenState createState() => _QueryListScreenState();
}

class _QueryListScreenState extends State<QueryListScreen> {
  List<Query> queries = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> getQueries(parentId) async {
    log("MK: in get queries");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<Query> queryList =
          await context.read<SupportProvider>().fetchQueries(parentId ?? '0');

      setState(() {
        queries = queryList;
      });
    });
  }

  String parentId = '0';

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) {
      getQueries('0');
      return;
    }
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      parentId = args["parent_id"] ?? '0';
    }
    getQueries(parentId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Consumer<SupportProvider>(builder: (context, supportProvider, _) {
        return Column(
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
                  Text("Support Center",
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
              child: supportProvider.loading
                  ? LoadingIndicator()
                  : ListView.builder(
                      itemCount: queries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 4),
                          child: ListTile(
                            title: Text(
                              queries[index].name ?? 'Unable to fetch name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            subtitle: Text(
                                queries[index].description ??
                                    'Unable to fetch description',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13)),
                            onTap: () {
                              if (queries[index].childrenCount > 0)
                                Navigator.pushNamed(context, support_screen,
                                    arguments: {
                                      'parent_id': queries[index].id
                                    });
                              else
                                Navigator.pushNamed(
                                    context, send_request_screen,
                                    arguments: {'query': queries[index]});
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}
