import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/logic.dart';

class FirstCard extends StatelessWidget {
  static final TheController processor = Get.put(TheController());
  final size;
  const FirstCard({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white70,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      shape: BoxShape.rectangle,
      elevation: 20.0,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView(
                controller: processor.listViewController,
                children: [
                  CircleAvatar(
                    child: processor.isFound
                    ? Text(
                        "${TheController.student.value.name[0]}${TheController.student.value.name.split(" ")[1][0]}")
                    : const Text(
                      "Not Available"
                    ),
                    foregroundImage: processor.isFound
                        ? FileImage(File(TheController.student.value.image))
                        : null,
                    //NetworkImage(processor.student.image),
                    radius: 80.0,
                  ),
                  SizedBox(height: size.height * 0.07),
                  info(
                      category: "NAME", data: TheController.student.value.name),
                  SizedBox(height: size.height * 0.03),
                  info(
                      category: "CLASS",
                      data: TheController.student.value.classRoom)
                ],
              ),
            )),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.blueGrey,
                    elevation: 20.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                onPressed: () {},
                icon: const Icon(Icons.check),
                label: const Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.0,
                    // fontWeight: FontWeight.bold
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget info({required String category, required String data}) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: '$category:' "\n",
              style: const TextStyle(fontSize: 12.0, shadows: [
                Shadow(color: Colors.black12, offset: Offset(-2, -1)),
              ])),
          TextSpan(
              text: data,
              style: const TextStyle(
                fontSize: 23.0,
              )),
        ]),
        overflow: TextOverflow.clip,
        textAlign: TextAlign.left,
        // textWidthBasis: TextWidthBasis.parent,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
