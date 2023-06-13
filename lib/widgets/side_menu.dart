import 'package:day_2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../model/menu.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(
      {super.key,
        this.menu,
        required this.press,
         this.riveOnInit,
        this.selectedMenu});

  final Menu ?menu;
  final VoidCallback press;
  final ValueChanged<Artboard> ?riveOnInit;
  final Menu ?selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.white24, height: 1),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration:  BoxDecoration(
                  color:Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  menu!.rive.src,
                  artboard: menu?.rive.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                menu!.title,
                style:  TextStyle(color: Yellow),
              ),
            ),
          ],
        ),
      ],
    );
  }
}