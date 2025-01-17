import 'package:feranta_franchise/screen/location_permission/location_permissin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screen/attendance/attendance_screen.dart';
import 'screen/auth/login_screen/login_screenn.dart';
import 'screen/auth/login_screen/otp_field.dart';
import 'screen/bootom_navigation.dart/botom_navigation.dart';
import 'screen/home/home_screen.dart';
import 'screen/home/resister_form/customer/customer_resister_screen.dart';
import 'screen/home/resister_form/owner/owner_resister_screen.dart';
import 'screen/home/resister_form/driver/signup_screen.dart';
import 'screen/home/resister_form/vechicle/image_entry_screen.dart';
import 'screen/home/resister_form/vechicle/vechicle_register_screen.dart';
import 'screen/past_record/past_record-screen.dart';
import 'screen/profile/edit_profile.dart';
import 'screen/profile/profile.dart';
import 'screen/show_Webdata/show_web.dart';
import 'screen/splash/splash_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoute {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    errorBuilder: (context, state) => LognScreen(),
    routes: [
      GoRoute(
        path: '/',
        name: "Splash Screen",
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/web',
        name: "web",
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          Map<String, dynamic>? parameter =
              state.extra as Map<String, dynamic>?;

          return ShowWeb(urll: parameter!['url']);
        },
      ),
      GoRoute(
        path: '/login',
        name: "Login",
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          return LognScreen();
        },
      ),
      GoRoute(
        path: '/permission',
        name: "Permission",
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PermissionPhone(),
      ),
      GoRoute(
          path: '/imageupload',
          name: "imageupload",
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            Map<String, dynamic>? parameter =
                state.extra as Map<String, dynamic>?;
            return ImageEntryPdf(
              fileName: parameter!['file'],
            );
          }),
      //it need for shellroute of nested route
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          Map<String, dynamic>? parameter =
              state.extra as Map<String, dynamic>?;
          // print(parameter!['id']);
          // int index = 0;
          return BottomNav(
            child: child,
            // index: 0,
            index: int.parse(parameter!['id'] ??
                "0"), //parameter!['id'] ??  comment for implement
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: "Home",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomeScreen(),
            routes: [
              //         //LiftRequestSuccessScreen
              GoRoute(
                path: 'resister_driver',
                name: "resister_driver",
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) {
                  Map<String, dynamic>? parameter =
                      state.extra as Map<String, dynamic>?;
                  return SignUpDriverPage(
                    driverDetails: parameter!['driver'] ?? null,
                  );
                },
              ),
              GoRoute(
                path: 'customerResister',
                name: "customerResister",
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) {
                  Map<String, dynamic>? parameter =
                      state.extra as Map<String, dynamic>?;
                  return CustomerResister(
                    customerDetails: parameter!['customer'] ?? null,
                  );
                },
              ),
              GoRoute(
                path: 'ownerResister',
                name: "ownerResister",
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) {
                  Map<String, dynamic>? parameter =
                      state.extra as Map<String, dynamic>?;
                  return OwnerResisterPage(
                    ownerDetails: parameter!['owner'] ?? null,
                  );
                },
              ), //AttendanceScreen
              //

              // GoRoute(
              //     path: 'getowner',
              //     name: "getowner",
              //     parentNavigatorKey: _shellNavigatorKey,
              //     builder: (context, state) => GetownerAll(),
              //     routes: [

              //     ]),
              GoRoute(
                path: 'addVehicle', //home/addVehicle
                name: "addVehicle",
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) {
                  Map<String, dynamic>? parameter =
                      state.extra as Map<String, dynamic>?;
                  return AddVechicle(
                    vehicleDetails: parameter!['vehicle'],
                  );
                },
              ),
              // GoRoute(
              //   path: 'pickup',
              //   name: "Pickup",
              //   parentNavigatorKey: _shellNavigatorKey,
              //   builder: (context, state) => const PickUpLocation(),
              // ),
              // GoRoute(
              //   path: 'dest',
              //   name: "Destination",
              //   parentNavigatorKey: _shellNavigatorKey,
              //   builder: (context, state) => const DestinationLocation(),
              // ),
              // GoRoute(
              //   path: 'bookingsr1',
              //   name: "BookingScreen1",
              //   parentNavigatorKey: _shellNavigatorKey,
              //   builder: (context, state) => const BookingScreenfirst(),
              // ), //DriverFindScreen() ConfrmRideBooking
              // //  GoRoute(
              // //   path: 'searchDriver',
              // //   name: "searchDriver",
              // //   parentNavigatorKey: _shellNavigatorKey,
              // //   builder: (context, state) => const searchDriver(),
              // // ),

              // GoRoute(
              //     path: 'driverfindscr',
              //     name: "driverfindScr",
              //     parentNavigatorKey: _shellNavigatorKey,
              //     builder: (context, state) =>
              //         const DriverFindScreen()), //DriverFindScreen() ConfrmRideBooking
              // GoRoute(
              //   path: 'conformBooking',
              //   name: "conformBooking",
              //   parentNavigatorKey: _shellNavigatorKey,
              //   builder: (context, state) => const ConfrmRideBooking(),
              // ), //
            ],
          ),

          GoRoute(
            path: '/pastRecord',
            name: "pastRecord",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const PastRecordScreen(),
            // routes: [
            //   GoRoute(
            //     path: 'fullDtlsTrip',
            //     name: "FullDtlsTrip",
            //     parentNavigatorKey: _shellNavigatorKey,
            //     builder: (context, state) => const FullDetaisTrip(),
            //   ),
            // ]
          ),
          GoRoute(
            path: '/attendance',
            name: "attendance",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => AttendanceScreen(),
          ),
          //     //FullDetaisTrip()
          GoRoute(
              path: '/profie',
              name: "profie",
              // parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const ProfileScren(),
              routes: [
                GoRoute(
                  path: 'editProfile',
                  name: "editProfile",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) => const EditProfiletls(),
                ),
              ]),
          //     GoRoute(
          //       path: '/more',
          //       name: "More",
          //       // parentNavigatorKey: _shellNavigatorKey,
          //       builder: (context, state) => const NotificationScreen(),
          //     ),
        ],
      )
    ],
  );
}
