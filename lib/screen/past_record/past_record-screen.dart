import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../view_model/allRecordViewmodel/all-record_viewmodel.dart';

class PastRecordScreen extends StatefulWidget {
  const PastRecordScreen({super.key});

  @override
  State<PastRecordScreen> createState() => _PastRecordScreenState();
}

class _PastRecordScreenState extends State<PastRecordScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<RecordViewmodel>(context, listen: false).viewAllrecord());
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
        return record.allrecord == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : record.allrecord!.response!.userList!.length == 0
                ? RefreshIndicator(
                    onRefresh: () =>
                        Provider.of<RecordViewmodel>(context, listen: false)
                            .viewAllrecord(),
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Center(
                              child: Text("No Data Available"),
                            ),
                          );
                        }),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        Provider.of<RecordViewmodel>(context, listen: false)
                            .viewAllrecord(),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 15),
                        shrinkWrap: true,
                        itemCount: record.allrecord!.response!.userList!.length,
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
                              margin:
                                  EdgeInsets.only(top: 8, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2)
                                  ],
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
                                                  .format(DateTime.parse(record
                                                      .allrecord!
                                                      .response!
                                                      .userList![int]
                                                      .createdDate!))
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                                    alignment: Alignment.bottomRight,
                                    child: Material(
                                      color: Colors.amber[100],
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text(
                                          "${record.allrecord!.response!.userList![int].userType == "5" ? "Customer" : ""}${record.allrecord!.response!.userList![int].userType == "3" ? "Owner" : ""}${record.allrecord!.response!.userList![int].userType == "4" ? "Driver" : ""}",
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'ID',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${record.allrecord!.response!.userList![int].id ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${record.allrecord!.response!.userList![int].fullName ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'Phone Number',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${record.allrecord!.response!.userList![int].contactNo ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'Email',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${record.allrecord!.response!.userList![int].email ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),

                                  // SizedBox(
                                  //   height: 70,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Row(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //         children: [
                                  //           Column(
                                  //             children: [
                                  //               SizedBox(
                                  //                 height: 35,
                                  //                 width: 15,
                                  //                 child: Image.asset(
                                  //                   'assets/svg/feranta_path_marker.png',
                                  //                   height: 25,
                                  //                   fit: BoxFit.contain,
                                  //                   // color: colorValue,
                                  //                 ),
                                  //               ),
                                  //               SizedBox(
                                  //                 height: 35,
                                  //                 width: 15,
                                  //                 child: Image.asset(
                                  //                   'assets/svg/feranta_destination_marker.png',
                                  //                   height: 25,
                                  //                   fit: BoxFit.contain,
                                  //                   // color: colorValue,
                                  //                 ),
                                  //               ),
                                  //               // Icon(Icons.person_pin_circle_outlined),
                                  //               // Icon(Icons.pin_drop_outlined)
                                  //             ],
                                  //           ),
                                  //           SizedBox(
                                  //             width: 10,
                                  //           ),
                                  //           SizedBox(
                                  //             height: 60,
                                  //             child: Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.spaceBetween,
                                  //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   "365 cityhall Park",
                                  //                   style: Theme.of(context)
                                  //                       .textTheme
                                  //                       .bodyMedium,
                                  //                 ),
                                  //                 Text(
                                  //                   "365 cityhall Park",
                                  //                   style: Theme.of(context)
                                  //                       .textTheme
                                  //                       .bodyMedium,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             "9:40 PM",
                                  //             style: Theme.of(context).textTheme.labelSmall,
                                  //           ),
                                  //           Text(
                                  //             "10:10 PM",
                                  //             style: Theme.of(context).textTheme.labelSmall,
                                  //           ),
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),

                                  // Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: ElevatedButton(
                                  //     onPressed: () => null,
                                  //     // Navigator.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(
                                  //     //         builder: (context) => FullDetaisTrip())),
                                  //     child: Text(
                                  //       "View Details",
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontSize:
                                  //               12), // use green for completed & red for cancel &yellow for futre booking
                                  //     ),
                                  //     style: ElevatedButton.styleFrom(
                                  //         padding: EdgeInsets.all(5),
                                  //         minimumSize: Size(double.minPositive, 0),
                                  //         elevation: 1,
                                  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  //         backgroundColor: Colors
                                  //             .amber, //Colors.red[100], //Colors.amber[50], // all the color has match according to the future ||completed|| cancel order
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius: BorderRadius.circular(5),
                                  //             side: BorderSide.none)),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
      }),
    );
  }
}
