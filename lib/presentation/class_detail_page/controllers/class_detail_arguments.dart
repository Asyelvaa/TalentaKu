import 'package:get/get.dart';

import '../../../domain/models/class_model.dart';
import '../../../domain/models/task_model.dart';

class ClassDetailArguments {
  final GradeModel classItem;
  final Task taskItem;

  ClassDetailArguments({
    required this.classItem,
    required this.taskItem,
  });
}