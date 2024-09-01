import 'package:get/get.dart';
import '../../../domain/models/submission_detail_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../infrastructure/dal/services/api_task.dart';

class SubmissionPageStudentController extends GetxController {
  var isLoadingTask = true.obs; // Separate loading state for task
  var isLoadingSubmission = true.obs; // Separate loading state for submission
  var gradeId = ''.obs;
  var taskId = ''.obs;
  var submissionId = ''.obs;
  Rxn<Task> taskData = Rxn<Task>();
  Rxn<SubmissionDetailModel> submissionData = Rxn<SubmissionDetailModel>();
  RxString errorMessage = ''.obs; // Error message observable

  @override
  void onInit() {
    super.onInit();
    initializeArguments();
    fetchTaskDetails();
    fetchSubmissionsById();
  }

  void initializeArguments() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      taskId.value = arguments['taskId']?.toString() ?? '';
      gradeId.value = arguments['gradeId']?.toString() ?? '';
      print('Passed arguments -> Task ID: ${taskId.value}, Grade ID: ${gradeId.value}');
    } else {
      errorMessage.value = 'Missing arguments';
    }
  }

  Future<void> fetchTaskDetails() async {
    if (taskId.value.isEmpty || gradeId.value.isEmpty) {
      errorMessage.value = 'Invalid task or grade ID';
      return;
    }

    isLoadingTask.value = true;
    errorMessage.value = ''; // Clear previous errors
    try {
      final taskDetails = await ApiServiceTask().getDetailTask(gradeId.value, taskId.value);
      if (taskDetails != null) {
        taskData.value = taskDetails;
        print('Fetched Task: ${taskData.value}');
      } else {
        errorMessage.value = 'Task details not found';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching task details: $e';
      print(errorMessage.value);
    } finally {
      isLoadingTask.value = false;
    }
  }

  Future<void> fetchSubmissionsById() async {
    if (taskId.value.isEmpty || gradeId.value.isEmpty) {
      errorMessage.value = 'Invalid task or grade ID';
      return;
    }

    isLoadingSubmission.value = true;
    errorMessage.value = ''; // Clear previous errors
    try {
      final submissionDetail = await ApiServiceTask().getDetailSubmission(gradeId.value, taskId.value);
      if (submissionDetail != null) {
        submissionData.value = submissionDetail;
        print('Fetched Submission: ${submissionData.value}');
      } else {
        errorMessage.value = 'Submission details not found';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching submission details: $e';
      print(errorMessage.value);
    } finally {
      isLoadingSubmission.value = false;
    }
  }
}
