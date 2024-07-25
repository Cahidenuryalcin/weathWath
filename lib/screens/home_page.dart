import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SearchBar(),
            SizedBox(height: 20),
            WeatherInfo(),
            SizedBox(height: 30),
            WeatherDetails(),
           
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Location',
        hintStyle: TextStyle(color: Colors.grey[400]), // Açık gri renk
        suffixIcon: Icon(Icons.search, color: Colors.grey[400]), // Sağ tarafta açık gri ikon
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}


class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.cloud, size: 100, color: Colors.blue),
          Text(
            'Mumbai',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          
           RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '20',
                ),
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(4, -40),
                    child: Text(
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
            ),),
        ],
      ),
    );
  }
}

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text('TIME', style: TextStyle(color: Colors.grey.shade400),),
            Text(
              '11:25 AM',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
            ),
          ],
        ),
        Column(
          children: [
            Text('UV', style: TextStyle(color: Colors.grey.shade400),),
            Text(
              '4',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
            ),
          ],
        ),
        Column(
          children: [
            Text('% RAIN', style: TextStyle(color: Colors.grey.shade400),),
            Text(
              '58%',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
            ),
          ],
        ),
        Column(
          children: [
            Text('AQ', style: TextStyle(color: Colors.grey.shade400),),
            Text(
              '22',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }
}


