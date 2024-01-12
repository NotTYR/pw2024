import 'package:http/http.dart' as http;

Future fetchIembCookieAndRVT() async {
  final response = await http.get(Uri.parse('https://iemb.hci.edu.sg'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    //cookie and verification token
    return [
      RegExp("(?<=RequestVerificationToken=)(.*)(?=; path)")
          .firstMatch(response.headers.toString())?[0],
      RegExp('(?<=hidden" value=")(.*)(?=")')
          .firstMatch(response.body.toString())?[0]
    ];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
