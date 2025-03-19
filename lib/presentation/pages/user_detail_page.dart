import 'package:codebase/core/constants/app_images.dart';
import 'package:codebase/core/constants/app_strings.dart';
import 'package:codebase/data/data_sources/user_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/user_data_model.dart';
import '../cubits/user_details_cubit.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  const UserDetailPage({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDetailsCubit(context.read<UserRemoteDataSource>())..fetchUserDetails(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.userDetails, style: TextStyle(color: AppColors.white),),
          backgroundColor: AppColors.secondaryColor,
          leading: IconButton(
            onPressed: () { Navigator.pop(context); },
            icon: Icon(Icons.arrow_back), color: AppColors.white),
        ),
        body: SafeArea(
          child: BlocBuilder<UserDetailsCubit, User?>(
            builder: (context, user) {
              if (user == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Container(
                margin: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.cardBackground), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(8.w)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar ?? ''),
                          radius: 12.h,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '${user.email}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          ),
        )
      ),
    );
  }
}
