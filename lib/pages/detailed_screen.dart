import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:week8/controller/home_page.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/functions/updateStudents.dart';
import 'package:week8/model/student_model.dart';

class DetailedPage extends StatelessWidget {
  final id;
  final name;
  final age;
  final mark;
  final image;

  DetailedPage({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.mark,
    required this.image,
  });

 

DB db = DB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1d5c9),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          child: Card(
            color: const Color(0xff222325),
            child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GetBuilder<StudentsController>(builder: (studentsCtrl) {
                  int index =
                      studentsCtrl.students.indexWhere((element) => element.id == id);
                  ModelStudent student = studentsCtrl.students[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(student.image),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      RichText(
                          text: TextSpan(
                              text: 'Name : ',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              children: [
                            TextSpan(
                                text: student.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          text: TextSpan(
                              text: 'Age : ',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              children: [
                            TextSpan(
                                text: student.age.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                          ])),
                      const SizedBox(height: 5),
                      RichText(
                          text: TextSpan(
                              text: 'Mark : ',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              children: [
                            TextSpan(
                                text: student.mark.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))
                          ])),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () => updateStudentData(
                                  context,
                                  student.name,
                                  student.age,
                                  student.mark,
                                  student.image,
                                  student.id,
                                  student.schoolName),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                db.deleteStudent(id, context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  );
                })),
          ),
        ),
      ),
    );
  }
}
