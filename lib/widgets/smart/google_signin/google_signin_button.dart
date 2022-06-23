import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import '../../../ui/shared/ui_helper.dart';
import 'google_signin_buttonmodel.dart';

class GoogleSigninButtonWidget extends StatelessWidget {
  const GoogleSigninButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GoogleSignInButtonWidgetModel>.reactive(
      builder: (context, model, child) => GestureDetector(
        onTap: model.googleSignIn,
        child: Container(
          width: screenWidthPercentage(context, percentage: 0.65),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x3f000000),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.google, color: Colors.red),
              horizontalSpaceMedium,
              Text(
                'Sign in with Google',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          )),
        ),
      ),
      viewModelBuilder: () => GoogleSignInButtonWidgetModel(),
    );
  }
}
