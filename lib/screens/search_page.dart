// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/weather_results_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  static const String id = "search";
  String? cityName;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Weather Forecast',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Lottie.network(
                        'https://assets3.lottiefiles.com/packages/lf20_kljxfos1.json',
                        height: 200,
                      ),
                      const SizedBox(height: 40),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter a city name";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                cityName = value;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                hintText: "Enter city name",
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                                prefixIcon: const Icon(Icons.location_city,
                                    color: Colors.white),
                                suffixIcon: IconButton(
                                  onPressed: () => _searchWeather(context),
                                  icon: const Icon(Icons.search,
                                      color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => _searchWeather(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              icon: const Icon(Icons.search),
                              label: const Text(
                                "Search Weather",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton.icon(
                        onPressed: () async {
                          // Get current location weather
                          try {
                            await BlocProvider.of<WeatherCubit>(context)
                                .getCurrentLocationWeather();
                            if (context.mounted) {
                              Navigator.pushNamed(context, WeatherResults.id);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Error getting current location weather'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        icon:
                            const Icon(Icons.my_location, color: Colors.white),
                        label: const Text(
                          'Use Current Location',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _searchWeather(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await BlocProvider.of<WeatherCubit>(context)
            .getCurrentWeather(cityName!);
        if (context.mounted) {
          Navigator.pushNamed(context, WeatherResults.id);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error fetching weather data'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
