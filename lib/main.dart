import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:note_reminder_getx/noti_page_test.dart';
import 'package:note_reminder_getx/notification_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void initializeAwesomeNotification() {
  AwesomeNotifications().initialize(
    null, // Use the default app icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeAwesomeNotification();
  runApp(const MyApp());

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod,
  );
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      //locale: Locale('vi', ''), // Set default locale to Vietnamese
      locale: const Locale('km', ''), // Khmer
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations
            .delegate, // Remove any unnecessary delegates
        // Additional delegates can be added here if needed
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('vi', ''), // Vietnamese
        Locale('km', ''), // Khmer
      ],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) => const NotificationPage());
          case '/notification-page':
            final Map<String, String> args =
                settings.arguments as Map<String, String>;
            return MaterialPageRoute(
                builder: (context) =>
                    NotiPageTest(title: args['title']!, body: args['body']!));
          default:
            return MaterialPageRoute(
                builder: (context) => const NotificationPage());
        }
      },
      home: const NotificationPage(), // Replace with your initial page
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<Appointment> _appointments;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    // Initialize appointments with some sample data
    _appointments = [
      Appointment(
        startTime: DateTime(2024, 6, 14, 10, 0, 0),
        endTime: DateTime(2024, 6, 14, 11, 0, 0),
        subject: 'Meeting with Client',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime(2024, 6, 14, 14, 0, 0),
        endTime: DateTime(2024, 6, 14, 15, 0, 0),
        subject: 'Team Lunch',
        color: Colors.green,
      ),
      Appointment(
        startTime: DateTime(2024, 6, 14, 16, 0, 0),
        endTime: DateTime(2024, 6, 14, 18, 0, 0),
        subject: 'Design Review',
        color: Colors.orange,
      ),
    ];
  }

  void _scheduleNotification() {
    // Fixed date and time: June 14, 2024, at 2:24 PM
    int year = 2024;
    int month = 6;
    int day = 14;
    int hour = 14;
    int minute = 24;

    // Example of scheduling notification (replace with your logic)
    // AwesomeNotificationHelper.scheduleNotificationWithDateTime(
    //   "Hi",
    //   "This is the first time awesome notification",
    //   year,
    //   month,
    //   day,
    //   hour,
    //   minute,
    //   summary: 'hello every one',
    // );

    // For demo purposes, just print a message
    // ignore: avoid_print
    print('Scheduled notification for $year-$month-$day at $hour:$minute');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Notification'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _scheduleNotification();
              },
              child: const Text('Schedule Test Notification'),
            ),
          ),
          Expanded(
            child: SfCalendar(
              view: CalendarView.day,
              dataSource: _getCalendarDataSource(),
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              viewHeaderStyle: const ViewHeaderStyle(
                dayTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                dateTextStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
                agendaStyle: AgendaStyle(
                  backgroundColor: Colors.grey,
                  dayTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  dateTextStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              todayHighlightColor: Colors.orange,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getCalendarDataSource() {
    return _DataSource(_appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
