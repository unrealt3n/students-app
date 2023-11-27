import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/functions/updateStudents.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/pages/detailed_screen.dart';
import 'package:week8/pages/seach/functions/get_all_students.dart';
import 'package:week8/providers/students.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  late Future<List<ModelStudent>> allStudents;

  @override
  Widget build(BuildContext context) {
    allStudents = getAllStudents(context);
    print('filled the allStudents');
    return Scaffold(
        backgroundColor: const Color(0xffe1d5c9),
        body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                      onChanged: (value) {
                        context
                            .read<StudentsProvider>()
                            .updateSearchString(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer<StudentsProvider>(
                      builder: (context, studentsProvider, _) {
                        return FutureBuilder(
                            future: allStudents,
                            builder: (context,
                                AsyncSnapshot<List<ModelStudent>> snapshot) {
                              if (studentsProvider.students.isEmpty ||
                                  !snapshot.hasData) {
                                return const SizedBox(
                                  child: Center(child: Text('no data to show')),
                                );
                              } else {
                                return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, ind) {
                                      ModelStudent stud =
                                          studentsProvider.students[ind];
                                      return snapshot.data![ind].name
                                              .toLowerCase()
                                              .contains(
                                                  studentsProvider.searchString)
                                          ? SizedBox(
                                              height: 100,
                                              child: Card(
                                                color: const Color(0xff222325),
                                                child: Center(
                                                  child: ListTile(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailedPage(
                                                        id: stud.id,
                                                        name: stud.name,
                                                        age: stud.age,
                                                        mark: stud.mark,
                                                        image: stud.image,
                                                      ),
                                                    )),
                                                    leading: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Image.file(
                                                        File(stud.image),
                                                        width: 70,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      stud.name,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              await DB()
                                                                  .deleteStudent(
                                                                stud.id,
                                                                context,
                                                              );
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete)),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              await updateStudentData(
                                                                context,
                                                                stud.name,
                                                                stud.age,
                                                                stud.mark,
                                                                stud.image,
                                                                stud.id,
                                                                stud.schoolName,
                                                              );
                                                            },
                                                            icon: const Icon(
                                                                Icons.edit)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    });
                              }
                            });
                      },
                    ),
                  )
                ])));
  }
}
