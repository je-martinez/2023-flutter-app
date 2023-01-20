import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../providers/inherited_data_provider.dart';

class BottomBar extends StatefulWidget {
  final Widget child;
  final int currentPage;
  final TabController tabController;
  final List<Color> colors;
  final Color unselectedColor;
  final Color barColor;
  final double end;
  final double start;
  const BottomBar(
      {required this.child,
      required this.currentPage,
      required this.tabController,
      required this.colors,
      required this.unselectedColor,
      required this.barColor,
      required this.end,
      required this.start,
      Key? key})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  ScrollController scrollBottomBarController = ScrollController();
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isScrollingDown = false;
  bool isOnTop = true;

  @override
  void initState() {
    myScroll();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation =
        Tween<Offset>(begin: Offset(0, widget.end), end: Offset.zero)
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
    _controller.forward();
  }

  void showBottomBar() {
    if (mounted) {
      setState(() {
        _controller.forward();
      });
    }
  }

  void hideBottomBar() {
    if (mounted) {
      setState(() {
        _controller.reverse();
      });
    }
  }

  Future<void> myScroll() async {
    scrollBottomBarController.addListener(() {
      if (scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          isOnTop = false;
          hideBottomBar();
        }
      }
      if (scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          isOnTop = true;
          showBottomBar();
        }
      }
    });
  }

  void onPressArrowUp() {
    scrollBottomBarController
        .animateTo(
      scrollBottomBarController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    )
        .then((value) {
      if (mounted) {
        setState(() {
          isOnTop = true;
          isScrollingDown = false;
        });
      }
      showBottomBar();
    });
  }

  @override
  void dispose() {
    scrollBottomBarController.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        InheritedDataProvider(
          scrollController: scrollBottomBarController,
          child: widget.child,
        ),
        _ButtonToGoUp(
          start: widget.start,
          isOnTop: isOnTop,
          barColor: widget.barColor,
          onPressArrowUp: onPressArrowUp,
          unselectedColor: widget.unselectedColor,
        ),
        Positioned(
          bottom: widget.start,
          child: SlideTransition(
            position: _offsetAnimation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Material(
                    color: widget.barColor,
                    child: _FloatingBottomTabs(
                        colors: widget.colors,
                        tabController: widget.tabController,
                        currentPage: widget.currentPage,
                        unselectedColor: widget.unselectedColor),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class _ButtonToGoUp extends StatelessWidget {
  final double start;
  final bool isOnTop;
  final Color barColor;
  final Function onPressArrowUp;
  final Color unselectedColor;
  const _ButtonToGoUp(
      {required this.start,
      required this.isOnTop,
      required this.barColor,
      required this.onPressArrowUp,
      required this.unselectedColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: start,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeIn,
        width: isOnTop == true ? 0 : 40,
        height: isOnTop == true ? 0 : 40,
        decoration: BoxDecoration(
          color: barColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    onPressArrowUp();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_up_sharp,
                    color: unselectedColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingBottomTabs extends StatelessWidget {
  final List<Color> colors;
  final TabController tabController;
  final int currentPage;
  final Color unselectedColor;
  const _FloatingBottomTabs(
      {required this.colors,
      required this.tabController,
      required this.currentPage,
      required this.unselectedColor,
      Key? key})
      : super(key: key);

  Color getCurrentColor() {
    bool exist = colors.asMap().containsKey(currentPage);
    return exist ? colors[currentPage] : unselectedColor;
  }

  Color getSelectedOrUnselectedColor(int itemIndex) {
    return itemIndex == currentPage ? getCurrentColor() : unselectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      controller: tabController,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: getCurrentColor(), width: 4),
          insets: const EdgeInsets.fromLTRB(16, 0, 16, 8)),
      tabs: [
        SizedBox(
          height: 55,
          width: 40,
          child: Center(
              child: Icon(
            Icons.home,
            color: getSelectedOrUnselectedColor(0),
          )),
        ),
        SizedBox(
          height: 55,
          width: 40,
          child: Center(
              child: Icon(
            Icons.search,
            color: getSelectedOrUnselectedColor(1),
          )),
        ),
        SizedBox(
          height: 55,
          width: 40,
          child: Center(
              child: Icon(
            Icons.add,
            color: getSelectedOrUnselectedColor(2),
          )),
        ),
        SizedBox(
          height: 55,
          width: 40,
          child: Center(
              child: Icon(
            Icons.favorite,
            color: getSelectedOrUnselectedColor(3),
          )),
        ),
        SizedBox(
          height: 55,
          width: 40,
          child: Center(
              child: Icon(
            Icons.settings,
            color: getSelectedOrUnselectedColor(4),
          )),
        ),
      ],
    );
  }
}
