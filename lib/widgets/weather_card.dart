import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final String icon;
  final String maxTemp;
  final String minTemp;
  final String humidity;
  final String windSpeed;
  final DateTime lastUpdated;

  const WeatherCard({
    super.key,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.windSpeed,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temperature°C',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      condition,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Image.network(
                  'http:$icon',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            const Divider(color: Colors.white30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(
                  context,
                  WeatherIcons.thermometer,
                  'Max',
                  '$maxTemp°C',
                ),
                _buildWeatherInfo(
                  context,
                  WeatherIcons.thermometer_exterior,
                  'Min',
                  '$minTemp°C',
                ),
                _buildWeatherInfo(
                  context,
                  WeatherIcons.humidity,
                  'Humidity',
                  '$humidity%',
                ),
                _buildWeatherInfo(
                  context,
                  WeatherIcons.strong_wind,
                  'Wind',
                  '${windSpeed}km/h',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Last updated: ${DateFormat('MMM d, y HH:mm').format(lastUpdated)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        BoxedIcon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white70),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
