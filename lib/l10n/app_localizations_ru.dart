// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get homePageEmptyTodoList =>
      'Нажмите \"+\", чтобы добавить вашу первую задачу!';

  @override
  String get addTodoDialogTitle => 'Добавить задачу';

  @override
  String get addTodoDialogTodoTitleField => 'Задача';

  @override
  String get addTodoDialogTodoTitleFieldEmptyError =>
      'Пожалуйста, введите название задачи';

  @override
  String get addTodoDialogTodoDescriptionField => 'Описание задачи';

  @override
  String get addTodoDialogTodoSaveButton => 'Сохранить';

  @override
  String get appBarFilterAll => 'Все';

  @override
  String get appBarFilterCompletedOnly => 'Только выполненные';

  @override
  String get appBarFilterUncompletedOnly => 'Только невыполненные';

  @override
  String get appBarSortNewestFirst => 'Сначала новые';

  @override
  String get appBarSortOldestFirst => 'Сначала старые';
}
