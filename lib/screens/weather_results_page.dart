import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/search_page.dart';
import 'package:weatherapps/widgets/loading_animation.dart';
import 'package:weatherapps/widgets/weather_card.dart';

class WeatherResults extends StatelessWidget {
  const WeatherResults({super.key});
  static const String id = "weatherresults";

  @override
  Widget build(BuildContext context) {
    final weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, SearchPage.id),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              try {
                await BlocProvider.of<WeatherCubit>(context)
                    .getCurrentWeather(weatherData.name);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error refreshing weather data'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary.withOpacity(0.6),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const LoadingAnimation();
            }

            if (state is WeatherFailureState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SearchPage.id),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is WeatherSuccessState) {
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          weatherData.name,
                          style:
                              Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last Updated: ${weatherData.localtime}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        WeatherCard(
                          temperature: weatherData.temp,
                          condition: weatherData.conditionText,
                          icon: weatherData.conditionIcon,
                          maxTemp: weatherData.maxTemp,
                          minTemp: weatherData.minTemp,
                          humidity: weatherData.humidity ?? '0',
                          windSpeed: weatherData.windSpeed ?? '0',
                          lastUpdated: DateTime.parse(weatherData.localtime),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
