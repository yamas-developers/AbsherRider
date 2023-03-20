import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/providers/commen_provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/session_helper.dart';
import '../../models/shift.dart';

class AllShiftProvider extends CommenProvider {
  bool endShiftLoading = false;
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
  takeShift(shiftId, riderId) async {
    logInfo("in detail provider");
    c_loading = true;
    notifyListeners();
    var payload = {"shift_id": shiftId.toString(), "rider_id": riderId.toString()};
    String? token = (await getSession());
    var url = "${MJ_Apis.take_shift}?token=$token";
    setLoading(isMainLoading: true);
    dynamic response = await MjApiService().postRequest(url, payload);
    resetLoading(isMainLoading: false);
    if (response != null) {
      logInfo(response.toString());
      var data = response['response'];
      markAsTaken(shiftId);
    }
  }
  markAsTaken(shiftId){
    var shiftIndex = list.indexWhere((element) => shiftId == element.id);
    if(shiftIndex > 0){
      c_list[shiftIndex].isTaken = true;
      notifyListeners();
    }
  }
  endShift(shiftId, riderId) async {
    logInfo("in detail provider");
    // c_loading = true;
    String? token = (await getSession());
    endShiftLoading = true;
    notifyListeners();
    var url = "${MJ_Apis.end_shift}?token=$token&shift_id=${shiftId.toString()}&rider_id=${riderId.toString()}";
    // setLoading(isMainLoading: true);
    dynamic response = await MjApiService().getRequest(url);
    // resetLoading(isMainLoading: false);
    endShiftLoading = false;
    if (response != null) {
      logInfo(response.toString());
      var data = response['response'];
      markAsTaken(shiftId);
    }
  }
}
