import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../models/order.dart';
import '../../models/order_detail.dart';
import '../no_pagination_provider.dart';

class OrderDetailProvider extends ChangeNotifier {
  Order? _orderItem;
  OrderDetails? _orderDetailItem;
  bool c_loading = false;
  String? _orderId;

  String? get orderId {
    return _orderId;
  }
  Order? get orderItem {
    return _orderItem;
  }
  OrderDetails? get orderDetailItem {
    return _orderDetailItem;
  }
  bool get loading {
    return c_loading;
  }
  set loading(bool load) {
    c_loading = load;
    notifyListeners();
  }
  set orderId(String? val) {
    _orderId = val;
    notifyListeners();
  }
  set orderItem(Order? val) {
    _orderItem = val;
    notifyListeners();
  }
  set orderDetailItem(OrderDetails? val) {
    _orderDetailItem = val;
    notifyListeners();
  }

  getData() async {
    c_loading = true;
    notifyListeners();

    dynamic response = await MjApiService().getRequest(
        MJ_Apis.order_details + "?order_id=$_orderId");

    if (response != null) {
      Order item = Order.fromJson(response['response']["order"]);
      orderItem = item;
    }
      c_loading = false;
      notifyListeners();
  }
}
