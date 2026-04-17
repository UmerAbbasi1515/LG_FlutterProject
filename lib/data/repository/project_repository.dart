
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/data/services/Project_service/project_service.dart';

class ProjectRepository {
  static Future<dynamic> getProjects() => ProjectServices.getProjects();
  static Future<dynamic> getProjectsWithFilter(
    String searchType,
    String search,
  ) =>
      ProjectServices.getProjectsWithFilter(searchType, search);
  static Future<dynamic> isFeedbackAdded(String projectId) =>
      ProjectServices.isFeedbackAdded(projectId);
  static Future<dynamic> submitProjectFeedback(
    FeedBackRequestModel param,
  ) =>
      ProjectServices.submitProjectFeedback(param);

  static Future<dynamic> getFeedbackDetail(String projectID) =>
      ProjectServices.getFeedbackDetail(projectID);
  static Future<dynamic>
      getFeedbackListDetail(String projectID) =>
          ProjectServices.getFeedbackListDetail(projectID);
}
