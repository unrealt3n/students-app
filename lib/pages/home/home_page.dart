import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week8/db/db_functions.dart';
import 'package:week8/pages/home/widgets/showStudentsAdd.dart';
import 'package:week8/pages/home/widgets/studetns.dart';
import 'package:week8/pages/seach/search_page.dart';

TextEditingController namectrl = TextEditingController();
TextEditingController agectrl = TextEditingController();
TextEditingController markctrl = TextEditingController();
TextEditingController schctrl = TextEditingController();
XFile? image;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DB().getAllStudets(context);

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
        const StudetnsShowWidget(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentsAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
