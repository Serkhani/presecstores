import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:presecstores/Pages/infopage/info_page.dart';
import 'package:presecstores/Utils/students.dart';
import 'package:presecstores/Utils/thestudents.dart';

class TheController extends GetxController {
  bool? value;
  Rx<Color> theColor = Colors.white.obs;
  RxString thePath = 'assets/images/cloud.png'.obs;

  FocusNode addFilterNode = FocusNode();
  FocusNode nameFocNode = FocusNode(onKeyEvent: (node, keyEvent) {
    if (keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      node.nextFocus();
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  });
  FocusNode usernameFocNode = FocusNode(onKeyEvent: (node, keyEvent) {
    if (keyEvent.logicalKey == LogicalKeyboardKey.enter) {
      node.nextFocus();
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  });
  FocusNode passWordNode = FocusNode();
  TextEditingController studentName = TextEditingController();
  TextEditingController addFilterCon = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController listViewController = ScrollController();
  ScrollController reOrderableListViewController = ScrollController();
  ScrollController suggestionListCon = ScrollController();
  TextEditingController txtCon = TextEditingController();
  TextEditingController txtEdCon = TextEditingController();
  TextEditingController numberCon = TextEditingController();
  List<String> items = ["1", "2", "3"];
  RxList<Book> addedBooks = <Book>[].obs;
  RxList<String> filters = <String>[].obs;
  bool isFound = false;

  List<String> classRooms = [
    "1 SCIENCE 2",
    "2 SCIENCE 3",
    "3 SCIENCE 4",
    "3 SCIENCE 15",
    "3 ARTS 2"
  ];

  List<String> subjects = [
    "CORE MATHS",
    "ENGLISH LANGUAGE",
    "INTEGRATED SCIENCE",
    "SOCIAL STUDIES",
    "PHYSICS",
    "CHEMISTRY",
    "BIOLOGY",
    "ELECTIVE MATHS"
  ];
  List<Student> newStudents = [];
  static Rx<Student> student = Student(
          allBooks: <Book>[].obs,
          classRoom: "-",
          image: "",
          name: "-",
          status: "-")
      .obs;
  
  void createStudent(String name, String classRoom) {
    if (name.split("").length > 1) {
      for (var eachStudent in students) {
        if (name.toLowerCase() == eachStudent.name.toLowerCase() &&
            classRoom.toLowerCase() == eachStudent.classRoom.toLowerCase()) {
          return Get.snackbar("Error: ", "Multiple students will be created",
              backgroundColor: Colors.red.withOpacity(0.3));
        }

        // Server business
      }
      Student newStudent = Student(
          name: name,
          classRoom: classRoom,
          image: thePath.value,
          allBooks: RxList<Book>(),
          status: "Day");
      newStudents.add(newStudent);
      student.value = newStudent;
      theValue.value = student.value.classRoom[0];
      Get.back();
      isFound = true;
      // only run on success
      Get.snackbar("Success", "Student created successfully",
          backgroundColor: Colors.green.withOpacity(0.3));
      thePath.value = 'assets/images/cloud.png';
      studentName.clear();
      txtEdCon.clear();
    } else {
      Get.snackbar("Error: ", "Full name required",
          backgroundColor: Colors.red.withOpacity(0.3));
    }
  }

  void forgetPassword() {}
  void signIn(String email, String password) {
    Get.to(const Data(),
        transition: Transition.rightToLeft,
        curve: Curves.bounceInOut,
        duration: const Duration(seconds: 2));
  }

  final RxString theValue = student.value.classRoom[0].obs;
  Iterable<String> optionsBuilder(
      TextEditingValue txtVal, List<String> location) {
    return location.where((item) {
      return item
          .toLowerCase()
          .trim()
          .contains(txtVal.text.toLowerCase().trim());
    }).map((item) {
      return item;
    });
  }

  void onChange(value) {
    theValue.value = value;
  }

  void reOrder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex = newIndex - 1;
    }
    final book = student.value.allBooks.removeAt(oldIndex);
    student.value.allBooks.insert(newIndex, book);
  }

  void plusAdd() {
    if (numberCon.value.text.isEmpty || txtEdCon.value.text.isEmpty) {
      Get.snackbar("Error", "Values needed",
          backgroundColor: Colors.red.withOpacity(0.3));
    } else {
      var book = Book(
          name: txtEdCon.value.text,
          number: int.parse(numberCon.value.text),
          year: theValue.value,
          submitted: false);
      bool status = bookCheck(book, addedBooks);
      if (status == false) {
        numberCon.clear();
        txtEdCon.clear();
      }
    }
  }

  bool bookCheck(Book book, RxList<Book> path) {
    for (var eachBook in path) {
      if (eachBook.equals(book)) {
        Get.snackbar(
            "Information: ", "This '${book.name}' book has already been added",
            backgroundColor: Colors.red.withOpacity(0.3));
        return true;
      }
    }
    path.insert(0, book);
    return false;
  }

  void ulAdd() {
    if (addedBooks.isEmpty) {
      Get.snackbar("Information: ", "No books available to add.",
          backgroundColor: Colors.red.withOpacity(0.3));
    } else {
      RxList theList = RxList(addedBooks);
      for (var eachBook in theList) {
        bool status = bookCheck(eachBook, student.value.allBooks);
        if (status == false) {
          addedBooks.remove(eachBook);
        }
      }
    }
    return;
  }

  RxList<Student> filteredStudents = RxList(students);
  void filter() {
    filteredStudents.value = students;
    for (var filter in filters) {
      var parsedInt = int.tryParse(filter);
      if (subjects.any((subject) => subject.contains(filter.toUpperCase()))) {
        filteredStudents.value =
            filterBook(filter.trim().toUpperCase(), filteredStudents);
      } else if (parsedInt != null) {
        filteredStudents.value = filterNum(filter.trim(), filteredStudents);
      } else if (int.tryParse(filter[0]) != null &&
          int.tryParse(filter[filter.length - 1]) != null &&
          parsedInt == null) {
        filteredStudents.value =
            filterClass(filter.trim().toLowerCase(), filteredStudents);
      } else {
        filteredStudents.value =
            filterStudent(filter.trim().toLowerCase(), filteredStudents);
      }
    }
  }

  List<Student> filterClass(
      String classRoom, RxList<Student> filteredStudents) {
    return filteredStudents.where((Student student) {
      return student.classRoom.toLowerCase().trim().contains(classRoom);
    }).map((Student student) {
      return student;
    }).toList();
  }

  List<Student> filterNum(String number, RxList<Student> filteredStudents) {
    return filteredStudents
        .where((Student student) {
          for (Book book in student.allBooks) {
            if (book.number.toString() == number ||
                items.contains(book.number.toString())) {
              return true;
            }
          }
          return false;
        })
        .map((Student student) => student)
        .toList();
  }

  List<Student> filterBook(String filter, RxList<Student> filteredStudents) {
    return filteredStudents
        .where((Student student) {
          for (Book book in student.allBooks) {
            if (book.name.toUpperCase().contains(filter)) {
              return true;
            }
          }
          return false;
        })
        .map((Student student) => student)
        .toList();
  }

  List<Student> filterStudent(String filter, RxList<Student> filteredStudents) {
    return filteredStudents.where((Student student) {
      return student.name.toLowerCase().trim().contains(filter);
    }).map((Student student) {
      return student;
    }).toList();
  }

  void addFilter(String word) {
    if (word.isNotEmpty) {
      filters.insert(0, word);
      addFilterCon.clear();
      addFilterNode.requestFocus();
      filter();
    }
  }

  void found(Student foundStudent) {
    student.value = foundStudent;
    theValue.value = student.value.classRoom[0];
    isFound = true;
    filters.clear();
    filter();
    Get.back();
  }

  void deleteFilter(String filterWord) {
    filters.remove(filterWord);
    filter();
  }

  bool onWillAccept(url) {
    if (url.last
        .toFilePath(windows: true)
        .toString()
        .split("/")
        .last
        .isImageFileName) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    usernameFocNode.dispose();
    passWordNode.dispose();
    nameFocNode.dispose();
    addFilterNode.dispose();
    numberCon.dispose();
    txtEdCon.dispose();
    txtCon.dispose();
    emailController.dispose();
    passwordController.dispose();
    listViewController.dispose();
    addFilterCon.dispose();
    reOrderableListViewController.dispose();
    studentName.dispose();
    suggestionListCon.dispose();
  }

// filters.
// FireBase Stuff
  // RxList<Student> filteredStudents = <Student>[].obs;
}
