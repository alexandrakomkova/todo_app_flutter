// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homePageEmptyTodoList => 'Click \"+\" to add your first task!';

  @override
  String get addTodoDialogTitleAddMode => 'Add Task';

  @override
  String get addTodoDialogTitleEditMode => 'Edit Task';

  @override
  String get addTodoDialogTodoTitleField => 'Title';

  @override
  String get addTodoDialogTodoTitleFieldEmptyError => 'Please enter task title';

  @override
  String get addTodoDialogTodoDescriptionField => 'Description';

  @override
  String get addTodoDialogTodoSaveButton => 'Save';

  @override
  String get appBarFilterAll => 'All';

  @override
  String get appBarFilterCompletedOnly => 'Completed only';

  @override
  String get appBarFilterUncompletedOnly => 'Uncompleted only';

  @override
  String get appBarSortNewestFirst => 'Newest first';

  @override
  String get appBarSortOldestFirst => 'Oldest first';
}
