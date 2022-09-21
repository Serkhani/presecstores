import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/Utils/thestudents.dart';
import 'package:presecstores/logic.dart';

class SearchTab extends StatelessWidget {
  static final TheController processor = Get.put(TheController());
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            focusNode: processor.addFilterNode,
            strutStyle: const StrutStyle(height: 0.1),
            buildCounter: (context,
                {required int currentLength,
                required bool isFocused,
                int? maxLength}) {
              return const Card();
            },
            onSubmitted: (value) {
              processor.addFilter(value);
            },
            controller: processor.addFilterCon,
            selectionHeightStyle: BoxHeightStyle.max,
            decoration: InputDecoration(
              labelText: "Search",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintText: "Type anything and press ENTER...",
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                    const BorderSide(color: Colors.lightBlue, width: 2.0),
              ),
            ),
            style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          PhysicalModel(
            color: Colors.blueGrey.withOpacity(0.45),
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filters: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Obx(() => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: ListView(shrinkWrap: true, children: [
                          Wrap(
                            runSpacing: 2.0,
                            spacing: 2.0,
                            children: processor.filters
                                .map((filterWord) => InputChip(
                                    backgroundColor: Colors.white30,
                                    onDeleted: () {
                                      processor.deleteFilter(filterWord);
                                    },
                                    deleteIconColor: Colors.lightBlue,
                                    deleteIcon:
                                        const Icon(Icons.clear, size: 10.0),
                                    labelPadding: const EdgeInsets.all(1.0),
                                    deleteButtonTooltipMessage:
                                        "Remove filter?",
                                    label: Text(filterWord,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))))
                                .toList(),
                          ),
                        ]),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: processor.filteredStudents.length,
                controller: processor.suggestionListCon,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onSecondaryLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(
                                      color: Colors.lightBlue,
                                      style: BorderStyle.solid,
                                      width: 2.0)),
                              content: const Text(
                                "Remove student?",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      students.removeAt(index);
                                      processor.filter();
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.red,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 20.0),
                                    ))
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(processor.filteredStudents[index].name),
                      trailing:
                          Text(processor.filteredStudents[index].classRoom[0]),
                      onTap: () {
                        processor.found(processor.filteredStudents[index]);
                      },
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
