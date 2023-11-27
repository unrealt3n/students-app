import 'package:get/get.dart';
import 'package:week8/model/student_model.dart';

class StudentsController extends GetxController {
  List<ModelStudent> students = [];
  String searchString = '';

  addNewStudent(ModelStudent newStudent) {
    print('controller : student addeed');
    students.add(newStudent);
    update();
  }

  getAllStudents(List<ModelStudent> studentsVal) {
    print('controller : getting all the students');
    students.clear();
    students.addAll(studentsVal);
    update();
  }

  updateSearchString(String val) {
    searchString = val;
    update();
  }
}
