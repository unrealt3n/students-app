import 'package:flutter/widgets.dart';
import 'package:week8/model/student_model.dart';

class StudentsProvider extends ChangeNotifier {
  List<ModelStudent> students = [];
  String searchString = '';

  addNewStudent(ModelStudent student) {
    students.add(student);
    notifyListeners();
  }

  updateSearchString(String val) {
    searchString = val;
    notifyListeners();
  }

  getAllStudents(List<ModelStudent> studentsVal) {
    students.clear();
    students.addAll(studentsVal);
    notifyListeners();
  }
}
