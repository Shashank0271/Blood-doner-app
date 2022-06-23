import 'package:blood_doner/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType {
  type1,
}

void setupDialogUi() {
  final DialogService _dialogService = locator<DialogService>();
  final builders = {
    DialogType.type1: (context, dialogRequest, completer) =>
        _ConfirmationDialog(
          request: dialogRequest,
          completer: completer,
        )
  };
  _dialogService.registerCustomDialogBuilders(builders);
}

class _ConfirmationDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _ConfirmationDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Dialog(child: null /* Build your dialog UI here */
        );
  }
}
