import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/screens/search_page.dart';
import 'package:weatherapps/screens/weather_results_page.dart';
import 'package:weatherapps/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: MaterialApp(
        title: 'Weather App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: {
          SearchPage.id: (context) => SearchPage(),
          WeatherResults.id: (context) => const WeatherResults()
        },
        initialRoute: SearchPage.id,
      ),
    );
  }
}
