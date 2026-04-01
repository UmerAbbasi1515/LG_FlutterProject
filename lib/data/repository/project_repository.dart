import 'package:localgovernment_project/data/services/Project_service/project_service.dart';

class ProjectRepository {
  static Future<dynamic> getProjects() => ProjectServices.getProjects();
  static Future<dynamic> getProjectsWithFilter(
    String searchType,
    String search,
  ) =>
      ProjectServices.getProjectsWithFilter(searchType, search);
}
