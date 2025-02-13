import 'package:get/get.dart';
import 'package:assaignment_taskmanager_project/data/models/task_list_by_status_model.dart';
import 'package:assaignment_taskmanager_project/data/models/task_model.dart';
import 'package:assaignment_taskmanager_project/data/services/network_caller.dart';
import 'package:assaignment_taskmanager_project/data/utils/urls.dart';

class NewTaskController extends GetxController {
  bool _getTaskListInProgress = false;

  bool get getTaskListInProgress => _getTaskListInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  TaskListByStatusModel? _taskListByStatusModel;

  List<TaskModel> get taskList => _taskListByStatusModel?.taskList ?? [];

  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskListByStatusUrl('New'),
    );
    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getTaskListInProgress = false;
    update();
    return isSuccess;
  }
}
