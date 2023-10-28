import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/search_page.dart';
import 'package:weatherapps/screens/weather_results_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: Builder(builder: (context) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                  primarySwatch: BlocProvider.of<WeatherCubit>(context)
                      .getThemeColor(BlocProvider.of<WeatherCubit>(context)
                          .weatherModel
                          .conditionText)),
              debugShowCheckedModeBanner: false,
              routes: {
                SearchPage.id: (context) => SearchPage(),
                WeatherResults.id: (context) => const WeatherResults()
              },
              initialRoute: SearchPage.id,
            );
          },
        );
      }),
    );
  }
}
