import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/screens/search_page.dart';

class WeatherResults extends StatelessWidget {
  const WeatherResults({super.key});
  static const String id = "weatherresults";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchPage.id);
                },
                icon: const Icon(Icons.search_outlined, size: 30)),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              BlocProvider.of<WeatherCubit>(context).getThemeColor(
                  BlocProvider.of<WeatherCubit>(context)
                      .weatherModel
                      .conditionText)[400]!,
              BlocProvider.of<WeatherCubit>(context).getThemeColor(
                  BlocProvider.of<WeatherCubit>(context)
                      .weatherModel
                      .conditionText)[300]!,
              Colors.white
            ])),
        child: Column(
          children: [
            const Spacer(
              flex: 5,
            ),
            Column(
              children: [
                Text(
                  BlocProvider.of<WeatherCubit>(context).weatherModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 32),
                ),
                Text(
                  BlocProvider.of<WeatherCubit>(context)
                      .weatherModel
                      .localtime
                      .replaceRange(0, 10, "updated at"),
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Image.network(
                  "http:${BlocProvider.of<WeatherCubit>(context).weatherModel.conditionIcon}",
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(BlocProvider.of<WeatherCubit>(context).weatherModel.temp,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 32)),
                const Spacer(
                  flex: 1,
                ),
                Column(
                  children: [
                    Text(
                        "max temp: ${BlocProvider.of<WeatherCubit>(context).weatherModel.maxTemp}",
                        style: const TextStyle(fontSize: 16)),
                    Text(
                        "min temp: ${BlocProvider.of<WeatherCubit>(context).weatherModel.minTemp}",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              BlocProvider.of<WeatherCubit>(context).weatherModel.conditionText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
