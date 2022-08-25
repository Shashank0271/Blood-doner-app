import 'package:blood_doner/ui/EditProfile/edit_profile_view.dart';
import 'package:blood_doner/ui/Page/page_viewmodel.dart';
import 'package:blood_doner/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class PageView extends StatelessWidget {
  const PageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: getViewForIndex(model.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.edit), label: 'Profile'),
            ]),
      ),
      viewModelBuilder: () => PageViewModel(),
    );
  }

  Widget getViewForIndex(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomeView();
      case 1:
        return EditProfileView();
      default:
        return HomeView();
    }
  }
}
