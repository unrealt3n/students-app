import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/controller/home_page.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/pages/home/home_page.dart';

final StudentsController controller = Get.find();

late Database _database;

class DB {
  Future openDb() async {
    _database = await openDatabase(
      'students.db',
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE  Students (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, mark INTEGER, image TEXT,schoolName TEXT)');
      },
    );
  }

  addStudent(ModelStudent student) async {
    await _database.rawInsert(
        'INSERT INTO Students(name,age,mark,image,schoolName) VALUES(?,?,?,?,?) ',
        [
          student.name,
          student.age,
          student.mark,
          student.image,
          student.schoolName,
        ]);
    controller.addNewStudent(student);
    await getAllStudets();
  }

  Future getAllStudets() async {
    List<ModelStudent> studentsList = [];
    studentsList.clear();
    var values = await _database.rawQuery('SELECT * FROM Students');
    for (var element in values) {
      var elem = ModelStudent.fromMap(element);
      studentsList.add(elem);
    }
    controller.getAllStudents(studentsList);
  }

  updateStudent(id, ModelStudent student) async {
    _database.rawUpdate(
      'UPDATE Students SET name = ?, age = ?,mark = ? , image = ? WHERE id = ?',
      [student.name, student.age, student.mark, student.image, id],
    );

    await getAllStudets();
  }

  deleteStudent(id, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('sure to delete?'),
            actions: [
              IconButton(
                  onPressed: () async {
                    print('deleting student od Id :$id');
                    await _database
                        .rawDelete('DELETE FROM Students WHERE id = ?', [id]);
                    await getAllStudets();

                    if (context.mounted) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (route) => false);
                    }
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  onPressed: () async {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.cancel)),
            ],
          );
        });
  }
}
