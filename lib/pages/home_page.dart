import 'package:flutter/material.dart';
import 'package:projet_4/modules/weather_model.dart';
import 'package:projet_4/pages/searche.page.dart';
import 'package:projet_4/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;
  String? cityName;

  void updateUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    cityName = Provider.of<WeatherProvider>(context).cityName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage(
                    updateUi: updateUi,
                  );
                }));
              },
              icon: Icon(
                Icons.search,
              ))
        ],
      ),
      body: weatherData == null
          ? Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'there is no weather start  ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now ',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ))
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    weatherData!.getThemeColor(),
                    weatherData!.getThemeColor()[300]!,
                    weatherData!.getThemeColor()[200]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Spacer(
                    flex: 4,
                  ),
                  Text(
                    cityName!,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      'Updated at :${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()} PM'),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text(
                        '${weatherData!.temp.toInt()}',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Column(
                        children: [
                          Text('max :${weatherData!.maxTemp.toInt()}'),
                          Text('min :${weatherData!.minTemp.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    weatherData!.weatherStateName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(flex: 8),
                ],
              )),
    );
  }
}
