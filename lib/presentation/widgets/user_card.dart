import 'package:codebase/core/constants/app_colors.dart';
import 'package:codebase/data/models/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../pages/user_detail_page.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.primaryColor,
      child: ListTile(
        onTap: () {
          /// Navigate to User Details Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetailPage(userId: user.id!)),
          );
        },
        leading: CircleAvatar(
          radius: 7.w,
          backgroundImage: NetworkImage(user.avatar ?? '')
        ),
        title: Text(
          '${user.firstName} ${user.lastName}',
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        subtitle: Text('${user.email}'),
      ),
    );
  }
}
