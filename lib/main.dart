import 'package:contacts_buddy/providers/contact_provider.dart';
import 'package:contacts_buddy/screens/contacts_screen.dart';
import 'package:contacts_buddy/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ContactProvider())],
      child: MaterialApp(
        builder: (context, child) {
          // Set the textScaleFactor to 1.0 to disable system font scaling
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        theme: ThemeData(
          unselectedWidgetColor: appWhite,
          iconTheme: IconThemeData(color: appIconColor),
          scaffoldBackgroundColor: appBgColor,
          textTheme: const TextTheme().copyWith(
            bodyMedium: TextStyle(color: appTextColor),
            displayLarge: TextStyle(color: appTextColor),
            displayMedium: TextStyle(color: appTextColor),
            titleMedium: TextStyle(color: appTextColor),
            titleSmall: TextStyle(color: appTextColor),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: appTextColor),
            hintStyle: TextStyle(color: appTextColor),
          ),
          primaryColor: primaryAppColor,
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: primaryColor, backgroundColor: primaryColor)
              .copyWith(background: appBgColor),
        ),
        debugShowCheckedModeBanner: false,
        home: const ContactsScreen(),
      ),
    );
  }
}
