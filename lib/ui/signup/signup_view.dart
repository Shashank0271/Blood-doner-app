import 'package:blood_doner/widgets/smart/google_signin/google_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helper.dart';
import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 40, top: 23, right: 24),
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Create \nAccount',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: model.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'E-mail',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            verticalSpaceSmall,
            TextField(
              controller: model.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: model.createAccount,
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
                            'Sign up',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
              ),
            ),
            verticalSpaceTiny,
            Text(
              'or',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            verticalSpaceTiny,
            const GoogleSigninButtonWidget(),
          ]),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
