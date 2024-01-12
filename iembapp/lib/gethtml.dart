import 'package:http/http.dart' as http;

Future getHtml(Keys) async {
  Uri url = Uri.parse('https://iemb.hci.edu.sg/Board/Detail/1048');
  final response = await http.get(url, headers: {
    "Cookie": "ASP.NET_SessionId=" +
        Keys[2] +
        ";__RequestVerificationToken=" +
        Keys[1] +
        ";AuthenticationToken=" +
        Keys[3],
    "Sec-Fetch-Site": "same-origin",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Dest": "document",
    "Referer": "https://iemb.hci.edu.sg/Board/BoardList"
  });
  return response.body;
}
