import 'package:codebase/core/network/api_endpoints.dart';
import 'package:codebase/core/network/dio_client.dart';
import 'package:codebase/data/models/user_data_model.dart';

class UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSource(this.dioClient);

  Future<List<User>> getUsers({required int page, required int perPage}) async {
    final response = await dioClient.get(ApiEndpoints.users, queryParameters: {
      ApiEndpoints.page: page,
      ApiEndpoints.perPage: perPage
    });
    final List<dynamic> data = response.data['data'];
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> getUserDetails(int userId) async {
    final response = await dioClient.get(ApiEndpoints.userDetails(userId));
    return User.fromJson(response.data['data']);
  }
}