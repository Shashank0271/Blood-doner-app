import 'package:flutter/material.dart';
import '../../ui/shared/ui_helper.dart';

// ignore: must_be_immutable
class ProfileInfoBar extends StatelessWidget {
  String data;
  ProfileInfoBar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(24),
      ),
      elevation: 5,
      child: Container(
        width: screenWidthPercentage(context, percentage: 0.7),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: const BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            )),
        child: Text(
          data,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
