// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/weather_results_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  static const String id = "search";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Search Location'),
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
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter city name',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.search),
                                ),
                                onSubmitted: (value) => _searchWeather(),
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<WeatherCubit>().getCurrentLocationWeather();
                        Navigator.pushNamed(context, WeatherResults.id);
                      },
                      icon: const Icon(Icons.my_location),
                      label: const Text('Use Current Location'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Popular Cities',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildPopularCityCard(
                            context, 
                            'Gaza', 
                            '🇵🇸',
                            'Stand with Palestine',
                            Colors.green,
                          ),
                          _buildPopularCityCard(
                            context, 
                            'Cairo', 
                            '🇪🇬',
                            'City of a Thousand Minarets',
                            Colors.red,
                          ),
                          _buildPopularCityCard(
                            context, 
                            'Mecca', 
                            '🇸🇦',
                            'The Holy City',
                            Colors.green,
                          ),
                          _buildPopularCityCard(
                            context, 
                            'Jerusalem', 
                            '🇵🇸',
                            'City of Peace',
                            Colors.blue,
                          ),
                          _buildPopularCityCard(
                            context, 
                            'Dubai', 
                            '🇦🇪',
                            'City of Gold',
                            Colors.amber,
                          ),
                          _buildPopularCityCard(
                            context, 
                            'Istanbul', 
                            '🇹🇷',
                            'Where East Meets West',
                            Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _searchWeather() async {
    try {
      await BlocProvider.of<WeatherCubit>(context)
          .getCurrentWeather(_searchController.text);
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

  Widget _buildPopularCityCard(BuildContext context, String city, String flag, String description, Color accentColor) {
    return InkWell(
      onTap: () {
        _searchController.text = city;
        _searchWeather();
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accentColor.withOpacity(0.6),
                accentColor.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  flag,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  city,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
