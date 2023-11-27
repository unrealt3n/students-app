import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/model/student_model.dart';
import 'package:week8/pages/home/home_page.dart';

onPressedBtn(String name, String age, String mark, XFile? imagef,
    String sclName, BuildContext context) async {
  if (name.isEmpty || age.isEmpty || mark.isEmpty || imagef == null) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('can\'t be empty')));

    Navigator.pop(context);
  } else {
    int ages = int.parse(age);
    int marks = int.parse(mark);

    String imagePath = imagef.path;

    ModelStudent student = ModelStudent(
      name: name,
      age: ages,
      mark: marks,
      image: imagePath,
      schoolName: sclName,
    );

    await DB().addStudent(student);

    namectrl.clear();
    agectrl.clear();
    markctrl.clear();
    image = null;
    Navigator.pop(context);
  }
}
