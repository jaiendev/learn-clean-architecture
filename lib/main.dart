import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_learn_clean_architecture/core/app/bloc/app_bloc.dart';
import 'package:project_learn_clean_architecture/features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: MaterialApp(
        title: 'Flutter Demo Clean Architecture',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // initialRoute: Routes.rootRoute,
        // onGenerateRoute: (settings) {
        //   return AppNavigator().getRoute(settings);
        // },
        // navigatorObservers: [
        //   AppNavigatorObserver(),
        // ],
        home: const HomeScreen(),
      ),
    );
  }
}
