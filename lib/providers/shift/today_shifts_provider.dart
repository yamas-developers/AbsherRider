import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/providers/commen_provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/session_helper.dart';
import '../../models/shift.dart';

class TodayShiftProvider extends CommenProvider {
  getData(String date) async {
    logInfo("in detail provider");
    c_loading = true;
    notifyListeners();
    var payload = {"date": date};
    String? token = (await getSession());
    var url = "${MJ_Apis.shifts}?token=$token";
    setLoading(isMainLoading: true);
    dynamic response = await MjApiService().postRequest(url, payload);
    resetLoading(isMainLoading: false);
    if (response != null) {
      logInfo(response.toString());
      var data = response['response'];
      List<Shift> list = [];
      for (var d in data) {
        list.add(Shift.fromJson(d));
      }
      setData(list, isNoMore: true);
    }
  }
}
