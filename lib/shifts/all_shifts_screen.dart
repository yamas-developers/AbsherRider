import 'package:absher_rider/helpers/public_methods.dart';
import 'package:absher_rider/models/shift.dart';
import 'package:absher_rider/providers/user/user_provider.dart';
import 'package:absher_rider/ui/common_widgets/app_color_button.dart';
import 'package:absher_rider/ui/common_widgets/touchable_opacity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../providers/shift/all_shifts_provider.dart';

class AllShiftsScreen extends StatefulWidget {
  const AllShiftsScreen({Key? key}) : super(key: key);

  @override
  State<AllShiftsScreen> createState() => _AllShiftsScreenState();
}

class _AllShiftsScreenState extends State<AllShiftsScreen> {
  String selectedDate = '';

  getPageData() {
    var shiftProvider = context.read<AllShiftProvider>();
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    shiftProvider.getData(date);
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPageData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
              enablePastDates: false,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Shifts",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text("(${selectedDate})"),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Consumer<AllShiftProvider>(builder: (key, provider, child) {
                    return provider.loading
                        ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.4,
                        ))
                        : SizedBox();
                  })
                ],
              ),
            ),
            SizedBox(height: 2,),
            Consumer<AllShiftProvider>(builder: (key, provider, child) {
              return Column(
                children: [
                  ...provider.list
                      .map((e) => ShiftListItem(
                    shift: e,
                  ))
                      .toList()
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs date) {
    var _date = DateFormat('yyyy-MM-dd').format(date.value).toString();
    print(_date);
    if (_date.isNotEmpty) {
      setState(() {
        selectedDate = _date;
      });
      context.read<AllShiftProvider>().getData(_date);
    }
  }
}

class ShiftListItem extends StatefulWidget {
  Shift shift;

  ShiftListItem({Key? key, required this.shift}) : super(key: key);

  @override
  State<ShiftListItem> createState() => _ShiftListItemState();
}

class _ShiftListItemState extends State<ShiftListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: getWidth(context),
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.shift.description ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      "${shiftTimeFormate(widget.shift.startTime)} - ${shiftTimeFormate(widget.shift.endTime)} / ${shiftTimeDifferenceHours(widget.shift.startTime, widget.shift.endTime)}h",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )),
            Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TouchableOpacity(
                      onTap: () {
                        if(widget.shift.isTaken) return;
                        var riderId = context.read<UserProvider>().currentUser!.id;
                        context.read<AllShiftProvider>().takeShift(widget.shift.id, riderId);
                      },
                      child: AppColorButton(
                        onPressed: null,
                        name: widget.shift.isTaken?"Taken":"Take Shift",
                        elevation: 0,
                        fontSize: 12,
                        width: 120,
                      ))
                ]))
          ]))
    ]);
  }
}
