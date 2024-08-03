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
  String _city = "";

  // City list (to avoid errors in the search bar)
  List<String> _cities = [
    'Adana', 'Adıyaman', 'Afyon', 'Ağrı', 'Aksaray', 'Amasya', 'Ankara', 'Antalya', 'Ardahan',
    'Artvin', 'Aydın', 'Balıkesir', 'Bartın', 'Batman', 'Bayburt', 'Bilecik', 'Bingöl', 'Bitlis',
    'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli', 'Diyarbakır', 'Düzce',
    'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane',
    'Hakkari', 'Hatay', 'Iğdır', 'Isparta', 'İstanbul', 'İzmir', 'Kahramanmaraş', 'Karabük',
    'Karaman', 'Kars', 'Kastamonu', 'Kayseri', 'Kırıkkale', 'Kırklareli', 'Kırşehir', 'Kilis',
    'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Mardin', 'Mersin', 'Muğla', 'Muş',
    'Nevşehir', 'Niğde', 'Ordu', 'Osmaniye', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas',
    'Şanlıurfa', 'Şırnak', 'Tekirdağ', 'Tokat', 'Trabzon', 'Tunceli', 'Uşak', 'Van', 'Yalova',
    'Yozgat', 'Zonguldak'
  ];

  // Search weather function by city
  void _search(String city) async {
    WeatherData? weatherData = await _weatherService.fetchWeather(city);
    setState(() {
      _result = weatherData;
      _city = city.toUpperCase(); // Converts city name to uppercase 
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
            SearchBar(              // Search bar
              controller: _controller,
              onSearch: _search,
              cities: _cities,
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              WeatherInfo(result: _result!.result, city: _city),    // Weather info
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
  final Function(String) onSearch;
  final List<String> cities;

  const SearchBar({required this.controller, required this.onSearch, required this.cities, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          return cities.where((String city) {
            return city.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          onSearch(selection);
        },
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
          controller.text = textEditingController.text;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: 'Şehir Ara',
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                color: Colors.grey[400],
                onPressed: () => onSearch(textEditingController.text),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          );
        },
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final List<Result> result;
  final String city;

  const WeatherInfo({required this.result, required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First weather card
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$city\n${"Bugün"}', // Lists today's day first.
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
                      text: _formatDegree(result.first.degree),
                    ),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(4, -40),
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
                  weatherInfoColumn('Nem', '%${result.first.humidity}'), // With percent symbol 
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        // Weather cards for other days
        //Designed like weather apps (usually first day wide, other days are narrow )
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
                      TextSpan(text: _formatDegree(weather.degree)),
                      WidgetSpan(
                        child: Transform.translate(
                          offset: Offset(2, -10),
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

String _formatDegree(String degree) {
  return degree.split('.').first; // Converts Degree to integer 
}

Widget weatherInfoColumn(String label, String value, {bool isHumidity =false}) {
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
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: _formatDegree(value)),
            if(isHumidity)    // Degree symbol was removed from the humidity information
            WidgetSpan(
              child: Transform.translate(
                offset: Offset(2, -6), // Sets position of degree symbol
                child: const Text(
                  '°',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}}