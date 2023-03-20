import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/providers/commen_provider.dart';
import 'package:absher_rider/providers/location/location_provider.dart';
import 'package:intl/intl.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/session_helper.dart';
import '../../models/shift.dart';

class UpComingShiftProvider extends CommenProvider {

  getData(String date) async {
    logInfo("in detail provider");
    c_loading = true;
    notifyListeners();
    var payload = {"date": date};
    String? token = (await getSession());
    var url = "${MJ_Apis.upcoming_shifts}?token=$token";
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

  startShift(
      {required shiftId, required riderId, required lat, required lng}) async {
    logInfo("in detail provider");
    c_loading = true;
    // LocationProvider;
    notifyListeners();
    var payload = {
      "shift_id": shiftId.toString(),
      "rider_id": riderId.toString(),
      "lat": lat.toString(),
      "lng": lng.toString()
    };
    String? token = (await getSession());
    var url = "${MJ_Apis.start_shift}?token=$token";
    setLoading(isMainLoading: true);
    dynamic response = await MjApiService().postRequest(url, payload);
    resetLoading(isMainLoading: false);
    if (response != null) {
      logInfo(response.toString());
      showAlertDialogWithOutContext("Success", "Shift Started Successfully",type: AlertType.SUCCESS);
      String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
      getData(date);
    }
    return true;
  }
}
