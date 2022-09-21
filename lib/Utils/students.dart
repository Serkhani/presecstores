import 'package:get/get.dart';

class Student {
  final String name;
  final String classRoom;
  final String image;

  String status;
  RxList<Book> allBooks = RxList();
  Student(
      {required this.name,
      required this.classRoom,
      required this.image,
      required this.status,
      required this.allBooks});
  
  void addBook(Book book) {
    allBooks.insert(0, book);
  }

  void removeBook(Book book) {
    allBooks.remove(book);
  }

    bool equals(Student student) {
    if (name == student.name && classRoom == student.classRoom && image == student.image) {
      return true;
    } else {
      return false;
    }
  }


  // Book findBook(String text){
  //   List<Book> books = allBooks.where((book){
  //     return
  //   }).toList()
  // }

  int bookLength() {
    return allBooks.length;
  }
}

class Book {
  final String name;
  final String year;
  final int number;
  bool submitted;
  bool isNew;
  Book({required this.name,
      required this.year,
      required this.number,
      this.submitted = false,
      this.isNew = true});
  bool equals(Book book) {
    if (name == book.name && year == book.year && number == book.number && submitted == book.submitted && isNew == book.isNew) {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'year': year,
      };
}
