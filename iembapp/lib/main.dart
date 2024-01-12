import 'keys.dart';
import 'cookienrvt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'gethtml.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

void main() {
  runApp(MyApp());
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
              future: GetKeys("221496R", "YouRen1!", cookienrvt.data),
              builder: (context, keys) {
                if (keys.hasData) {
                  return FutureBuilder(
                      future: getHtml(keys.data),
                      builder: (context, html) {
                        List Notifications = ProcessHtml(html.data);
                        return Text(
                          "notifications",
                          textDirection: TextDirection.ltr,
                        );
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

List ProcessHtml(html) {
  print(html.length);
  List Notifications = [];
  String temp =
      html.substring(html.indexOf('<tbody>') + 7, html.indexOf('</tbody>'));
  String temprow =
      temp.substring(temp.indexOf('<tr>') + 4, temp.indexOf('</tr>'));
  // process row
  List items = [];
  //print(temprow);
  items.add(
      temprow.substring(temprow.indexOf('<td>') + 4, temprow.indexOf('</td>')));
  temprow = temprow.substring(temprow.indexOf('</td>') + 5);
  items.add(
      temprow.substring(temprow.indexOf('<td>') + 4, temprow.indexOf('</td>')));
  temprow = temprow.substring(temprow.indexOf('</td>') + 5);
  temp = temp.substring(temp.indexOf('</tr>'));

  return Notifications;
}
