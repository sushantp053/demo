import 'package:demo/util/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Choose Date"),
            CustomCalendar(),
          ],
        ),
      ),
    );
  }
}
