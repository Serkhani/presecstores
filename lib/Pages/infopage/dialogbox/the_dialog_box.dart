import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presecstores/Pages/infopage/dialogbox/thedropdown.dart';
import 'package:get/get.dart';
import 'package:presecstores/logic.dart';

class DialogBox extends StatelessWidget {
  static final TheController processor = Get.put(TheController());
  const DialogBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 300.0,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(
                  width: 3.0,
                  color: Colors.lightBlue,
                  style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const CircleAvatar(
                    radius: 30.0,
                    child: Text('Must be a gif', overflow: TextOverflow.clip)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            processor.numberCon.clear();
                            processor.txtEdCon.clear(); // txtEdCon.
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text("Clear")),
                      TextButton.icon(
                          onPressed: () {
                            processor.plusAdd();
                          },
                          icon: const Icon(Icons.add_circle_outline_sharp),
                          label: const Text("Add")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 300.0,
                  child: Autocomplete<String>(
                    fieldViewBuilder: (context, txtEdCon, focNode, func) {
                      processor.txtEdCon = txtEdCon;
                      return TextField(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        controller: txtEdCon,
                        focusNode: focNode,
                        onEditingComplete: func,
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            labelText: "Subject",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.60)),
                            hintText: "eg: ENGLISH LANGUAGE",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      );
                    },
                    optionsBuilder: (txtVal) {
                      return processor.optionsBuilder(
                          txtVal, processor.subjects);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 55.0,
                        width: 100.0,
                        child: TextField(
                          buildCounter: (context,
                              {required int currentLength,
                              required bool isFocused,
                              int? maxLength}) {
                            return const Card();
                          },
                          controller: processor.numberCon,
                          selectionHeightStyle: BoxHeightStyle.max,
                          scrollPadding: const EdgeInsets.all(10.0),
                          decoration: InputDecoration(
                            labelText: "Number",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: "eg:1234",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Colors.lightBlue, width: 2.0),
                                gapPadding: 2.0),
                          ),
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70.0, right: 20.0),
                      child: SizedBox(
                          height: 20.0,
                          // child: RadioListTile(
                          //     value: processor.theValue.value,
                          //     groupValue: processor.items,
                          //     onChanged: (value) {
                          //       processor.onChange(value);
                          //     })
                              child: Obx(
                            () => theMenuItems(
                                width: MediaQuery.of(context).size.width * 0.005,
                                items: processor.items,
                                theCallback: (String value) {
                                  processor.onChange(value);
                                },
                                valueChoose: processor.theValue.value),
                          )
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: PhysicalModel(
                    color: Colors.grey.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 12.0,
                    child: SingleChildScrollView(
                      child: Obx(() => Wrap(
                            runSpacing: 1.0,
                            spacing: 1.0,
                            children: processor.addedBooks.map((book) {
                              return InputChip(
                                label: Text(
                                  book.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.lightBlue.withOpacity(0.8),
                                deleteButtonTooltipMessage: "Remove book?",
                                deleteIcon: const Icon(Icons.delete),
                                deleteIconColor: Colors.red.withOpacity(0.90),
                                elevation: 10.0,
                                labelPadding: const EdgeInsets.all(1.0),
                                onDeleted: () {
                                  processor.addedBooks.remove(book);
                                },
                                selectedColor: Colors.lightGreenAccent,
                                showCheckmark: false,
                                // tooltip: addedBooks[index].,
                                selectedShadowColor: Colors.blueGrey,
                              );
                            }).toList(),
                          )),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            processor.ulAdd();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 10.0,
                              // onPrimary: Colors.lightBlue,
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: const Text("Add",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                      TextButton.icon(
                          onPressed: () {
                            processor.numberCon.clear();
                            Navigator.of(context).pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10.0,
                            primary: Colors.red,
                            shadowColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          label: const Text("Cancel",
                              style: TextStyle(
                                color: Colors.white,
                              )))
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
