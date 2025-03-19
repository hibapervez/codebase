import 'package:codebase/core/constants/app_colors.dart';
import 'package:codebase/core/constants/app_strings.dart';
import 'package:codebase/data/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

import '../cubits/user_cubit.dart';
import '../widgets/user_card.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usersCubit = context.read<UserCubit>();

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: const Text(AppStrings.usersList, style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.w)
                ),
                padding: EdgeInsets.fromLTRB(1.w, 2.w, 1.w, 1.w),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppStrings.searchUsers,
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(top: 1.2.h)
                  ),
                  onChanged: (query) {
                    usersCubit.searchUsers(query); // Trigger search in Cubit
                  },
                ),
              ),

              SizedBox(height: 2.h),

              Expanded(
                child: BlocBuilder<UserCubit, List<User>>(
                  builder: (context, users) {
                    if(_searchController.text.isNotEmpty) {
                      ///Search is active, return filtered list
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => UserCard(user: users[index])
                      );
                    } else {
                      ///Search is inactive, return all users
                      return PagedListView<int, User>.separated(
                        pagingController: usersCubit.pagingController,
                        separatorBuilder: (context, index) => SizedBox(height: 0.6.h),
                        builderDelegate: PagedChildBuilderDelegate<User>(
                          itemBuilder: (context, user, index) => UserCard(user: user),
                        ),
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
