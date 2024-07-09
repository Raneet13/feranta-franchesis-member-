import 'package:feranta_franchise/screen/past_record/vechicle/show_bottom_driverList.dart';
import 'package:feranta_franchise/static/flutter_toast_message/toast_messge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/vechicle/vechicle_record_model.dart';
import '../../../static/color.dart';
import '../../../view_model/vechicle_viewwModel/vechicle_view_model.dart';

class vehicleViewWidget extends StatefulWidget {
  VehicleList SingleVehicle;
  vehicleViewWidget({required this.SingleVehicle, super.key});

  @override
  State<vehicleViewWidget> createState() => _vehicleViewWidgetState();
}

class _vehicleViewWidgetState extends State<vehicleViewWidget> {
  String strCab = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.SingleVehicle.bookingType == "1") {
        var vechicleProvider =
            Provider.of<VehicleViewmodel>(context, listen: false);
        var selectStt = vechicleProvider.masterModel?.response?.vehicleType!
            .where((element) => element.id == widget.SingleVehicle.typeId)
            .toList();
        if (selectStt?.length != 0) {
          strCab = selectStt![0].typeName!;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Consumer<VehicleViewmodel>(builder: (context, vehicle, _) {
      return Container(
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 8, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2)],
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text('Date & Time: ')),
                      Text(
                        DateFormat('dd/MM/yyyy  hh:mm a')
                            .format(
                                DateTime.parse(widget.SingleVehicle.createAt!))
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //         width: mediaQuery.width * 0.3,
                  //         child: Text('Franchise')),
                  //     Text(
                  //       "Sahu Motor",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Divider(
              color: Colors.black26,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      minimumSize: Size(0, 0), // Minimum size set to zero
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: widget.SingleVehicle.driverId == null ||
                              widget.SingleVehicle.driverId == ""
                          ? Colo.primaryColor
                          : Colors.green.shade200
                      // padding: EdgeInsets
                      //     .zero,

                      ),
                  onPressed: () async {
                    await vehicle
                      ..allDriverListViewModel();
                    showModalBottomSheetDriverList(
                        context: context,
                        vehicleId: widget.SingleVehicle.id ?? "",
                        ownerID: widget.SingleVehicle.vendorId ?? "");
                  },
                  icon: Text(
                    "${widget.SingleVehicle.driverId == null || widget.SingleVehicle.driverId == "" ? "Assign" : "Assigned"}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  label: Icon(Icons.local_taxi)),
            ),
            Row(
              children: [
                SizedBox(
                    width: mediaQuery.width * 0.3,
                    child: Text(
                      'Vehicle Number',
                      style: Theme.of(context).textTheme.labelSmall,
                    )),
                Text(
                  "${widget.SingleVehicle.regdNo ?? ""}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: mediaQuery.width * 0.3,
                    child: Text(
                      'Booking Type',
                      style: Theme.of(context).textTheme.labelSmall,
                    )),
                Text(
                  "${widget.SingleVehicle.bookingType == "1" ? "CAB" : widget.SingleVehicle.bookingType == "2" ? "LIFT" : "AMBULANCE"}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            widget.SingleVehicle.bookingType == "3"
                ? SizedBox()
                : Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text(
                            'Vehicle Type',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      Text(
                        "${widget.SingleVehicle.bookingType == "3" ? "AMBULANCE" : widget.SingleVehicle.bookingType == "2" ? widget.SingleVehicle.typeId == "1" ? "Bike" : "CAB" ?? "" : strCab ?? ""}", //cabname
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
            widget.SingleVehicle.ownerName != null
                ? Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text(
                            'Owner Name',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      Text(
                        "${widget.SingleVehicle.ownerName ?? ""}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                : SizedBox(),
            widget.SingleVehicle.ownerNumber != null
                ? Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text(
                            'Owner Contact',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      Text(
                        "${widget.SingleVehicle.ownerNumber ?? ""}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                : SizedBox(),
            widget.SingleVehicle.driverName != null
                ? Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text(
                            'Driver Name',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      Text(
                        "${widget.SingleVehicle.driverName ?? ""}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                : SizedBox(),
            widget.SingleVehicle.driverNumber != null
                ? Row(
                    children: [
                      SizedBox(
                          width: mediaQuery.width * 0.3,
                          child: Text(
                            'Driver Phone',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      Text(
                        "${widget.SingleVehicle.driverNumber ?? ""}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: Colors.amber[100],
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      "${widget.SingleVehicle.toJson().containsValue("") || widget.SingleVehicle.toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                      style: TextStyle(
                          color:
                              widget.SingleVehicle.toJson().containsValue("") ||
                                      widget.SingleVehicle.toJson()
                                          .containsValue(null)
                                  ? Colo.black
                                  : Colors.green,
                          fontSize: 12),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // if (vehicle.vechcleRecordModel!.response!.vehicleList! [
                    //             int]
                    //         .userType ==
                    //     "3") {
                    context.push('/home/addVehicle',
                        extra: {'id': "0", 'vehicle': widget.SingleVehicle});
                    // } else {
                    //   ShowToast(
                    //       msg:
                    //           "You are not Owner");
                    // }
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
