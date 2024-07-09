import 'package:feranta_franchise/screen/past_record/vechicle/show_bottom_driverList.dart';
import 'package:feranta_franchise/screen/past_record/vechicle/show_verify_otp_driver.dart';
import 'package:feranta_franchise/screen/past_record/vechicle/vehicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../static/color.dart';
import '../../../view_model/vechicle_viewwModel/vechicle_view_model.dart';

class VechicleListWidget extends StatefulWidget {
  const VechicleListWidget({super.key});

  @override
  State<VechicleListWidget> createState() => _VechicleListWidgetState();
}

class _VechicleListWidgetState extends State<VechicleListWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<VehicleViewmodel>(context, listen: false)
        ..allVechicleListViewModel()
        ..getAllMaster();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Consumer<VehicleViewmodel>(
      builder: (context, vehicle, _) {
        return vehicle.vechcleRecordModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : vehicle.vechcleRecordModel!.response!.vehicleList!.length == 0
                ? RefreshIndicator(
                    onRefresh: () =>
                        Provider.of<VehicleViewmodel>(context, listen: false)
                            .allVechicleListViewModel(),
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Center(
                              child: Text("No Record Available"),
                            ),
                          );
                        }),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: vehicle.filter == true &&
                                vehicle.datewseRecord != null
                            ? vehicle.datewseRecord!.length == 0
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 15),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, inde) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: Center(
                                          child: Text("No Record Available"),
                                        ),
                                      );
                                    })
                                : ListView.builder(
                                    padding: EdgeInsets.only(bottom: 15),
                                    shrinkWrap: true,
                                    itemCount: vehicle.datewseRecord!.length,
                                    itemBuilder: (context, inde) {
                                      return vehicleViewWidget(
                                        SingleVehicle:
                                            vehicle.datewseRecord![inde],
                                      );
                                      // return vehicleViewWidget(context,
                                      //     vehicle.datewseRecord![inde]);
                                      // return Container(
                                      //   // margin: EdgeInsets.all(10),
                                      //   padding: EdgeInsets.all(10),
                                      //   margin: EdgeInsets.only(
                                      //       top: 8, left: 15, right: 15),
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white,
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //             color: Colors.black,
                                      //             blurRadius: 2)
                                      //       ],
                                      //       borderRadius:
                                      //           BorderRadius.circular(12)),
                                      //   child: Column(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.start,
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     // mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       SizedBox(
                                      //         child: Column(
                                      //           // mainAxisSize: MainAxisSize.max,
                                      //           children: [
                                      //             Row(
                                      //               children: [
                                      //                 SizedBox(
                                      //                     width:
                                      //                         mediaQuery.width *
                                      //                             0.3,
                                      //                     child: Text(
                                      //                         'Date & Time: ')),
                                      //                 Text(
                                      //                   DateFormat(
                                      //                           'dd/MM/yyyy  hh:mm a')
                                      //                       .format(DateTime
                                      //                           .parse(vehicle
                                      //                               .datewseRecord![
                                      //                                   inde]
                                      //                               .createAt!))
                                      //                       .toString(),
                                      //                   style: TextStyle(
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .bold),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             // Row(
                                      //             //   children: [
                                      //             //     SizedBox(
                                      //             //         width: mediaQuery.width * 0.3,
                                      //             //         child: Text('Franchise')),
                                      //             //     Text(
                                      //             //       "Sahu Motor",
                                      //             //       style: TextStyle(
                                      //             //           fontWeight: FontWeight.bold),
                                      //             //     ),
                                      //             //   ],
                                      //             // ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       Divider(
                                      //         color: Colors.black26,
                                      //       ),
                                      //       Row(
                                      //         children: [
                                      //           SizedBox(
                                      //               width:
                                      //                   mediaQuery.width * 0.3,
                                      //               child: Text(
                                      //                 'Vehicle Type',
                                      //                 style: Theme.of(context)
                                      //                     .textTheme
                                      //                     .labelSmall,
                                      //               )),
                                      //           Text(
                                      //             "${vehicle.datewseRecord![inde].bookingType == null || vehicle.datewseRecord![inde].bookingType == "" ? "" : vehicle.vehicleType[int.parse(vehicle.datewseRecord![inde].bookingType ?? "") - 1] ?? ""}",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .bodyMedium,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       Row(
                                      //         children: [
                                      //           SizedBox(
                                      //               width:
                                      //                   mediaQuery.width * 0.3,
                                      //               child: Text(
                                      //                 'Vehicle Type',
                                      //                 style: Theme.of(context)
                                      //                     .textTheme
                                      //                     .labelSmall,
                                      //               )),
                                      //           Text(
                                      //             "${vehicle.datewseRecord![inde].typeId ?? ""}",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .bodyMedium,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       Row(
                                      //         children: [
                                      //           SizedBox(
                                      //               width:
                                      //                   mediaQuery.width * 0.3,
                                      //               child: Text(
                                      //                 'Vehicle Number',
                                      //                 style: Theme.of(context)
                                      //                     .textTheme
                                      //                     .labelSmall,
                                      //               )),
                                      //           Text(
                                      //             "${vehicle.datewseRecord![inde].regdNo ?? ""}",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .bodyMedium,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment
                                      //                 .spaceBetween,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.center,
                                      //         children: [
                                      //           Material(
                                      //             color: Colors.amber[100],
                                      //             shape: OutlineInputBorder(
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         10),
                                      //                 borderSide:
                                      //                     BorderSide.none),
                                      //             child: Padding(
                                      //               padding:
                                      //                   const EdgeInsets.only(
                                      //                       left: 8, right: 8),
                                      //               child: Text(
                                      //                 "${vehicle.datewseRecord![inde].toJson().containsValue("") || vehicle.datewseRecord![inde].toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                                      //                 style: TextStyle(
                                      //                     color: vehicle
                                      //                                 .datewseRecord![
                                      //                                     inde]
                                      //                                 .toJson()
                                      //                                 .containsValue(
                                      //                                     "") ||
                                      //                             vehicle
                                      //                                 .datewseRecord![
                                      //                                     inde]
                                      //                                 .toJson()
                                      //                                 .containsValue(
                                      //                                     null)
                                      //                         ? Colo.black
                                      //                         : Colors.green,
                                      //                     fontSize: 12),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           TextButton(
                                      //             onPressed: () {
                                      //               // if (record
                                      //               //         .datewseRecord![
                                      //               //             inde]
                                      //               //         .userType ==
                                      //               //     "3") {
                                      //               context.push(
                                      //                   '/home/addVehicle',
                                      //                   extra: {
                                      //                     'id': "0",
                                      //                     'vehicle': vehicle
                                      //                             .datewseRecord![
                                      //                         inde]
                                      //                   });
                                      //               // } else {
                                      //               //   ShowToast(
                                      //               //       msg:
                                      //               //           "You are not Owner");
                                      //               // }
                                      //             },
                                      //             child: Text("Edit",
                                      //                 style: TextStyle(
                                      //                     decoration:
                                      //                         TextDecoration
                                      //                             .underline)),
                                      //           ),
                                      //         ],
                                      //       )
                                      //     ],
                                      //   ),
                                      // );
                                    })
                            : RefreshIndicator(
                                onRefresh: () => Provider.of<VehicleViewmodel>(
                                        context,
                                        listen: false)
                                    .allVechicleListViewModel(),
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 15),
                                    shrinkWrap: true,
                                    itemCount: vehicle.vechcleRecordModel!
                                        .response!.vehicleList!.length,
                                    itemBuilder: (context, int) {
                                      return vehicleViewWidget(
                                          SingleVehicle: vehicle
                                              .vechcleRecordModel!
                                              .response!
                                              .vehicleList![int]);
                                    }),
                              ),
                      ),
                      // Visibility(
                      //   visible: vehicle.showFilterOption,
                      //   child: Positioned(
                      //       top: 50,
                      //       right: 20,
                      //       child: Container(
                      //         height: 130,
                      //         width: 150,
                      //         decoration: BoxDecoration(
                      //             color: Colors.grey.shade300,
                      //             borderRadius:
                      //                 BorderRadius.circular(15)),
                      //         padding: EdgeInsets.all(10),
                      //         child: Column(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceEvenly,
                      //           // mainAxisSize: MainAxisSize.max,
                      //           children: [
                      //             InkWell(
                      //               onTap: () => record
                      //                 ..filter = true
                      //                 ..selectDate(context),
                      //               child: Container(
                      //                 height: 40,
                      //                 width: double.maxFinite,
                      //                 alignment: Alignment.center,
                      //                 decoration: BoxDecoration(
                      //                     // color: Colors.red,
                      //                     border: Border.all(
                      //                         color: Colors.grey),
                      //                     borderRadius:
                      //                         BorderRadius.circular(
                      //                             12)),
                      //                 child: Text(
                      //                   "Date",
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyMedium,
                      //                 ),

                      //                 // height: 150,
                      //                 // width: 200,
                      //               ),
                      //             ),
                      //             Container(
                      //               height: 40,
                      //               width: double.maxFinite,
                      //               alignment: Alignment.center,
                      //               decoration: BoxDecoration(
                      //                   // color: Colors.red,
                      //                   border: Border.all(
                      //                       color: Colors.grey),
                      //                   borderRadius:
                      //                       BorderRadius.circular(12)),
                      //               child: Text(
                      //                 "Driving License",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyMedium,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      // ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Container(
                              margin: EdgeInsets.all(15),
                              height: 48,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colo.blackShade45, width: .5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black38,
                                      // color: Color(0xFFFFE082),
                                      blurRadius: 2,
                                    )
                                  ]),
                              child: TextField(
                                style: Theme.of(context).textTheme.bodySmall,
                                controller: vehicle.textfieldText,
                                onChanged: (numbe) => vehicle
                                  ..filter = true
                                  ..vechiceNoWiserecord(numbe),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20, right: 10, top: 10),
                                    border: InputBorder.none,
                                    hintText: "Enter Vehicle Number",
                                    suffixIcon: Icon(
                                      Icons.search,
                                    )),
                              )),
                        ),
                      ),
                    ],
                  );
      },
    );
  }
}
