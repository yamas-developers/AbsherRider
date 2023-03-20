import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/query.dart';

class SupportProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;
  MjApiService apiService = MjApiService();

  fetchQueries(String? parentId) async {
    _loading = true;
    notifyListeners();
    dynamic response = await apiService.getRequest(
        MJ_Apis.get_queries + "?role=rider&parent_id=${parentId ?? ''}");
    _loading = false;
    List<Query> queryList = [];
    if (response != null) {
      for (int i = 0; i < response["response"]['data'].length; i++) {
        queryList.add(Query.fromJson(response["response"]['data'][i]));
      }
    }
    notifyListeners();
    return queryList;
  }

  sendRequest(name, description, userId, queryId) async {

    MjApiService apiService = MjApiService();
    dynamic payload = {
      "name": name,
      "description": description,
      "user_id": userId,
      "query_id": queryId,
    };
    log("payload here: ${payload}");
    try {
      dynamic response =
          await apiService.postRequest(MJ_Apis.send_request, payload);
      if (response != null) {
        showToast(response['message']);
        return true;
      }
      return false;
    } catch (e) {
      log('error in support provider: $e');
      return false;
    }
  }
}
