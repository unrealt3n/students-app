import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/providers/students.dart';

Future<List<ModelStudent>> getAllStudents(BuildContext context) async {
    return context.read<StudentsProvider>().students;
  }