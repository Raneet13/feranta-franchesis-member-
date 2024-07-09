import 'package:feranta_franchise/screen/past_record/vechicle/vechicle_list_widget.dart';
import 'package:feranta_franchise/static/flutter_toast_message/toast_messge.dart';
import 'package:feranta_franchise/view_model/vechicle_viewwModel/vechicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../static/color.dart';
import '../../view_model/allRecordViewmodel/all-record_viewmodel.dart';

class PastRecordScreen extends StatefulWidget {
  const PastRecordScreen({super.key});

  @override
  State<PastRecordScreen> createState() => _PastRecordScreenState();
}

class _PastRecordScreenState extends State<PastRecordScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var recordViewModel =
          await Provider.of<RecordViewmodel>(context, listen: false);
      recordViewModel
        ..tabController = TabController(
            length: 2, vsync: this, initialIndex: recordViewModel.initialIndex)
        ..filter = false
        ..viewAllrecord();

      await Provider.of<VehicleViewmodel>(context, listen: false)
        ..allVechicleListViewModel()
        ..getAllMaster();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<RecordViewmodel>(context, listen: false)
        .tabController
        .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("All Record"),
        centerTitle: true,
      ),
      body: Consumer<RecordViewmodel>(builder: (context, record, _) {
        return Column(
          children: [
            Container(
              height: 48,
              child: TabBar(
                padding: EdgeInsets.only(left: 15, right: 15),

                controller: record.tabController,
                // indicatorColor: Colors.amber, // Color of the indicator
                // labelColor: Colors.amber, // Color of the selected tab label
                // unselectedLabelColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                dividerColor: Colors.transparent,
                // labelStyle: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 23),
                isScrollable: false,
                dividerHeight: 0,

                indicatorColor: Colors.transparent,
                indicatorPadding: EdgeInsets.zero,
                onTap: (value) {
                  record.mytripTabno(value);
                },
                indicatorWeight: 1,

                tabAlignment: TabAlignment.fill,
                tabs: [
                  Tab(
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      width: mediaQuery.height * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: record.initialIndex == 0
                              ? Colo.primaryColor
                              : null,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text("Record"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      width: mediaQuery.height * 0.4,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: record.initialIndex == 1
                              ? Colo.primaryColor
                              : null,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Vehicle",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: record.tabController,
                  children: [
                    record.datewseRecord == null && record.allrecord == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : record.allrecord!.response!.userList!.length == 0
                            ? RefreshIndicator(
                                onRefresh: () => Provider.of<RecordViewmodel>(
                                        context,
                                        listen: false)
                                    .viewAllrecord(),
                                child: ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
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
                                    child: record.datewseRecord != null
                                        ? record.datewseRecord!.length == 0
                                            ? ListView.builder(
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder: (context, inde) {
                                                  return SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.8,
                                                    child: Center(
                                                      child: Text(
                                                          "No Record Available"),
                                                    ),
                                                  );
                                                })
                                            : ListView.builder(
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                shrinkWrap: true,
                                                itemCount: record
                                                    .datewseRecord!.length,
                                                itemBuilder: (context, inde) {
                                                  return Container(
                                                    // margin: EdgeInsets.all(10),
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.only(
                                                        top: 8,
                                                        left: 15,
                                                        right: 15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2)
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                                        .format(DateTime.parse(record
                                                                            .datewseRecord![inde]
                                                                            .createdDate!))
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Material(
                                                            color: Colors
                                                                .amber[100],
                                                            shape: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8,
                                                                      right: 8),
                                                              child: Text(
                                                                "${record.datewseRecord![inde].userType == "5" ? "Customer" : ""}${record.datewseRecord![inde].userType == "3" ? "Owner" : ""}${record.datewseRecord![inde].userType == "4" ? "Driver" : ""}",
                                                                style: TextStyle(
                                                                    color: Colo
                                                                        .black,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .width *
                                                                    0.3,
                                                                child: Text(
                                                                  'ID',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                )),
                                                            Text(
                                                              "${record.datewseRecord![inde].id ?? ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .width *
                                                                    0.3,
                                                                child: Text(
                                                                  'Name',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                )),
                                                            Text(
                                                              "${record.datewseRecord![inde].fullName ?? ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .width *
                                                                    0.3,
                                                                child: Text(
                                                                  'Phone Number',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                )),
                                                            Text(
                                                              "${record.datewseRecord![inde].contactNo ?? ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                                width: mediaQuery
                                                                        .width *
                                                                    0.3,
                                                                child: Text(
                                                                  'Email',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                )),
                                                            Text(
                                                              "${record.datewseRecord![inde].email ?? ""}",
                                                              style: Theme.of(
                                                                      context)
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
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Material(
                                                              color: Colors
                                                                  .amber[100],
                                                              shape: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  "${record.datewseRecord![inde].toJson().containsValue("") || record.datewseRecord![inde].toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                                                                  style: TextStyle(
                                                                      color: Colo
                                                                          .black,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            ),
                                                            record.datewseRecord![inde]
                                                                        .userType ==
                                                                    "5"
                                                                ? SizedBox()
                                                                : TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (record
                                                                              .datewseRecord![
                                                                                  inde]
                                                                              .userType ==
                                                                          "3") {
                                                                        context.push(
                                                                            '/home/ownerResister',
                                                                            extra: {
                                                                              'id': "0",
                                                                              'owner': record.datewseRecord![inde]
                                                                            });
                                                                      } else if (record
                                                                              .datewseRecord![
                                                                                  inde]
                                                                              .userType ==
                                                                          "4") {
                                                                        context.push(
                                                                            '/home/resister_driver',
                                                                            extra: {
                                                                              'id': "0",
                                                                              'driver': record.datewseRecord![inde]
                                                                            });
                                                                      } else if (record
                                                                              .datewseRecord![inde]
                                                                              .userType ==
                                                                          "5") {
                                                                        context.push(
                                                                            '/home/customerResister',
                                                                            extra: {
                                                                              'id': "0",
                                                                              'customer': record.datewseRecord![inde]
                                                                            });
                                                                      } else {
                                                                        ShowToast(
                                                                            msg:
                                                                                "You are not Owner");
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            decoration:
                                                                                TextDecoration.underline)),
                                                                  ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                })
                                        : RefreshIndicator(
                                            onRefresh: () =>
                                                Provider.of<RecordViewmodel>(
                                                        context,
                                                        listen: false)
                                                    .viewAllrecord(),
                                            child: ListView.builder(
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                shrinkWrap: true,
                                                itemCount: record.allrecord!
                                                    .response!.userList!.length,
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
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      margin: EdgeInsets.only(
                                                          top: 8,
                                                          left: 15,
                                                          right: 15),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 2)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        // mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            child: Column(
                                                              // mainAxisSize: MainAxisSize.max,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                        width: mediaQuery.width *
                                                                            0.3,
                                                                        child: Text(
                                                                            'Date & Time: ')),
                                                                    Text(
                                                                      DateFormat(
                                                                              'dd/MM/yyyy  hh:mm a')
                                                                          .format(DateTime.parse(record
                                                                              .allrecord!
                                                                              .response!
                                                                              .userList![int]
                                                                              .createdDate!))
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Material(
                                                              color: Colors
                                                                  .amber[100],
                                                              shape: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  "${record.allrecord!.response!.userList![int].userType == "5" ? "Customer" : ""}${record.allrecord!.response!.userList![int].userType == "3" ? "Owner" : ""}${record.allrecord!.response!.userList![int].userType == "4" ? "Driver" : ""}",
                                                                  style: TextStyle(
                                                                      color: Colo
                                                                          .black,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: mediaQuery
                                                                          .width *
                                                                      0.3,
                                                                  child: Text(
                                                                    'ID',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall,
                                                                  )),
                                                              Text(
                                                                "${record.allrecord!.response!.userList![int].id ?? ""}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: mediaQuery
                                                                          .width *
                                                                      0.3,
                                                                  child: Text(
                                                                    'Name',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall,
                                                                  )),
                                                              Text(
                                                                "${record.allrecord!.response!.userList![int].fullName ?? ""}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: mediaQuery
                                                                          .width *
                                                                      0.3,
                                                                  child: Text(
                                                                    'Phone Number',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall,
                                                                  )),
                                                              Text(
                                                                "${record.allrecord!.response!.userList![int].contactNo ?? ""}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: mediaQuery
                                                                          .width *
                                                                      0.3,
                                                                  child: Text(
                                                                    'Email',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .labelSmall,
                                                                  )),
                                                              Text(
                                                                "${record.allrecord!.response!.userList![int].email ?? ""}",
                                                                style: Theme.of(
                                                                        context)
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
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Material(
                                                                color: record
                                                                            .allrecord!
                                                                            .response!
                                                                            .userList![
                                                                                int]
                                                                            .toJson()
                                                                            .containsValue(
                                                                                "") ||
                                                                        record
                                                                            .allrecord!
                                                                            .response!
                                                                            .userList![
                                                                                int]
                                                                            .toJson()
                                                                            .containsValue(
                                                                                null)
                                                                    ? Colo
                                                                        .primaryColor
                                                                    : Colo
                                                                        .black,
                                                                shape: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide:
                                                                        BorderSide
                                                                            .none),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8),
                                                                  child: Text(
                                                                    "${record.allrecord!.response!.userList![int].toJson().containsValue("") || record.allrecord!.response!.userList![int].toJson().containsValue(null) ? "Incomplete" : "Complete"}",
                                                                    style: TextStyle(
                                                                        color: Colo
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                              record
                                                                          .allrecord!
                                                                          .response!
                                                                          .userList![
                                                                              int]
                                                                          .userType ==
                                                                      "5"
                                                                  ? SizedBox()
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (record.allrecord!.response!.userList![int].userType ==
                                                                            "3") {
                                                                          context.push(
                                                                              '/home/ownerResister',
                                                                              extra: {
                                                                                'id': "0",
                                                                                'owner': record.allrecord!.response!.userList![int]
                                                                              });
                                                                        } else if (record.allrecord!.response!.userList![int].userType ==
                                                                            "4") {
                                                                          context.push(
                                                                              '/home/resister_driver',
                                                                              extra: {
                                                                                'id': "0",
                                                                                'driver': record.allrecord!.response!.userList![int]
                                                                              });
                                                                        } else if (record.allrecord!.response!.userList![int].userType ==
                                                                            "4") {
                                                                          context.push(
                                                                              '/home/resister_driver',
                                                                              extra: {
                                                                                'id': "0",
                                                                                'driver': record.allrecord!.response!.userList![int]
                                                                              });
                                                                        } else if (record.allrecord!.response!.userList![int].userType ==
                                                                            "5") {
                                                                          context.push(
                                                                              '/home/customerResister',
                                                                              extra: {
                                                                                'id': "0",
                                                                                'customer': record.allrecord!.response!.userList![int]
                                                                              });
                                                                        } else {
                                                                          ShowToast(
                                                                              msg: "You are not edit");
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Edit",
                                                                        style: TextStyle(
                                                                            decoration:
                                                                                TextDecoration.underline),
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
                                  //   visible: record.showFilterOption,
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
                                  //             // Container(
                                  //             //   height: 40,
                                  //             //   width: double.maxFinite,
                                  //             //   alignment: Alignment.center,
                                  //             //   decoration: BoxDecoration(
                                  //             //       // color: Colors.red,
                                  //             //       border: Border.all(
                                  //             //           color: Colors.grey),
                                  //             //       borderRadius:
                                  //             //           BorderRadius.circular(12)),
                                  //             //   child: Text(
                                  //             //     "Driving License",
                                  //             //     style: Theme.of(context)
                                  //             //         .textTheme
                                  //             //         .bodyMedium,
                                  //             //   ),
                                  //             // ),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                                margin: EdgeInsets.all(15),
                                                height: 48,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color:
                                                            Colo.blackShade45,
                                                        width: .5),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black38,
                                                        // color: Color(0xFFFFE082),
                                                        blurRadius: 2,
                                                      )
                                                    ]),
                                                child: TextField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                  controller:
                                                      record.textfieldText,
                                                  onChanged: (numbe) {
                                                    // ShowToast(
                                                    //     msg: record
                                                    //         .textfieldText
                                                    //         .text);
                                                    // record
                                                    // ..filter = true
                                                    record.licensenoWiserecord(
                                                        record.textfieldText
                                                            .text);
                                                  },
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 20,
                                                              right: 10,
                                                              top: 10),
                                                      border: InputBorder.none,
                                                      hintText:
                                                          "Enter License Number",
                                                      suffixIcon: Icon(
                                                        Icons.search,
                                                      )),
                                                )),
                                          ),
                                          // InkWell(
                                          //   onTap: () async {
                                          //     await record.updateFilterOption(
                                          //         record.showFilterOption);
                                          //     // ..selectDate(context);
                                          //   },
                                          //   child: Icon(Icons.tune),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    VechicleListWidget()
                  ]),
            ),
          ],
        );
      }),
    );
  }
}
