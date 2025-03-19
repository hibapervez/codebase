import 'package:codebase/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/data/models/user_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsCubit extends Cubit<User?> {
  final UserRemoteDataSource dataSource;

  UserDetailsCubit(this.dataSource) : super(null);

  Future<void> fetchUserDetails(int userId) async {
    try {
      final user = await dataSource.getUserDetails(userId);
      emit(user);
    } on Exception catch (e) {
      emit(null);
    }
  }
}