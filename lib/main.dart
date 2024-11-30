import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/screens/home_screen.dart';
import 'package:weatherapps/screens/main_screen.dart';
import 'package:weatherapps/screens/search_page.dart';
import 'package:weatherapps/screens/weather_results_page.dart';
import 'package:weatherapps/theme/app_theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

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
        initialRoute: MainScreen.id,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MainScreen.id:
              return MaterialPageRoute(
                builder: (context) => const MainScreen(),
              );
            case WeatherResults.id:
              return MaterialPageRoute(
                builder: (context) => const WeatherResults(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const MainScreen(),
              );
          }
        },
      ),
    );
  }
}
