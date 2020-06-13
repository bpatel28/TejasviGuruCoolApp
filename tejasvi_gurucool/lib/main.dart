import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tejasvi_gurucool/bloc/batch/batch_bloc.dart';
import 'package:tejasvi_gurucool/bloc/students/students_bloc.dart';
import 'package:tejasvi_gurucool/bloc/subject/subject_bloc.dart';
import 'package:tejasvi_gurucool/bloc/user/user_bloc.dart';
import 'package:tejasvi_gurucool/helpers/route_helper.dart';
import 'package:tejasvi_gurucool/repository/batch_repository.dart';
import 'package:tejasvi_gurucool/repository/subject_repository.dart';
import 'package:tejasvi_gurucool/repository/user_repository.dart';
import 'package:tejasvi_gurucool/screens/about_us_screen.dart';
import 'package:tejasvi_gurucool/screens/add_module.dart';
import 'package:tejasvi_gurucool/screens/add_subject_screen.dart';
import 'package:tejasvi_gurucool/screens/module_items_screen.dart';
import 'package:tejasvi_gurucool/screens/my_profile_screen.dart';
import 'package:tejasvi_gurucool/screens/student_screen.dart';
import 'package:tejasvi_gurucool/screens/subjects_screen.dart';
import 'package:tejasvi_gurucool/screens/login_screen.dart';
import 'package:tejasvi_gurucool/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _userRepository = UserRepository();
  final _batchRepository = BatchRepository();
  final _subjectRepository = SubjectRepository();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(_userRepository),
        ),
        BlocProvider<BatchBloc>(
          create: (BuildContext context) => BatchBloc(_batchRepository),
        ),
        BlocProvider<SubjectBloc>(
          create: (BuildContext context) => SubjectBloc(_subjectRepository),
        ),
        BlocProvider<StudentsBloc>(
          create: (BuildContext context) => StudentsBloc(_userRepository),
        )
      ],
      child: MaterialApp(
        title: 'Tejasvi GuruCool',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueAccent,
          accentColor: Colors.redAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.LOGIN,
        routes: {
          Routes.LOGIN: (context) => LoginScreen(),
          Routes.REGISTER: (context) => RegisterScreen(),
          Routes.MODULE_ITEMS: (context) => ModuleItemsScreen(),
          Routes.STUDENTS: (context) => StudentSceen(),
          Routes.MY_PROFILE: (context) => MyProfileScreen(),
          Routes.ABOUT_US: (context) => AboutUsScreen(),
          Routes.ADD_SUBJECT: (context) => AddSubjectScreen(),
          Routes.ADD_MODULE: (context) => AddModuleScreen(),
        },
        home: SubjectsScreen(),
      ),
    );
  }
}
