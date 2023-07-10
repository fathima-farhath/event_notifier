import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ScreenCalendar extends StatelessWidget {
  const ScreenCalendar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Appointment> appointments = [];
            DateTime currentDate = DateTime.now();
            
            snapshot.data!.docs.forEach((document) {
              Map<String, dynamic> eventData =
                  document.data() as Map<String, dynamic>;
              Timestamp eventTimestamp = eventData['date'];
              DateTime eventDate = eventTimestamp.toDate();
              DateTime startTime =
                  DateFormat('h:mm a').parse(eventData['time']);
              DateTime endTime =
                  DateFormat('h:mm a').parse(eventData['toTime']);
              
              // Set different colors for old events
              Color appointmentColor = currentDate.isAfter(eventDate)
                  ? Colors.grey // Color for old events
                  : Colors.green; // Default color for new events

              appointments.add(Appointment(
                startTime: DateTime(eventDate.year, eventDate.month, eventDate.day,
                    startTime.hour, startTime.minute),
                endTime: DateTime(eventDate.year, eventDate.month, eventDate.day,
                    endTime.hour, endTime.minute),
                subject: eventData['title'],
                color: appointmentColor,
                startTimeZone: '',
                endTimeZone: '',
              ));
            });

            return SfCalendar(
              view: CalendarView.schedule,
              scheduleViewSettings: ScheduleViewSettings(
                hideEmptyScheduleWeek: true,
                dayHeaderSettings: DayHeaderSettings(
                  dayFormat: 'EEEE',
                  width: 70,
                  dayTextStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.red,
                  ),
                  dateTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.red,
                  ),
                ),
                weekHeaderSettings: WeekHeaderSettings(
                  startDateFormat: 'dd MMM ',
                  endDateFormat: 'dd MMM, yy',
                  height: 50,
                  textAlign: TextAlign.center,
                  backgroundColor: const Color.fromARGB(255, 121, 135, 211),
                  weekTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                monthHeaderSettings: MonthHeaderSettings(
                  monthFormat: 'MMMM, yyyy',
                  height: 75,
                  textAlign: TextAlign.left,
                  backgroundColor: Colors.indigo,
                  monthTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              dataSource: AppointmentDataSource(appointments),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching events'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
