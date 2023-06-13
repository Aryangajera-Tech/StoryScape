import 'package:day_2/Auth/login.dart';
import 'package:day_2/Auth/sign_in.dart';
import 'package:day_2/Auth/sign_up.dart';
import 'package:day_2/utils/utils.dart';
import 'package:flutter/material.dart';

const double borderRadius = 25.0;

class tab extends StatefulWidget {
  @override
  _tabState createState() => _tabState();
}

class _tabState extends State<tab> with SingleTickerProviderStateMixin {

  late PageController _pageController;
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Yellow,
        body: Column(
          children: <Widget>[
            _menuBar(context),
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (int i) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    activePageIndex = i;
                  });
                },
                children: <Widget>[
                  ConstrainedBox(
                    constraints:BoxConstraints.expand(),
                    child: sign_in(),
                  ),
                  ConstrainedBox(
                    constraints:BoxConstraints.expand(),
                    child: sign_up(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _menuBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: Brown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: _onPlaceBidButtonPress,
                child: Container(
                  alignment: Alignment.center,
                  decoration: (activePageIndex == 0) ?  BoxDecoration(
                    color: Green,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  ) : null,
                  child: Text(
                    "Sign in",
                    style: (activePageIndex == 0) ? TextStyle(color: Yellow,fontWeight: FontWeight.bold) : TextStyle(color: Yellow,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                onTap: _onBuyNowButtonPress,
                child: Container(
                  alignment: Alignment.center,
                  decoration: (activePageIndex == 1) ?  BoxDecoration(
                    color: Green,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  ) : null,
                  child: Text(
                    "Sign up",
                    style: (activePageIndex == 1) ? TextStyle(color: Yellow, fontWeight: FontWeight.bold) : TextStyle(color:Yellow, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

}