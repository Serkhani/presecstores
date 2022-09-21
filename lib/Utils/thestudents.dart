import 'dart:math';

import 'package:get/get.dart';
import 'package:presecstores/Utils/students.dart';

List<Student> students = [
      makeStudent(
        name: "Jude Boachie",
        classRoom: 5,
        bookNum: 8,
        program: "BIOLOGY",
        year: "3",
      ),
      makeStudent(
        name: "Brian Wealth",
        classRoom: 18,
        bookNum: 7,
        program: "ELECTIVE IT",
        year: "3",
      ),
      makeStudent(
        name: "D_hall",
        classRoom: 22,
        bookNum: 5,
        program: "FOOD AND NUTRITION",
        year: "3",
      ),
      makeStudent(
        name: "Joseph",
        classRoom: 12,
        bookNum: 6,
        program: "BIOLOGY",
        year: "3",
      ),
      makeStudent(
        name: "Paul Adansi",
        classRoom: 12,
        bookNum: 7,
        program: "GEOGRAPHY",
        year: "3",
      ),
      makeStudent(
        name: "Prince Asiedu",
        classRoom: 21,
        bookNum: 8,
        program: "ELECTIVE IT",
        year: "2",
      ),
      makeStudent(
        name: "Richard Nii",
        classRoom: 15,
        bookNum: 7,
        program: "ELECTIVE IT",
        year: "1",
      ),
      makeStudent(
        name: "Paul Asamoah",
        classRoom: 18,
        bookNum: 3,
        program: "ELECTIVE IT",
        year: "2",
      ),
      makeStudent(
        name: "Robo",
        classRoom: 10,
        bookNum: 5,
        program: "ELECTIVE IT",
        year: "1",
      ),
      makeStudent(
        name: "Theophiles Ferguson",
        classRoom: 3,
        bookNum: 8,
        program: "GEOGRAPHY",
        year: "3",
      )
    ];

    Student makeStudent(
    {required String name,
    required int classRoom,
    required String program,
    required String year,
    required int bookNum}) {
  List<String> subjects = [
    "ENGLISH LANGUAGE",
    "SOCIAL STUDIES",
    "INTEGRATED SCIENCE",
    "CORE MATHEMATICS",
    "ELECTIVE MATHS",
    "PHYSICS",
    "CHEMISTRY",
  ];
  var freqNum = Random();
  RxList<Book> books = <Book>[].obs;
  for (var i in subjects.getRange(0, bookNum - 1)) {
    books.add(Book(
        name: i, year: year, number: freqNum.nextInt(607), submitted: false));
  }
  books.add(Book(
      name: program,
      year: year,
      number: freqNum.nextInt(233),
      submitted: false));
  return Student(
      name: name,
      image: 'assets/images/$name.jpg',
      classRoom: '$year SCIENCE $classRoom',
      status: "Day",
      allBooks: books);
}