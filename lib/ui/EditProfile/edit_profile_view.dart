import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) => const Scaffold(
        body: Center(child: Text('EDIT PROFILE')),
      ),
      viewModelBuilder: () => EditProfileViewModel(),
    );
  }
}
