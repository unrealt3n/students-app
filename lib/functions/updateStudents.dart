import 'dart:io';

import 'package:flutter/material.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/pages/home/functions/pick_image.dart';
import 'package:week8/pages/home/home_page.dart';

Future updateStudentData(BuildContext context, name, age, mark,
    String imagePath, id, String sclName) async {
  namectrl.text = name;
  agectrl.text = age.toString();
  markctrl.text = mark.toString();
  // image = imagePath;

  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            actions: [
              GestureDetector(
                onTap: () async {
                  var img = await selectImage();
                  if (img != null) {
                    setState(() {
                      imagePath = img.path;
                    });
                  }
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        File(imagePath),
                        width: 70,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                  keyboardType: TextInputType.text,
                  controller: namectrl,
                  decoration: const InputDecoration(hintText: 'name')),
              TextField(
                  keyboardType: TextInputType.number,
                  controller: agectrl,
                  decoration: const InputDecoration(hintText: 'age')),
              TextField(
                  controller: markctrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'mark')),
              ElevatedButton(
                  onPressed: () async {
                    int intAge = int.parse(agectrl.text);
                    int intMark = int.parse(markctrl.text);
                    ModelStudent student = ModelStudent(
                      name: namectrl.text,
                      image: imagePath,
                      age: intAge,
                      mark: intMark,
                      schoolName: sclName,
                    );

                    await DB().updateStudent(id, student, context);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('update'))
            ],
          );
        });
      });
}
