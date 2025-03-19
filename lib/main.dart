import 'package:codebase/core/network/dio_client.dart';
import 'package:codebase/data/data_sources/user_remote_data_source.dart';
import 'package:codebase/presentation/cubits/user_cubit.dart';
import 'package:codebase/presentation/cubits/user_details_cubit.dart';
import 'package:codebase/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() {
  final dioClient = DioClient();
  final userDataSource = UserRemoteDataSource(dioClient);

  runApp(MyApp(userDataSource: userDataSource));
}

class MyApp extends StatelessWidget {
  final UserRemoteDataSource userDataSource;

  const MyApp({super.key, required this.userDataSource});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => userDataSource,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserCubit(userDataSource)),
          BlocProvider(create: (context) => UserDetailsCubit(userDataSource))
        ],
        child: Sizer(
          builder: (context, orientation, screenType) {
            return MaterialApp(
              home: UsersPage(),
            );
          }
        ),
      ),
    );
  }
}
