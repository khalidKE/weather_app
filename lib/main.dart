import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(WeatherWiseApp());
}

class WeatherWiseApp extends StatelessWidget {
  const WeatherWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeatherWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF3F4F6),
        fontFamily: 'Roboto',
      ),
      home: WeatherDashboard(),
    );
  }
}

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key});

  @override
  _WeatherDashboardState createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Color(0xFFF3F4F6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('WeatherWise',
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black)),
              background: Image.asset(
                'lib/sky.webp',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon:
                    Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                onPressed: () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                LocationDisplay(isDarkMode: isDarkMode),
                SizedBox(height: 16),
                CurrentWeatherDisplay(isDarkMode: isDarkMode),
                SizedBox(height: 24),
                WeatherDetailsDisplay(isDarkMode: isDarkMode),
                SizedBox(height: 24),
                HourlyForecastDisplay(isDarkMode: isDarkMode),
                SizedBox(height: 24),
                WeeklyForecastDisplay(isDarkMode: isDarkMode),
                SizedBox(height: 24),
                WeatherMapDisplay(isDarkMode: isDarkMode),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationDisplay extends StatelessWidget {
  final bool isDarkMode;

  const LocationDisplay({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: Color(0xFF1E90FF)),
        SizedBox(width: 8),
        Text(
          'New York, NY',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}

class CurrentWeatherDisplay extends StatelessWidget {
  final bool isDarkMode;

  const CurrentWeatherDisplay({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Weather',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '75°F',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF4500),
                    ),
                  ),
                  Text(
                    'Feels like 78°F',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
              BoxedIcon(
                WeatherIcons.day_sunny,
                size: 64,
                color: Color(0xFF1E90FF),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Clear sky',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherDetailsDisplay extends StatelessWidget {
  final bool isDarkMode;

  const WeatherDetailsDisplay({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetailItem(
                icon: WeatherIcons.strong_wind,
                title: 'Wind',
                value: '5 mph',
                isDarkMode: isDarkMode,
              ),
              WeatherDetailItem(
                icon: WeatherIcons.humidity,
                title: 'Humidity',
                value: '65%',
                isDarkMode: isDarkMode,
              ),
              WeatherDetailItem(
                icon: WeatherIcons.barometer,
                title: 'Pressure',
                value: '1015 hPa',
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDarkMode;

  const WeatherDetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxedIcon(icon, size: 32, color: Color(0xFF1E90FF)),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}

class HourlyForecastDisplay extends StatelessWidget {
  final bool isDarkMode;

  const HourlyForecastDisplay({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          final hour = DateTime.now().add(Duration(hours: index));
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('ha').format(hour),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                BoxedIcon(
                  WeatherIcons.day_sunny,
                  size: 32,
                  color: Color(0xFF1E90FF),
                ),
                SizedBox(height: 8),
                Text(
                  '${70 + index}°F',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WeeklyForecastDisplay extends StatelessWidget {
  final bool isDarkMode;

  const WeeklyForecastDisplay({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7-Day Forecast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              final day = DateTime.now().add(Duration(days: index));
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEE').format(day),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    BoxedIcon(
                      WeatherIcons.day_sunny,
                      size: 24,
                      color: Color(0xFF1E90FF),
                    ),
                    Text(
                      '${75 - index}°/${65 - index}°',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WeatherMapDisplay extends StatefulWidget {
  final bool isDarkMode;

  const WeatherMapDisplay({super.key, required this.isDarkMode});

  @override
  _WeatherMapDisplayState createState() => _WeatherMapDisplayState();
}

class _WeatherMapDisplayState extends State<WeatherMapDisplay> {
  final String apiKey =
      'YOUR_OPENWEATHERMAP_API_KEY'; // Replace with your actual API key
  String currentLayer = 'temp_new';

  final Map<String, String> layers = {
    'temp_new': 'Temperature',
    'precipitation_new': 'Precipitation',
    'clouds_new': 'Clouds',
    'wind_new': 'Wind',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.isDarkMode ? Colors.grey[800] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weather Map',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                DropdownButton<String>(
                  value: currentLayer,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        currentLayer = newValue;
                      });
                    }
                  },
                  items: layers.entries.map<DropdownMenuItem<String>>((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  dropdownColor:
                      widget.isDarkMode ? Colors.grey[800] : Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FlutterMap(
              options: MapOptions(
                initialCenter:
                    LatLng(40.7128, -74.0060), // New York City coordinates
                initialZoom: 5.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                TileLayer(
                  urlTemplate:
                      'https://tile.openweathermap.org/map/$currentLayer/{z}/{x}/{y}.png?appid=$apiKey',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
