import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/search_page.dart';
import 'package:weatherapps/widgets/loading_animation.dart';
import 'package:weatherapps/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Get current location weather when screen loads
    BlocProvider.of<WeatherCubit>(context).getCurrentLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<WeatherCubit>(context).getCurrentLocationWeather();
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
                      'Error getting weather data',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<WeatherCubit>(context)
                            .getCurrentLocationWeather();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is WeatherSuccessState) {
              final weatherData =
                  BlocProvider.of<WeatherCubit>(context).weatherModel;
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Current Location Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              weatherData.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last Updated: ${weatherData.localtime}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // Main Weather Card
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
                        const SizedBox(height: 24),
                        // Additional Features Section
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: [
                            _buildFeatureCard(
                              context,
                              'Humidity',
                              '${weatherData.humidity ?? "0"}%',
                              Icons.water_drop,
                              Colors.blue,
                            ),
                            _buildFeatureCard(
                              context,
                              'Wind Speed',
                              '${weatherData.windSpeed ?? "0"} km/h',
                              Icons.air,
                              Colors.teal,
                            ),
                            _buildFeatureCard(
                              context,
                              'Feels Like',
                              '${weatherData.feelsLike ?? weatherData.temp}°',
                              Icons.thermostat,
                              Colors.orange,
                            ),
                            _buildFeatureCard(
                              context,
                              'UV Index',
                              weatherData.uv ?? "0",
                              Icons.wb_sunny,
                              Colors.amber,
                            ),
                          ],
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

  Widget _buildFeatureCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
