import 'dart:convert';
import 'dart:developer';
import 'package:absher_rider/helpers/public_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/session_helper.dart';
import '../../models/order.dart';
import '../../models/order_detail.dart';
import '../no_pagination_provider.dart';

class UpcomingOrderDetailProvider extends ChangeNotifier {
  Order? _orderItem;
  OrderDetails? _orderDetailItem;
  bool c_loading = false;
  String? _orderId;
  bool acceptLoading = false;


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
    dynamic response = await MjApiService()
        .getRequest(MJ_Apis.order_details + "?order_id=$_orderId");
    loading = false;
    notifyListeners();
    if (response != null) {
      Order item = Order.fromJson(response['response']["order"]);
      orderItem = item;
      notifyListeners();
    }
  }

  Future<bool> acceptOrder(orderId, riderId) async {
    // accept_order
    acceptLoading = true;
    notifyListeners();
    String? token = (await getSession());
    dynamic response = await MjApiService()
        .getRequest(
        MJ_Apis.accept_order + "?token=${token}&order_id=$_orderId&rider_id=$riderId");
    acceptLoading = false;
    notifyListeners();
    if (response != null) {
      return true;
      // showSnakeBar("Success", "Order Assigned ")
      // Order item = Order.fromJson(response['response']["order"]);
      // orderItem = item;
      // notifyListeners();

    }
    return false;
    // c_loading = false;
  }
}
