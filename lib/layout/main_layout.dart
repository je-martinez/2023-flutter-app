import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_2023/screens/feed_screen.dart';
import 'package:flutter_app_2023/screens/likes_screen.dart';
import 'package:flutter_app_2023/screens/search_screen.dart';
import 'package:flutter_app_2023/screens/settings_screen.dart';

import '../screens/create_post_screen.dart';
import '../widgets/bottom_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout>
    with SingleTickerProviderStateMixin {
  late int currentScreen;
  late TabController tabController;
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink
  ];

  @override
  void initState() {
    currentScreen = 0;
    tabController = TabController(length: 5, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentScreen && mounted) {
          changeScreen(value);
        }
      },
    );
    super.initState();
  }

  void changeScreen(int newPage) {
    setState(() {
      currentScreen = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BottomBar(
          currentScreen: currentScreen,
          tabController: tabController,
          colors: colors,
          unselectedColor: Colors.white,
          barColor: Colors.black,
          start: 10,
          end: 2,
          child: TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: const <Widget>[
              FeedScreen(),
              SearchScreen(),
              CreatePostScreen(),
              LikesScreen(),
              SettingsScreen()
            ],
          ),
        ),
      ),
    );
  }
}
