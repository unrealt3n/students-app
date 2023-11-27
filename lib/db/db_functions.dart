import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/pages/home/home_page.dart';
import 'package:week8/providers/students.dart';

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

  addStudent(ModelStudent student, BuildContext context) async {
    // students.value.add(student);
    await _database.rawInsert(
        'INSERT INTO Students(name,age,mark,image,schoolName) VALUES(?,?,?,?,?) ',
        [
          student.name,
          student.age,
          student.mark,
          student.image,
          student.schoolName,
        ]);
    context.read<StudentsProvider>().addNewStudent(student);
    // await getAllStudets();
  }

  Future getAllStudets(BuildContext context) async {
    List<ModelStudent> studentsList = [];
    studentsList.clear();
    var values = await _database.rawQuery('SELECT * FROM Students');
    for (var element in values) {
      var elem = ModelStudent.fromMap(element);
      studentsList.add(elem);
    }
    context.read<StudentsProvider>().getAllStudents(studentsList);
  }

  updateStudent(id, ModelStudent student, BuildContext context) async {
    _database.rawUpdate(
      'UPDATE Students SET name = ?, age = ?,mark = ? , image = ? WHERE id = ?',
      [student.name, student.age, student.mark, student.image, id],
    );

    await getAllStudets(context);
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
                    await getAllStudets(context);

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
