// ignore_for_file: must_be_immutable, use_build_context_synchronously, prefer_const_constructors_in_immutables, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapps/cubit/weather_cubit.dart';
import 'package:weatherapps/cubit/weather_page_state.dart';
import 'package:weatherapps/screens/weather_results_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  static const String id = "search";
  String? cityName;
  GlobalKey<FormState> formKey = GlobalKey();
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
                    Colors.blueGrey[300]!,
                    Colors.blueGrey[200]!,
                    Colors.blueGrey[100]!,
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your City Name";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          cityName = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              try {
                                await BlocProvider.of<WeatherCubit>(context)
                                    .getCurrentWeather(cityName!);
                              } catch (e) {}
                              Navigator.pushNamed(context, WeatherResults.id);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          label: const Text("Enter your city name :"),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await BlocProvider.of<WeatherCubit>(context)
                                  .getCurrentWeather(cityName!);
                            } catch (e) {}
                            Navigator.pushNamed(context, WeatherResults.id);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: const Center(
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
