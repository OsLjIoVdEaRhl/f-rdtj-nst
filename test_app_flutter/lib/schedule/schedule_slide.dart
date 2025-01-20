import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:test_app_flutter/models/resor.dart';

final pb = PocketBase('https://fardtjanst-pb.cloud.spetsen.net');

class Schedule extends StatefulWidget {
  final String startpunkt;

  const Schedule({super.key, this.startpunkt = ''});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  Future<List<RecordModel>> resor = pb.collection("resor").getFullList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE7E9FF),
        body: FutureBuilder(
            future: resor,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  // Extracting data from snapshot object
                  final data = snapshot.data as List<RecordModel>;
                  final trips =
                      data.map((r) => Resor.fromJson(r.data)).toList();

                  String formattedDate = trips[0].sjaelvbokadeResor.toString();

                  print(trips[0].sjaelvbokadeResor);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 5,
                          ),
                          SizedBox(
                            height: 18,
                            width: 160,
                            child: Text(' - Schemalagda resor'),
                          ),
                          SizedBox(
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 5,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                            width: 150,
                            child: Text(' - självbokade resor'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2015, 1, 1),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) =>
                                _selectedDay != null &&
                                isSameDay(_selectedDay, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, focusedDay) {
                                for (var trip in trips) {
                                  if (trip.sjaelvbokadeResor
                                          .toString()
                                          .substring(0, 10) ==
                                      day.toString().substring(0, 10)) {
                                    return Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Row(
                                            children: [
                                              // Left half - Red
                                              Expanded(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  width: 5,
                                                ),
                                              ),
                                              // Right half - Transparent
                                              Expanded(
                                                child: Container(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            '${day.day}',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 3,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 31,
                              width: 222,
                              child: Text(
                                'Aktuella sidor',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      for (var trip in trips)
                        if (_selectedDay != null &&
                            trip.sjaelvbokadeResor
                                    .toString()
                                    .substring(0, 10) ==
                                _selectedDay.toString().substring(0, 10))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: Text(
                                      'från:${trip.startpunkt}\nTill:${trip.destination}\nAvgång: kl.${trip.sjaelvbokadeResor.toString().substring(11, 16)}')),
                            ],
                          ),
                    ],
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
