 import 'package:week8/db/db_functions.dart';
import 'package:week8/model/student_model.dart';

Future<List<ModelStudent>> getAllStudents() async {
    return controller.students;
  }