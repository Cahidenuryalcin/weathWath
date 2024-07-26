import 'package:flutter/material.dart';
import 'package:weathwath_app/models/weatherdata.dart';
import 'package:weathwath_app/services/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  WeatherData? _result;
  final WeatherService _weatherService = WeatherService();

  void _search() async {
    WeatherData? weatherData = await _weatherService.fetchWeather(_controller.text);
    setState(() {
      _result = weatherData;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            SearchBar(
              controller: _controller,
              onSearch: _search,
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              WeatherInfo(result: _result!.result),
            ] else ...[
              const Center(child: Text("Şehir ara ve hava durumunu öğren.", style: TextStyle(fontSize: 18))),
            ],
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchBar({required this.controller, required this.onSearch, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Şehir Ara',
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            color: Colors.grey[400],
            onPressed: onSearch,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final List<Result> result;

  const WeatherInfo({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // İlk hava durumu kartı
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Konumum\n${result.first.day}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.network(result.first.icon, width: 100, height: 100),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: result.first.degree,
                    ),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(4, -40), // const anahtar kelimesi kaldırıldı
                        child: const Text(
                          '°',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                result.first.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  weatherInfoColumn('Min', result.first.min),
                  weatherInfoColumn('Max', result.first.max),
                  weatherInfoColumn('Nem', result.first.humidity),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        // Diğer günlerin hava durumu kartları
        ...result.skip(1).map((weather) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: ListTile(
                leading: Image.network(weather.icon, width: 50, height: 50),
                title: Text(
                  weather.day,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  weather.description,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: weather.degree),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: Offset(2, -10), // const anahtar kelimesi kaldırıldı
                          child: const Text(
                            '°',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
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
        }).toList(),
      ],
    );
  }

  Widget weatherInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
