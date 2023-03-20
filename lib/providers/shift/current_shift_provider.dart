import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/providers/commen_provider.dart';
import 'package:absher_rider/providers/location/location_provider.dart';
import 'package:intl/intl.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/session_helper.dart';
import '../../models/shift.dart';

class CurrentShiftProvider extends CommenProvider {

  getData(userId) async {
    if(userId == null){
      showToast("invalid user");
      return;
    }
    logInfo("in detail provider");
    c_loading = true;
    notifyListeners();
    var payload = {"rider_id": userId.toString()};
    String? token = (await getSession());
    var url = "${MJ_Apis.current_shift}?token=$token";
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
