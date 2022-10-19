import 'package:easy_localization/easy_localization.dart';

extension XDateTime on DateTime {
  String get toStr => DateFormat.yMMMMEEEEd().add_jm().format(this);
}
