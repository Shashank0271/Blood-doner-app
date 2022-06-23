import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'enter item name'),
            controller: model.nameController,
          ),
          verticalSpaceMassive,
          ElevatedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.add),
              label: const Text('Add item to list')),
          verticalSpaceMedium,
          ElevatedButton.icon(
              onPressed: model.triggerSignout,
              icon: const Icon(Icons.exit_to_app),
              label: const Text('log out')),
          verticalSpaceMedium,
          ElevatedButton(
              onPressed: model.triggerDialog,
              child: const Text('trigger dialog'))
        ]),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
