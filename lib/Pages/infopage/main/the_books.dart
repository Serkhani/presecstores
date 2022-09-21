import 'package:presecstores/Utils/students.dart';
import 'package:flutter/material.dart';

class TheBooks extends StatefulWidget {
  final Book book;
  final int index;
  const TheBooks({Key? key, required this.book, required this.index}) : super(key: key);

  @override
  _TheBooksState createState() => _TheBooksState();
}

class _TheBooksState extends State<TheBooks> {
  Icon icon = const Icon(Icons.delete_outline_rounded, color: Colors.redAccent);
  Icon icon1 = const Icon(Icons.check, color: Colors.greenAccent);
  @override
  Widget build(BuildContext context) {
    return ListTile(      
      title: PhysicalModel(
        shadowColor: Colors.grey,
        color: Colors.white54,
        borderRadius: BorderRadius.circular(30.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              ReorderableDragStartListener(child: IconButton(onPressed: (){}, icon: const Icon(Icons.drag_handle)), index: widget.index),
              Text(
                widget.book.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text('${widget.book.number}')),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.book.submitted = !widget.book.submitted;
                    });
                  },
                  icon: widget.book.submitted ? icon1 : icon),
            ],
          ),
        ),
        elevation: 10.0,
        shape: BoxShape.rectangle,
      ),
      // trailing: IconButton(
      //     onPressed: () {},
      //     icon:
      //         const Icon(Icons.delete_outline_rounded, color: Colors.redAccent)),
    );
  }
}
