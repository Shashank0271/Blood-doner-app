import 'package:blood_doner/ui/ViewProfile/viewprofile_viewmodel.dart';
import 'package:blood_doner/widgets/dumb/profileinfobar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../ui/shared/ui_helper.dart';

// ignore: must_be_immutable
class ViewProfileView extends StatelessWidget {
  Map<String, String> userMap;
  ViewProfileView(this.userMap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 32, top: 48, right: 24),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    backgroundImage:
                        NetworkImage(userMap['imageUrl'] as String),
                  ),
                ),
                verticalSpaceMedium,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    (userMap['userName'] as String).toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                verticalSpaceLarge,
                ProfileInfoBar(data: 'Blood Group : ${userMap['bloodGroup']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Age : ${userMap['age']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Email : ${userMap['email']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Role : ${userMap['role']}'),
              ]),
        ),
      ),
      viewModelBuilder: () => ViewProfileViewModel(),
    );
  }
}
