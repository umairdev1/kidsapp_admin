import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidsapp_admin/screen/addproduct/add_product.dart';
import 'package:kidsapp_admin/screen/category/category_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pod_player/pod_player.dart';

class DetailScreen extends StatefulWidget {
  final String title, url, cate;
  const DetailScreen(
      {super.key, required this.title, required this.url, required this.cate});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final PodPlayerController controller;
  Stream<QuerySnapshot>? _usersStream;
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.url),
    )..initialise();
    _usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: widget.cate)
        .snapshots();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            PodVideoPlayer(controller: controller),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Similar Story",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: CateScreen(
                                cate: widget.cate,
                              )));
                    },
                    child: const Text(
                      "Sell All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
