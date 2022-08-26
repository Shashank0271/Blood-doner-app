import 'package:blood_doner/app/app.locator.dart';
import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  late List userList = [];
  late List displayList = [];
  final _log = getLogger('HomeView-Model');

  Future<void> filterWithBg(String bloodGroup) async {
    displayList = userList
        .where((element) => element['bloodGroup'] == bloodGroup)
        .toList();
    notifyListeners();
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
  }

  Future<void> sendEmailToUser({required String toEmail}) async {
    final Email email = Email(
      body: 'Enter you message here',
      subject: 'Blood Donation',
      recipients: [toEmail],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Future futureToRun() async {
    userList = await _firestoreService.fetchAllUsers();
    displayList = [...userList];
    _log.i(userList);
    notifyListeners();
  }
}
