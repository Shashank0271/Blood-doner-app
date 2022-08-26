import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../app/app.locator.dart';
import 'home_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel:
          false, //so that we reuse the same viewmodel to maintain the state
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        floatingActionButton: SpeedDial(
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Text('A+'), onTap: () => model.filterWithBg('A+')),
            SpeedDialChild(
                child: const Text('A-'), onTap: () => model.filterWithBg('A-')),
            SpeedDialChild(
                child: const Text('B+'), onTap: () => model.filterWithBg('B+')),
            SpeedDialChild(
                child: const Text('B-'), onTap: () => model.filterWithBg('A-')),
            SpeedDialChild(
                child: const Text('AB+'),
                onTap: () => model.filterWithBg('AB+')),
            SpeedDialChild(
                child: const Text('AB-'),
                onTap: () => model.filterWithBg('AB-')),
            SpeedDialChild(
                child: const Text('O+'), onTap: () => model.filterWithBg('O+')),
            SpeedDialChild(
                child: const Text('O-'), onTap: () => model.filterWithBg('O-'))
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (_, bool innerBoxIsScrolled) => [
                  SliverAppBar(
                    actions: [
                      PopupMenuButton(
                          itemBuilder: (_) => [
                                PopupMenuItem(
                                  onTap: model.performLogout,
                                  child: const Text('Logout'),
                                ),
                              ])
                    ],
                    stretch: true,
                    expandedHeight: 30,
                    floating: true,
                    title: const Text('Blood Bank'),
                  )
                ],
                body: LiquidPullToRefresh(
                  onRefresh: model.futureToRun,
                  showChildOpacityTransition: false,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    child: ListView.builder(
                      itemCount: model.displayList.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                              model.displayList[index]['imageUrl'],
                            ),
                          ),
                          title: Text(
                            '${model.displayList[index]['userName']} (${model.displayList[index]['role']})',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Blood group : ${model.displayList[index]['bloodGroup']}'),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
      viewModelBuilder: () => locator<HomeViewModel>(),
    );
  }
}
