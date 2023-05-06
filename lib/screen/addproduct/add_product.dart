import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidsapp_admin/utilities/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../firebase/add_product.dart';
import '../../utilities/button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  XFile? singleImage;
  chooseImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  final _formKey = GlobalKey<FormState>();
  var cat = TextEditingController();
  var title = TextEditingController();
  var videourl = TextEditingController();

  String titlename = ' Select category';
  List<String> titlenameList = ["Hindi", "English", "Fairy"];
  List colorList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kprimaryClr),
        backgroundColor: kwhiteClr,
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Add Story",
          style: TextStyle(color: kprimaryClr),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                InkWell(
                  onTap: () async {
                    singleImage = await chooseImage();
                    if (singleImage != null && singleImage!.path.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kprimaryClr)),
                    child: Center(
                      child: singleImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(singleImage!.path),
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.image),
                                10.width,
                                const Text(
                                  "Add Image",
                                  style: TextStyle(color: kprimaryClr),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                20.height,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: kprimaryClr),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: kprimaryClr),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                20.height,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: kprimaryClr),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: videourl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Video Url',
                        labelStyle: TextStyle(color: kprimaryClr),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                20.height,
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: kprimaryClr),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      readOnly: true,
                      controller: cat,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: DropdownButton(
                          focusColor: kprimaryClr,
                          underline: Container(
                            height: 0,
                            color: Colors.transparent,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onChanged: (String? newValue) {
                            setState(() {
                              titlename = newValue!;
                              cat.text = newValue;
                            });
                          },
                          items: titlenameList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(color: kprimaryClr),
                                  ),
                                ));
                          }).toList(),
                        ),
                        labelText: 'Category',
                        labelStyle: const TextStyle(color: kprimaryClr),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                30.height,
                PrimaryBotton(
                  onpress: () {
                    if (_formKey.currentState!.validate()) {
                      if (singleImage == null) {
                        EasyLoading.showToast("please select Image");
                      } else {
                        if (cat.text.isNotEmpty) {
                          EasyLoading.show();
                          Product().uploadImage(singleImage!, title.text,
                              cat.text, videourl.text.toString(), context);
                        } else {
                          EasyLoading.showToast("please select Category");
                        }
                      }
                    }
                  },
                  title: 'Add Story',
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
