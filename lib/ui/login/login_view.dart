import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helper.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 40, top: 55, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome\nBack!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                verticalSpaceLarge,
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: model.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Your email',
                  ),
                ),
                verticalSpaceSmall,
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: model.passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                verticalSpaceLarge,
                GestureDetector(
                  onTap: model.loginViaEmail,
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
                                'Login',
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    horizontalSpaceLarge,
                    const Text('Don\'t have an account ?'),
                    TextButton(
                        onPressed: model.gotoSignupView,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          )),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
