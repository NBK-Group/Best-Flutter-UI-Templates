import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/traning/training_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_bottom_navbar/ss_bottom_navbar.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fintness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  SSBottomBarState _state;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    _state = SSBottomBarState();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _state,
      builder: (context, child) {
        return Container(
          color: FitnessAppTheme.background,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Stack(
                    children: <Widget>[
                      tabBody,
                      bottomBar(),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  var items = [
    SSBottomNavItem(text: 'Home', iconData: Icons.home),
    SSBottomNavItem(text: 'Store', iconData: Icons.store),
    SSBottomNavItem(text: 'Add', iconData: Icons.add, isIconOnly: true),
    SSBottomNavItem(text: 'Explore', iconData: Icons.explore),
    SSBottomNavItem(text: 'Profile', iconData: Icons.person),
  ];

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        SSBottomNav(
          state: _state,
          items: items,
          color: Colors.black,
          selectedColor: Colors.white,
          unselectedColor: Colors.black,
          // onTabSelected: (index) {
          //   if (index == 0 || index == 2) {
          //     animationController.reverse().then<dynamic>((data) {
          //       if (!mounted) {
          //         return;
          //       }
          //       setState(() {
          //         tabBody = MyDiaryScreen(animationController: animationController);
          //       });
          //     });
          //   } else if (index == 1 || index == 3) {
          //     animationController.reverse().then<dynamic>((data) {
          //       if (!mounted) {
          //         return;
          //       }
          //       setState(() {
          //         tabBody = TrainingScreen(animationController: animationController);
          //       });
          //     });
          //   }
          // }
        ),
      ],
    );
  }
}
