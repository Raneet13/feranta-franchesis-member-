import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feranta_franchise/screen/back_to_close/systum_back_close_app.dart';
import 'package:feranta_franchise/view_model/auth/login-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../configs/app_url.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BackButtonInterceptor.add(backTocloseApp(context).myInterceptor);
      Provider.of<LoginViewmodel>(context, listen: false).checkInOutHistory();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(backTocloseApp(context).myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        centerTitle: true,
      ),
      body: Consumer<LoginViewmodel>(builder: (context, record, _) {
        return record.checkInoutHistoryModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : record.checkInoutHistoryModel!.response!.checklist!.length == 0
                ? RefreshIndicator(
                    onRefresh: () =>
                        Provider.of<LoginViewmodel>(context, listen: false)
                            .checkInOutHistory(),
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
                        Provider.of<LoginViewmodel>(context, listen: false)
                            .checkInOutHistory(),
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 15),
                        shrinkWrap: true,
                        itemCount: record.checkInoutHistoryModel!.response!
                            .checklist!.length,
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
                                  ListTile(
                                    titleTextStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    leading: CachedNetworkImage(
                                        height: 50,
                                        width: 50,
                                        imageUrl:
                                            "${AppUrl.imageUrl}${record.checkInoutHistoryModel!.response!.checklist![int].image}"),
                                    title: Row(
                                      children: [
                                        SizedBox(child: Text('Date: ')),
                                        Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(DateTime.parse(
                                                  "${record.checkInoutHistoryModel!.response!.checklist![int].date ?? ""}"))
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        SizedBox(child: Text('Time: ')),
                                        Text(
                                          DateFormat('hh:mm a')
                                              .format(DateFormat('HH:mm:ss').parse(
                                                  "${record.checkInoutHistoryModel!.response!.checklist![int].time ?? ""}"))
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    trailing: Text(
                                        "${record.checkInoutHistoryModel!.response!.checklist![int].type ?? ""}"),
                                  ),
                                  // SizedBox(
                                  //   child: Column(
                                  //     // mainAxisSize: MainAxisSize.max,
                                  //     children: [
                                  //       Row(
                                  //         children: [
                                  //           SizedBox(
                                  //               width: mediaQuery.width * 0.3,
                                  //               child: Text('Date')),
                                  //           Text(
                                  //             DateFormat('dd/MM/yyyy')
                                  //                 .format(DateTime.parse(
                                  //                     "${record.checkInoutHistoryModel!.response!.checklist![int].date ?? ""}"))
                                  //                 .toString(),
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       Row(
                                  //         children: [
                                  //           SizedBox(
                                  //               width: mediaQuery.width * 0.3,
                                  //               child: Text('Time')),
                                  //           Text(
                                  //             DateFormat('hh:mm a')
                                  //                 .format(DateFormat('HH:mm:ss')
                                  //                     .parse(
                                  //                         "${record.checkInoutHistoryModel!.response!.checklist![int].time ?? ""}"))
                                  //                 .toString(),
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       // Row(
                                  //       //   children: [
                                  //       //     SizedBox(
                                  //       //         width: mediaQuery.width * 0.3,
                                  //       //         child: Text('Franchise')),
                                  //       //     Text(
                                  //       //       "Sahu Motor",
                                  //       //       style: TextStyle(
                                  //       //           fontWeight: FontWeight.bold),
                                  //       //     ),
                                  //       //   ],
                                  //       // ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Divider(
                                  //   color: Colors.black26,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.bottomRight,
                                  //   child: Material(
                                  //     color: Colors.amber[100],
                                  //     shape: OutlineInputBorder(
                                  //         borderRadius:
                                  //             BorderRadius.circular(10),
                                  //         borderSide: BorderSide.none),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           left: 8, right: 8),
                                  //       child: Text(
                                  //         "${record.checkInoutHistoryModel!.response!.checklist![int].type == "check_out" ? "CHECKOUT" : "CHECKIN"}",
                                  //         style: TextStyle(
                                  //             color: Colors.amber,
                                  //             fontSize: 12),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //         width: mediaQuery.width * 0.3,
                                  //         child: Text(
                                  //           'ID',
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .labelSmall,
                                  //         )),
                                  //     Text(
                                  //       "${record.checkInoutHistoryModel!.response!.checklist![int].id ?? ""}",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //         width: mediaQuery.width * 0.3,
                                  //         child: Text(
                                  //           'Name',
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .labelSmall,
                                  //         )),
                                  //     Text(
                                  //       "${record.checkInoutHistoryModel!.response!.checklist![int].memberId ?? ""}",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //   ],
                                  // ),
                                  // // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //         width: mediaQuery.width * 0.3,
                                  //         child: Text(
                                  //           'Phone Number',
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .labelSmall,
                                  //         )),
                                  //     Text(
                                  //       "${record.checkInoutHistoryModel!.response!.userList![int].contactNo ?? ""}",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     SizedBox(
                                  //         width: mediaQuery.width * 0.3,
                                  //         child: Text(
                                  //           'Email',
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .labelSmall,
                                  //         )),
                                  //     Text(
                                  //       "${record.checkInoutHistoryModel!.response!.userList![int].email ?? ""}",
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyMedium,
                                  //     ),
                                  //   ],
                                  // ),

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
