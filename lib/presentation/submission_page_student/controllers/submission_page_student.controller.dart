import 'package:get/get.dart';

import '../../../domain/models/submission_model.dart';
import '../../../infrastructure/dal/services/api_task.dart';

class SubmissionPageStudentController extends GetxController {
  var gradeId = ''.obs;
  var taskId = ''.obs;
  var submissionId = ''.obs;
  // var studentIdSubmitted = ''.obs;
  // var dataSubmission = SubmissionModel().obs;
  Rx<SubmissionModel> submissionData = SubmissionModel().obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    taskId.value = arguments['taskId'].toString();
    gradeId.value = arguments['gradeId'].toString();
    submissionId.value = arguments['submissionId'].toString();
    // studentIdSubmitted.value = arguments['studentIdSubmitted'].toString();
    print('pass arg taskId: ${taskId.value}, gradeId: ${gradeId.value}, submissionId: ${submissionId.value}');
    fetchSubmissionsById();
  }
  @override
  void onClose() {
    super.onClose();
  }

  void fetchSubmissionsById() async {
    final response = await ApiServiceTask().getSubmissionDetail(gradeId.value, taskId.value, submissionId.value);
    submissionData.value = response;
    print(submissionData.value);
  }

}
