class ApiEndpoints {
  static const String baseUrl = "https://reqres.in/api";

  // User Endpoints
  static const String users = "/users";
  static String userDetails(int userId) => "/users/$userId";

  //Query Params
  static const String page = "page";
  static const String perPage = "per_page";
}