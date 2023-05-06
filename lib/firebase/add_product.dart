import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidsapp_admin/screen/home/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class Product {
  String getImageName(XFile image) {
    return image.path.split("/").last;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('products');
  Future<String> uploadImage(
      XFile image, String title, String cat, url, BuildContext context) async {
    Reference db = FirebaseStorage.instance.ref("image/${getImageName(image)}");

    await db.putFile(File(image.path));
    return await db.getDownloadURL().then((value) async {
      users
          .add({
            'image': value,
            'title': title,
            'url': url,
            'category': cat,
            'star1': 0,
            'star2': 0,
            'star3': 0,
            'star4': 0,
            'star5': 0,
            'publish': false,
          })
          .then((value) => print('Product Edited'))
          .whenComplete(() {
            EasyLoading.showToast("Successfully Added");

            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const HomeScreen()));
          })
          .catchError((error) => print("failedtoadduser: $error"));

      return '';
    });
  }
}
