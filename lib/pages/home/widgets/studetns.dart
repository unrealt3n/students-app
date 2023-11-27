import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/functions/updateStudents.dart';
import 'package:week8/pages/detailed_screen.dart';
import 'package:week8/providers/students.dart';

class StudetnsShowWidget extends StatelessWidget {
  const StudetnsShowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentsProvider>(
      builder: (context, studentsProvider, _) {
        if (studentsProvider.students.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: studentsProvider.students.length,
              itemBuilder: (context, int ind) {
                var data = studentsProvider.students[ind];

                return SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: const Color(0xff222325),
                    child: Center(
                        child: ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async =>
                                  await DB().deleteStudent(data.id, context),
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
            ),
          );
        } else {
          return Container(
            child: const Text('emnpty'),
          );
        }
      },
    );
  }
}
