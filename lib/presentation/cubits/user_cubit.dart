import 'package:codebase/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/data_sources/user_remote_data_source.dart';
import '../../data/models/user_data_model.dart';

class UserCubit extends Cubit<List<User>> {
  final UserRemoteDataSource dataSource;
  final List<User> _allUsers = []; // Store all users

  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);

  UserCubit(this.dataSource) : super([]) {
    _allUsers.clear();
    pagingController.addPageRequestListener((pageKey) {
      fetchUsers(pageKey);
    });
  }

  fetchUsers(int page) async {
    try {
      final users = await dataSource.getUsers(page: page, perPage: AppConstants.pageSize);

      if (users.length < AppConstants.pageSize) {
        pagingController.appendLastPage(users);
      } else {
        pagingController.appendPage(users, page + 1);
      }

      _allUsers.addAll(users);
    } on Exception catch (e) {
      pagingController.error = e;
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      emit(_allUsers); // Reset to full list
    } else {
      final filteredUsers = _allUsers.where((user) {
        return user.firstName!.toLowerCase().contains(query.toLowerCase()) ||
            user.lastName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(filteredUsers);
    }
  }
}