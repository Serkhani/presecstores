import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/Pages/infopage/dialogbox/the_dialog_box.dart';
import 'package:presecstores/Pages/infopage/main/the_books.dart';
import 'package:presecstores/logic.dart';

class SecondCard extends StatelessWidget {
  final Size size;
  static TheController processor = TheController();
  const SecondCard({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white70,
      // color: Colors.lightBlue,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      shape: BoxShape.rectangle,
      elevation: 20.0,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: size.width * 0.2,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (TheController.student.value.name != "-") {
                              Get.dialog(const DialogBox());
                            } else {
                              Scaffold.of(context).openEndDrawer();
                              Get.snackbar("Error: ", "Select a student",
                                  backgroundColor: Colors.red.withOpacity(0.3));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)))),
                          icon: const FittedBox(child: Icon(Icons.add)),
                          label: const FittedBox(child: Text("Add Book"))),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() => ReorderableListView.builder(
                  // key: ValueKey(widget.student.allBooks[index].number),
                  scrollController: processor.reOrderableListViewController,
                  proxyDecorator: (child, index, animation) {
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 10.0,
                        shadowColor: Colors.lightBlueAccent,
                        color: Colors.transparent,
                        child: child);
                  },
                  // proxyDecorator: null,
                  buildDefaultDragHandles: false,
                  onReorder: (oldIndex, newIndex) {
                    processor.reOrder(oldIndex, newIndex);
                  },
                  shrinkWrap: true,
                  // reverse: true,
                  itemCount: TheController.student.value.bookLength(),
                  itemBuilder: (context, index) {
                    var book = TheController.student.value.allBooks[index];
                    return Draggable(
                        // feedbackOffset: Offset.zero,

                        feedback: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            elevation: 10.0,
                            shadowColor: Colors.lightBlueAccent,
                            color: Colors.transparent,
                            child: ListTile(
                              title: Text(book.name),
                            )),

                        // feedback: Container(
                        //   margin: const EdgeInsets.all(10.0),
                        //   // shadowColor: Colors.blueGrey,
                        //   child: Text(
                        //     book.name,
                        //     style: TextStyle(
                        //         fontSize: 20.0,
                        //         color: Colors.black.withOpacity(0.75),
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white.withOpacity(0.64),
                        //       gradient: const LinearGradient(colors: [
                        //         Colors.white,
                        //         Colors.white10,
                        //         Colors.white12,
                        //         Colors.white24,
                        //         Colors.white30,
                        //         Colors.white38,
                        //         Colors.white54,
                        //         Colors.white60,
                        //         Colors.white70,
                        //       ]),
                        //       borderRadius: BorderRadius.circular(30.0),
                        //       border: Border.all(
                        //           color: Colors.lightBlue, width: 3.0),
                        //       boxShadow: [
                        //         const BoxShadow(
                        //           color: Colors.white,
                        //           spreadRadius: 2.0,
                        //           blurRadius: 4.0,
                        //         ),
                        //         BoxShadow(
                        //             color: Colors.blueGrey,
                        //             blurRadius: 4.0,
                        //             spreadRadius: 2.0,
                        //             offset: Offset.fromDirection(0.7855))
                        //       ]),
                        // ),
                        // key: ValueKey(TheController.student.allBooks[index].number),
                        key: ValueKey(index),
                        child: TheBooks(book: book, index: index));
                  })),
            )
          ],
        ),
      ),
    );
  }
}
