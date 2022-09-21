import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/Pages/infopage/thedrawer/createstud.dart';
import 'package:presecstores/Pages/infopage/thedrawer/searchtab.dart';
import 'package:presecstores/logic.dart';

class TheDrawer extends StatelessWidget {
  static final TheController processor = Get.put(TheController());

  const TheDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width * 0.25,
        height: Get.height,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: const TabBarView(
                  children: [SearchTab(), CreateStudentTab()]),
              bottomNavigationBar: TabBar(
                  labelColor: Colors.blue,
                  indicator: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  tabs: const [
                    Tab(text: "Search"),
                    Tab(text: "Add Student")
                  ]),
            )));
  }
}
