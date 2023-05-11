import 'package:designcode/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';

import '../components/home_screen_navbar.dart';
import '../components/lists/exlore_course_list.dart';
import '../components/lists/recent_course_list.dart';
import '../constants.dart';
import 'continue_watching_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // TickerProviderStateMixin keeps track of animation that is currently happing
  // Also keep track of duration that is currently shown
  late Animation<Offset> sidebarAnimation;
  late Animation<double> fadeAnimation;
  late AnimationController sidebarAnimationController;

  var sidebarHidden = true;

  @override
  // when Widget it initialized this function is called
  void initState() {
    super.initState();
    sidebarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    sidebarAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    // tween defines stating and ending point
    // also defines timeline and curves
  }

  @override
  void dispose() {
    super.dispose();
    sidebarAnimationController.dispose();
  }
  // this will depose animation off once animation is done

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //scaffold is layout
      body: Container(
        color: kBackgroundColor,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
              // this will auto adjust the view on smaller devices
                child: Column(
                  children: [
                    HomeScreenNavBar(triggerAnimation: () {
                      setState(() {
                        sidebarHidden = !sidebarHidden;
                      });
                      sidebarAnimationController.forward();
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //start only fills available area stretch fills entire area
                        children: [
                          Text(
                            "Recents",
                            style: kLargeTitleStyle,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "23 courses, more coming",
                            style: kSubtitleStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const RecentCourseList(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 25.0,
                        bottom: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Explore",
                            style: kTitle1Style,
                          ),
                        ],
                      ),
                    ),
                    ExploreCourseList(),
                  ],
                ),
              ),
            ),
            ContinueWatchingScreen(),
            IgnorePointer(
              ignoring: sidebarHidden,
              // so once ignoring is true it will ignore gestures
              // if false it will not ignore gestures
              child: Stack(
                children: [
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: GestureDetector(
                      child: Container(
                        color: const Color.fromRGBO(36, 38, 41, .4),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      onTap: () {
                        setState(() {
                          sidebarHidden = !sidebarHidden;
                        });
                        sidebarAnimationController.reverse();
                      },
                    ),
                  ),
                  SlideTransition(
                    position: sidebarAnimation,
                    child: SafeArea(
                      child: SidebarScreen(),
                      bottom: false,
                      // this will make safeArea ignore bottom
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
