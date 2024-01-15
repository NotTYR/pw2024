import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final PostId;
  final SessionId;
  final RVT;
  final Auth;
  const Post(
      {super.key,
      required this.PostId,
      required this.Auth,
      required this.SessionId,
      required this.RVT});

  @override
  State<Post> createState() =>
      _PostState(this.PostId, this.SessionId, this.RVT, this.Auth);
}

class _PostState extends State<Post> {
  final PostId;
  final SessionId;
  final RVT;
  final Auth;
  _PostState(this.PostId, this.SessionId, this.RVT, this.Auth);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(PostId.toString())),
        body: FutureBuilder(
            future: GetPost(PostId, SessionId, RVT, Auth),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [Text(snapshot.data.toString())],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}

Future<String> GetPost(PostId, SessionId, RVT, Auth) async {
  print("ASP.NET_SessionId=" +
      SessionId +
      "; __RequestVerificationToken=" +
      RVT +
      ";AuthenticationToken=" +
      Auth);
  Uri url = Uri.parse("https://iemb.hci.edu.sg/Board/content/" +
      PostId +
      "?board=1048&isArchived=False");
  http.Response response = await http.post(url, headers: {
    "Cookie": "ASP.NET_SessionId=" +
        SessionId +
        "; __RequestVerificationToken=" +
        RVT +
        ";AuthenticationToken=" +
        Auth,
    "Cache-Control": "max-age=0",
    "Sec-Ch-Ua-Mobile": "?0",
    "Sec-Ch-Ua-Platform": "Windows",
    "Upgrade-Insecure-Requests": "1",
    "Origin": "https://iemb.hci.edu.sg",
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "Sec-Fetch-Site": "same-origin",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-User": "?1",
    "Sec-Fetch-Dest": "document",
    "Referer": "https://iemb.hci.edu.sg/Board/Detail/1048",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "en-US,en;q=0.9",
    "Priority": "u=0, i",
  });
  String html = response.body.substring(0, response.body.indexOf("<\body>"));
  return html;
}
