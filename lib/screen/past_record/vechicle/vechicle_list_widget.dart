import 'package:feranta_franchise/screen/past_record/vechicle/show_bottom_driverList.dart';
import 'package:feranta_franchise/screen/past_record/vechicle/show_verify_otp_driver.dart';
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
          .allVechicleListViewModel();
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
                                      return Container(
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(
                                            top: 8, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 2)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              child: Column(
                                                // mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width:
                                                              mediaQuery.width *
                                                                  0.3,
                                                          child: Text(
                                                              'Date & Time: ')),
                                                      Text(
                                                        DateFormat(
                                                                'dd/MM/yyyy  hh:mm a')
                                                            .format(DateTime
                                                                .parse(vehicle
                                                                    .datewseRecord![
                                                                        inde]
                                                                    .createAt!))
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'ID',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.datewseRecord![inde].id ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'Vechicle Number',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.datewseRecord![inde].regdNo ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'Engine Number',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.datewseRecord![inde].engineNo ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'Chassis Number',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.datewseRecord![inde].chassisNo ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Material(
                                                  color: Colors.amber[100],
                                                  shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: Text(
                                                      "${vehicle.datewseRecord![inde].toJson().containsValue("") || vehicle.datewseRecord![inde].toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                                                      style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // if (record
                                                    //         .datewseRecord![
                                                    //             inde]
                                                    //         .userType ==
                                                    //     "3") {
                                                    context.push(
                                                        '/home/addVehicle',
                                                        extra: {
                                                          'id': "0",
                                                          'vehicle': vehicle
                                                                  .datewseRecord![
                                                              inde]
                                                        });
                                                    // } else {
                                                    //   ShowToast(
                                                    //       msg:
                                                    //           "You are not Owner");
                                                    // }
                                                  },
                                                  child: Text("Edit",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
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
                                      return GestureDetector(
                                        onTap: () {
                                          // Provider.of<DriverViewmodel>(context, listen: false)
                                          //     .defaultPanelState = PanelState.CLOSED; //fullDtlsTrip
                                          // context.push('/mytrip/fullDtlsTrip', extra: {'id': "1"});

                                          /// context.push('/home/driverfindscr', extra: {'id': "0"});
                                        },
                                        child: Container(
                                          // margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(
                                              top: 8, left: 15, right: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 2)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  // mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: mediaQuery
                                                                    .width *
                                                                0.3,
                                                            child: Text(
                                                                'Date & Time: ')),
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy  hh:mm a')
                                                              .format(DateTime
                                                                  .parse(vehicle
                                                                      .vechcleRecordModel!
                                                                      .response!
                                                                      .vehicleList![
                                                                          int]
                                                                      .createAt!))
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton.icon(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    right: 5),
                                                            minimumSize: Size(0,
                                                                0), // Minimum size set to zero
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            backgroundColor: vehicle
                                                                            .vechcleRecordModel!
                                                                            .response!
                                                                            .vehicleList![
                                                                                int]
                                                                            .driverId ==
                                                                        null ||
                                                                    vehicle
                                                                            .vechcleRecordModel!
                                                                            .response!
                                                                            .vehicleList![int]
                                                                            .driverId ==
                                                                        ""
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
                                                          vehicleId: vehicle
                                                                  .vechcleRecordModel!
                                                                  .response!
                                                                  .vehicleList![
                                                                      int]
                                                                  .id ??
                                                              "",
                                                          ownerID: vehicle
                                                                  .vechcleRecordModel!
                                                                  .response!
                                                                  .vehicleList![
                                                                      int]
                                                                  .vendorId ??
                                                              "");
                                                    },
                                                    icon: Text(
                                                      "${vehicle.vechcleRecordModel!.response!.vehicleList![int].driverId == null || vehicle.vechcleRecordModel!.response!.vehicleList![int].driverId == "" ? "Assign" : "Assigned"}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                    label: Icon(Icons.local_taxi)),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'ID',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].id ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Vechicle Number',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].regdNo ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Engine Number',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].engineNo ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Chassis Number',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].chassisNo ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Owner Name',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].ownerName ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Owner Contact',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].ownerNumber ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Drivver Name',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].driverName ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.3,
                                                      child: Text(
                                                        'Driver Phone',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      )),
                                                  Text(
                                                    "${vehicle.vechcleRecordModel!.response!.vehicleList![int].driverNumber ?? ""}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Material(
                                                    color: Colors.amber[100],
                                                    shape: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8),
                                                      child: Text(
                                                        "${vehicle.vechcleRecordModel!.response!.vehicleList![int].toJson().containsValue("") || vehicle.vechcleRecordModel!.response!.vehicleList![int].toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                                                        style: TextStyle(
                                                            color: Colors.amber,
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
                                                      context.push(
                                                          '/home/addVehicle',
                                                          extra: {
                                                            'id': "0",
                                                            'vehicle': vehicle
                                                                .vechcleRecordModel!
                                                                .response!
                                                                .vehicleList![int]
                                                          });
                                                      // } else {
                                                      //   ShowToast(
                                                      //       msg:
                                                      //           "You are not Owner");
                                                      // }
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
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
