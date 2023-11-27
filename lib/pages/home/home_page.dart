import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week8/controller/home_page.dart';
import 'package:week8/pages/home/functions/show_dialog.dart';
import 'package:week8/pages/home/widgets/studetns.dart';
import 'package:week8/pages/seach/search_page.dart';

TextEditingController namectrl = TextEditingController();
TextEditingController agectrl = TextEditingController();
TextEditingController markctrl = TextEditingController();
TextEditingController schctrl = TextEditingController();
XFile? image;

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final controller = Get.put(StudentsController());
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffe1d5c9),
      body: Column(children: [
        const SizedBox(height: 40),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: IconButton(
              alignment: Alignment.topRight,
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage())),
              icon: const Icon(Icons.search)),
        ),
        StudetnsShowWidget(controller: controller),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentsAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

 
}
