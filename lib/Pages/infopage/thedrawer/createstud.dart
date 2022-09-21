import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/Utils/thestudents.dart';
import 'package:presecstores/logic.dart';

// name, classroom, image, status
class CreateStudentTab extends StatelessWidget {
  static final TheController processor = Get.put(TheController());
  const CreateStudentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (processor.studentName.value.text.isNotEmpty &&
                      processor.txtEdCon.value.text.isNotEmpty) {
                    if (processor.thePath.value != 'assets/images/cloud.png') {
                      processor.createStudent(
                          processor.studentName.value.text.capitalize!.trim(),
                          processor.txtEdCon.value.text.toUpperCase().trim());
                    } else {
                      Get.snackbar("Error: ", "Image is requirred",
                          backgroundColor: Colors.red.withOpacity(0.3));
                    }
                  } else {
                    Get.snackbar("Error: ", "Invalid Input",
                        backgroundColor: Colors.red.withOpacity(0.3));
                  }
                  for (var student in processor.newStudents) {
                    if (students.any((theStudent) {
                      print("${student.name} vs ${theStudent.name}");
                      return theStudent.equals(student);
                    })) {
                      continue;
                    } else {
                      students.add(student);
                      processor.filter();
                      print("student added");
                    }
                  }
                  processor.newStudents.clear();
                  print("done");
                },
                child: const Text("Create Student")),
            // name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                focusNode: processor.nameFocNode,
                controller: processor.studentName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: "Name",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "Enter student's name...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Colors.lightBlue, width: 2.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == null) {
                    return "Input is requirred";
                  } else if (value.trim().split(" ").length < 2) {
                    return "Full name requirred";
                  }
                },
              ),
            ),
            // Classroom
            Autocomplete<String>(
              fieldViewBuilder: (context, txtEdCon, focNode, func) {
                // focNode.
                processor.txtEdCon = txtEdCon;
                return TextField(
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  controller: txtEdCon,
                  focusNode: focNode,
                  onEditingComplete: () {
                    func();
                    focNode.unfocus();
                  },
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      labelText: "Class",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.60)),
                      hintText: "eg: 3 SCIENCE 6",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )),
                );
              },
              optionsBuilder: (txtVal) {
                return processor.optionsBuilder(txtVal, processor.classRooms);
              },
            ),
            // image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                  child: SizedBox(
                width: 250.0,
                height: 200.0,
                child: DropTarget(
                  onDragDone: (url) {
                    if (processor.onWillAccept(url.urls)) {
                      processor.thePath.value =
                          url.urls.last.toFilePath(windows: true).toString();
                    } else {
                      Get.snackbar("Error", "Only image files are acceptable",
                          backgroundColor: Colors.red.withOpacity(0.31));
                    }
                  },
                  child: GestureDetector(
                    onTap: () async {
                      processor.thePath.value =
                          await FilePickerCross.importFromStorage(
                                  type: FileTypeCross.image)
                              .then((value) => value.path.toString())
                              .onError((error, stackTrace) {
                        Get.snackbar("Error: ", "Invalid input",
                            backgroundColor: Colors.red.withOpacity(0.31));
                        return 'assets/images/cloud.png';
                      });
                    },
                    child: Obx(() => Card(
                        elevation: 12.0,
                        shadowColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: processor.theColor.value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DottedBorder(
                              radius: const Radius.circular(30.0),
                              strokeCap: StrokeCap.square,
                              dashPattern: const [7],
                              strokeWidth: 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  processor.thePath.value ==
                                          'assets/images/cloud.png'
                                      ? Image.asset(processor.thePath.value,
                                          // fit: BoxFit.contain,
                                          width: 60.0,
                                          height: 70.0)
                                      : Container(
                                          child: Image.file(
                                            File(processor.thePath.value),
                                          ),
                                          width: 60.0,
                                          height: 60.0),
                                  const Text.rich(
                                    TextSpan(
                                        text: "Drag&Drop the image here ",
                                        style:
                                            TextStyle(fontSize: 17.0, shadows: [
                                          Shadow(
                                              color: Colors.black12,
                                              offset: Offset(-2, -1)),
                                        ]),
                                        children: [
                                          TextSpan(
                                              text: "\n\nor\n",
                                              style: TextStyle(
                                                fontSize: 10.0,
                                              )),
                                        ]),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    // textWidthBasis: TextWidthBasis.parent,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Browse",
                                    style: TextStyle(color: Colors.lightBlue),
                                  )
                                ],
                              )),
                        ))),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField theTextField(
      {required TextEditingController theController,
      required String labelText,
      required String hintText}) {
    return TextFormField(
      onEditingComplete: () {},
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.words,
      autofocus: true,
      style: const TextStyle(
          fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Name",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        hintText: "Enter student's name...",
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.lightBlue, width: 2.0),
        ),
      ),
      validator: (String? value) {
        if (value == null) {
          return "Input is requirred";
        } else if (value.trim().split(" ").length < 2) {
          return "full name requirred";
        }
      },
    );
  }
}
