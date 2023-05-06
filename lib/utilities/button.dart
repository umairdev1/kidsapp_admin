import 'package:flutter/material.dart';
import 'package:kidsapp_admin/utilities/colors.dart';

class PrimaryBotton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const PrimaryBotton({
    Key? key,
    required this.title,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: kprimaryClr,
        height: 60,
        minWidth: double.maxFinite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          title,
          style: TextStyle(color: kwhiteClr, fontSize: 15),
        ),
        onPressed: onpress);
  }
}
