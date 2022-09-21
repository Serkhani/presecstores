import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/Pages/infopage/main/first_card.dart';
import 'package:presecstores/Pages/infopage/main/second_card.dart';
import 'package:presecstores/Pages/infopage/thedrawer/thedrawer.dart';
import 'package:presecstores/logic.dart';

class Data extends StatelessWidget {
  static final TheController processor = Get.put(TheController());
  const Data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaInfo = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: const SizedBox(width: 300.0, child: TheDrawer()),
      body: Container(
        height: mediaInfo.height,
        width: mediaInfo.width,
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              gContainer(
                  width: mediaInfo.width * 0.25,
                  height: mediaInfo.height,
                  child: FirstCard(size: mediaInfo)),
              gContainer(
                  width: mediaInfo.width * 0.65,
                  height: mediaInfo.height,
                  child: SecondCard(size: mediaInfo))
            ],
          ),
        ),
      ),
    );
  }

  Widget gContainer(
      {required double width, required double height, required Widget child}) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey[350],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, offset: Offset(4, 4), spreadRadius: 0.5)
            ]),
        child: child);
  }
}
