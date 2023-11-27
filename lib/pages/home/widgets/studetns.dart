import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:week8/controller/home_page.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/functions/updateStudents.dart';
import 'package:week8/pages/detailed_screen.dart';

class StudetnsShowWidget extends StatelessWidget {
  const StudetnsShowWidget({
    super.key,
    required this.controller,
  });

  final StudentsController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<StudentsController>(
          init: controller,
          builder: (studentCtrl) {
            return studentCtrl.students.isNotEmpty
                ? ListView.builder(
                    itemCount: studentCtrl.students.length,
                    itemBuilder: (context, int ind) {
                      var data = studentCtrl.students[ind];

                      return SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: const Color(0xff222325),
                          child: Center(
                              child: ListTile(
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => DetailedPage(
                                id: data.id,
                                name: data.name,
                                age: data.age,
                                mark: data.mark,
                                image: data.image,
                              ),
                            )),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(data.image),
                                width: 70,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () async => await DB()
                                        .deleteStudent(data.id, context),
                                    icon: const Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () async {
                                      await updateStudentData(
                                        context,
                                        data.name,
                                        data.age,
                                        data.mark,
                                        data.image,
                                        data.id,
                                        data.schoolName,
                                      );
                                    },
                                    icon: const Icon(Icons.edit)),
                              ],
                            ),
                          )),
                        ),
                      );
                    },
                  )
                : Container(
                    child: const Text('emnpty'),
                  );
          }),
    );
  }
}
