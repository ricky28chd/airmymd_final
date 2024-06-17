import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/models/get_notes_response.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';

import '../../../main.dart';

var newLists = [];

class NotesController extends GetxController {
  NotesController(this._notesPresenter);
  final NotesPresenter _notesPresenter;
  var a = [];

  /// All variables here
  var selectedButton = 'My Notes';
  List<SharedNotes> sharedNotes = [];
  var sharedNotesErrorText = '';
  List<MyNotes> myNotes = [];
  var myNotesErrorText = '';

  /// All controllers here==============
  var titleController = TextEditingController();
  String didYouMean = '';
  //SpellCheck spellCheck = SpellCheck.fromWordsList(['cat', 'bat', 'hat']);
  var descriptionController = TextEditingController();
  var usersController = TextEditingController();
  var userControllerErrorText = ''.obs;

  SpellCheck spellCheck = SpellCheck.fromWordsList(['cat', 'bat', 'hat']);
  void spellCheckValidate() {
    DateTime start = DateTime.now();
    String text = descriptionController.text;
    didYouMean = spellCheck.didYouMean(text);
    DateTime end = DateTime.now();

    int timeSpent = end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;

    update();
  }

  /// Onchange event for users textfield
  void inputUsers(String value) {
    // if (value.isNotEmpty) {
    //   userControllerErrorText.value = '';
    // } else {
    //   userControllerErrorText.value = 'Please enter email or number';
    // }
    update();
  }

  void onUpcomingButtonSelected() {
    selectedButton = 'Shared Notes';
    update();
  }

  void onPastButtonSelected() {
    selectedButton = 'My Notes';
    update();
  }

  ///Validate email==============================================
  validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value)) {
      Get.defaultDialog(
        title: '!Invalid Email',
        content: const Text('Please check email again!'),
      );
    } else {}
  }

  /// Add noted api==========
  Future<void> addNotes() async {
    print('newLists$newLists');
    print('a.toString()$a');
    print('multipleFinalImages$multipleFinalImages');
    // a = multipleFinalImages;
    // update();

    if (usersController.text.isEmpty) {
      var response = await _notesPresenter.addNote(
          isLoading: true,
          title: titleController.text.replaceAll(',', ''),
          description: descriptionController.text,
          users: usersController.text.trim().endsWith(',')
              ? usersController.text.removeLast()
              : usersController.text,
          dateTime: DateFormat('d MMM hh:mm a').format(DateTime.now()),
          userId: box.get(
                'notesId',
              ) ??
              0);
      if (response.returnCode == 1) {
        await getNotes(isLoading: false);
        titleController.clear();
        newLists.clear();
        descriptionController.clear();
        usersController.clear();
        box.delete(
          'notesId',
        );
        Utility.closeDialog();
        Get.back();
      }
      // } else if (usersController.text.isEmpty) {
      userControllerErrorText.value = 'Please enter user first';
      // }
    } else {
      var response = await _notesPresenter.addNote(
          isLoading: true,
          title: titleController.text,
          description: descriptionController.text,
          users: usersController.text.trim().endsWith(',')
              ? usersController.text.removeLast()
              : usersController.text,
          dateTime: DateFormat('d MMM hh:mm a').format(DateTime.now()),
          userId: box.get(
                'notesId',
              ) ??
              0);
      if (response.returnCode == 1) {
        newLists.clear();
        await getNotes(isLoading: false);
        titleController.clear();
        descriptionController.clear();
        usersController.clear();
        box.delete(
          'notesId',
        );
        Utility.closeDialog();
        Get.back();
      }
    }

    // }
    // }
  }

  /// Get notes api response
  Future<void> getNotes({
    bool isLoading = true,
  }) async {
    var response = await _notesPresenter.getNotes(
      isLoading: isLoading,
    );
    if (response.returnCode == 1) {
      Utility.closeDialog();

      if (response.shared!.isEmpty) {
        sharedNotesErrorText = 'You don\'t have any notes yet.';
      } else {
        sharedNotesErrorText = '';
        sharedNotes = response.shared!;
        sharedNotes.sort((a, b) => b.id!.compareTo(a.id!.toInt()));
      }
      if (response.myNotes!.isEmpty) {
        myNotesErrorText = 'You don\'t have any notes yet.';
      } else {
        myNotesErrorText = '';
        myNotes = response.myNotes!;
        myNotes.sort((a, b) => b.id!.compareTo(a.id!.toInt()));
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    spellCheckValidate();

    getNotes();

    update();
  }

  updates() {
    if (titleController.text.isEmpty) {
      titleController.text = box.get('notesTitle') ?? '';
    } else {
      // box.put('notesTitle', titleController.text) ?? '';
    }
    if (descriptionController.text.isEmpty) {
      descriptionController.text = box.get('notesDescription') ?? '';
    } else {
      // box.put('notesDescription', descriptionController.text);
    }
    if (usersController.text.isEmpty) {
      usersController.text = box.get('notesUsers') ?? '';
    } else {
      // box.put('notesUsers', usersController.text);
    }
  }

  clearChache() async {
    multipleFinalImages.clear();
    a.clear();
    await box.delete('notesTitle');
    await box.delete('notesDescription');
    await box.delete('notesUsers');
    await box.delete(
      'notesId',
    );
    newLists.clear();
    titleController.clear();
    descriptionController.clear();
    usersController.clear();
    update();
  }
}
