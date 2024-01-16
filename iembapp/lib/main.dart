import 'homepage.dart';
import 'processhtml.dart';
import 'keys.dart';
import 'cookienrvt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'gethtml.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchIembCookieAndRVT(),
      builder: (context, cookienrvt) {
        if (cookienrvt.hasData) {
          return FutureBuilder(
              future: GetKeys("221281R", "GSY080131@HCI", cookienrvt.data),
              builder: (context, keys) {
                if (keys.hasData) {
                  return FutureBuilder(
                      future: getHtml(keys.data),
                      builder: (context, html) {
                        if (html.hasData) {
                          List Notifications = ProcessHtml(html.data);
                          return HomePage(
                            Notifications: Notifications,
                            SessionId: keys.data[2],
                            Auth: keys.data[3],
                            RVT: keys.data[1],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                } else {
                  return CircularProgressIndicator();
                }
              });
        } else if (cookienrvt.hasError) {
          // cant help u go helpurself
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
