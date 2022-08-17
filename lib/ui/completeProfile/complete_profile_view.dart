import 'dart:io';
import 'package:blood_doner/ui/completeProfile/complete_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helper.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompleteProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 40, top: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpaceMedium,
                model.pickedImage == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(Icons.person),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            FileImage(File(model.pickedImage!.path)),
                      ),
                verticalSpaceTiny,
                GestureDetector(
                  onTap: model.selectImage,
                  child: const Text(
                    'upload profile picture',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  keyboardType: TextInputType.name,
                  controller: model.nameController,
                  decoration: const InputDecoration(
                      hintText: 'Your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                verticalSpaceSmall,
                TextField(
                  keyboardType: TextInputType.number,
                  controller: model.ageController,
                  decoration: const InputDecoration(
                    hintText: 'Your age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Text(
                      'Blood group',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 16),
                    ),
                    horizontalSpaceMedium,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.45),
                      child: DropdownButton(
                        value: model.selectedBloodgroup,
                        items: model.bgList,
                        onChanged: model.onChangedBloodgroup,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Purpose',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 16),
                    ),
                    horizontalSpaceLarge,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.45),
                      child: DropdownButton(
                        value: model.selectedRole,
                        items: model.roleList,
                        onChanged: model.onChangedPurpose,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: model.createUserinDb,
                  child: Container(
                    width: screenWidthPercentage(context, percentage: 0.65),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffffd200), Color(0xfff7971e)]),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                        child: model.isBusy
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.deepOrangeAccent,
                              )
                            : Text(
                                'Upload Details',
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                  ),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => CompleteProfileViewModel(),
    );
  }
}
