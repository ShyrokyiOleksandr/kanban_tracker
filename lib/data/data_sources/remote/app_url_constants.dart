final class AppUrlConstants {
  // Api Token for crated test account
  static const apiToken = "5293e33561d3f0559308cd492822f4018826244f";

  // Project id for project "Personal" from the test account
  static const projectId = '1528763597';

  static const baseUrl = "https://api.todoist.com/rest/v2";
  static const sections = "$baseUrl/sections?project_id=$projectId";
  static const tasks = "$baseUrl/tasks";

  const AppUrlConstants._();
}
