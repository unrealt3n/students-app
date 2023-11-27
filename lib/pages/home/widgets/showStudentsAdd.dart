import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week8/pages/home/functions/onpressedBtn.dart';
import 'package:week8/pages/home/functions/pick_image.dart';
import 'package:week8/pages/home/home_page.dart';

showStudentsAddDialog(BuildContext context) {
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
                        image = img;
                      });
                    }
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(image!.path),
                                width: 70,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const FlutterLogo(),
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
                TextField(
                    controller: schctrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'school name')),
                ElevatedButton(
                    onPressed: () async {
                      await onPressedBtn(namectrl.text, agectrl.text,
                          markctrl.text, image, schctrl.text, context);
                    },
                    child: const Text('add'))
              ],
            );
          });
        });
  }