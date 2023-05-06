import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidsapp_admin/screen/addproduct/add_product.dart';
import 'package:kidsapp_admin/screen/home/detail_screen/detailscreen.dart';
import 'package:kidsapp_admin/utilities/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';

class CateScreen extends StatefulWidget {
  final String cate;
  const CateScreen({super.key, required this.cate});

  @override
  State<CateScreen> createState() => _CateScreenState();
}

class _CateScreenState extends State<CateScreen> {
  Stream<QuerySnapshot>? _usersStream;

  @override
  void initState() {
    _usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: widget.cate)
        .snapshots();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kprimaryClr),
          backgroundColor: kwhiteClr,
          centerTitle: true,
          elevation: 1,
          title: Text(
            "${widget.cate} Stories",
            style: TextStyle(color: kprimaryClr),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length >= 10
                      ? 10
                      : snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: DetailScreen(
                                      title: data['title'],
                                      url: data['url'],
                                      cate: data['category'])));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(data['image']))),
                            ),
                            10.height,
                            Text(
                              data['title'],
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
