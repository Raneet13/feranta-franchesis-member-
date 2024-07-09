import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:feranta_franchise/view_model/auth/login-viewmodel.dart';
import 'package:feranta_franchise/view_model/map_viewmodel/mao_view_modedl_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../static/color.dart';
import '../back_to_close/systum_back_close_app.dart';

class BottomNav extends StatefulWidget {
  Widget child;
  int index;
  BottomNav({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;
  List<Widget> nav = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Paste Rrecord"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    // _selectedIndex = widget.Index;
    // widget.index != null
    //     ? setState(() {
    //         _selectedIndex = widget.index!;
    //       })
    //     : _selectedIndex = 0;

    BackButtonInterceptor.add(backTocloseApp().myInterceptor);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<LoginViewmodel>(context, listen: false).checkCheckinOutTrue();
      // await Provider.of<MapViewModelProvider>(context, listen: false)
      //     .locationPermissionRequest();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BackButtonInterceptor.remove(backTocloseApp().myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Are you sure to want back");
        // Get.to(() => const BottomNavBar());
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: widget.index,
          selectedItemColor: Colo.black,
          selectedIconTheme: IconThemeData(color: Colo.black),
          unselectedIconTheme: IconThemeData(color: Colo.black),
          selectedLabelStyle: TextStyle(
            color: Colo.black,
          ),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          unselectedItemColor: Colo.blackShade45,
          onTap: (index) {
            // setState(() {
            switch (index) {
              case 0:

                // Provider.of<MapLoadViewmodel>(context, listen: false)
                //     .removeMarkerndpathWithDestPath();
                context.go('/home', extra: {'id': "0"});
                break;
              case 1:
                // Provider.of<MapLoadViewmodel>(context, listen: false)
                //     .removeMarkerndpathWithDestPath();
                context.go('/pastRecord', extra: {'id': "1"});
                break;

              case 2:
                // Provider.of<MapLoadViewmodel>(context, listen: false)
                //     .removeMarkerndpathWithDestPath();
                context.go('/attendance', extra: {'id': "2"});
                break;
              case 3:
                // Provider.of<MapLoadViewmodel>(context, listen: false)
                //     .removeMarkerndpathWithDestPath();
                context.push('/profie', extra: {'id': "3"});
                break;

              default:
                // Provider.of<MapLoadViewmodel>(context, listen: false)
                //     .removeMarkerndpathWithDestPath();
                context.go('/home', extra: {'id': "0"});
                break;
            }

            setState(() {
              _selectedIndex = index;
            });

            //   _selectedIndex = index;
            //   // pageController.jumpToPage(index);
            // });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                weight: 5.0,
              ),
              label: 'Home',
              activeIcon: Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colo.primaryColor),
                child: Icon(
                  Icons.home,
                  size: 20.0, // Use size to control the icon size
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'Past Record',
              activeIcon: Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colo.primaryColor),
                child: Icon(
                  Icons.description,
                  size: 20.0, // Use size to control the icon size
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'attendance',
              activeIcon: Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colo.primaryColor),
                child: Icon(
                  Icons.person,
                  size: 20.0, // Use size to control the icon size
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              activeIcon: Container(
                width: 40,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colo.primaryColor),
                child: Icon(
                  Icons.account_circle,
                  size: 20.0, // Use size to control the icon size
                ),
              ),
            ),
          ],
        ),
        //  body: nav[_selectedIndex]);
        // body: SafeArea(
        //   child:  widget.,//IndexedStack(index: _selectedIndex, children: nav),
        //),
        body: widget.child,
      ),
    );
  }
}
