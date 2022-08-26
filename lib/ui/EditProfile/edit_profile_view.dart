import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:uiblock/default_uiblock_loader.dart';
import 'package:uiblock/uiblock.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name;
    String? age;

    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 32, top: 48, right: 24),
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                verticalSpaceMedium,
                Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              radius: 50,
                              child: Image(
                                  image: NetworkImage(model.getUserImageUrl))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2.5,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.deepOrange.shade300,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    )),
                verticalSpaceMedium,
                const Text(
                  'Username',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  initialValue: model.getUserName,
                  onChanged: (value) => name = value,
                ),
                verticalSpaceMedium,
                const Text(
                  'Age',
                  style: TextStyle(color: Colors.grey),
                ),
                TextFormField(
                  initialValue: model.getUserAge,
                  onChanged: (value) => age = value,
                ),
                const SizedBox(height: 190),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: const Text("CANCEL",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        UIBlock.block(context);
                        model.updateUserProfile(newuserName: name, newAge: age);
                        if(!model.isBusy) {
                          UIBlock.unblock(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    )
                  ],
                )
              ]),
        ),
      )),
      viewModelBuilder: () => EditProfileViewModel(),
    );
  }
}
