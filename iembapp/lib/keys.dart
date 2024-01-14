import 'package:http/http.dart' as http;

Future GetKeys(username, pw, cookienrvt) async {
  Uri url = Uri.parse("https://iemb.hci.edu.sg/home/logincheck");
  http.Response Response = await http.post(url,
      headers: {
        "Cookie": "__RequestVerificationToken=" + cookienrvt[0],
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
        "Referer": "https://iemb.hci.edu.sg",
        "Accept-Encoding": "gzip, deflate, br",
        "Accept-Language": "en-US,en;q=0.9",
        "Priority": "u=0, i",
      },
      body: "UserName=" +
          username +
          "&Password=" +
          pw +
          "&__RequestVerificationToken=" +
          cookienrvt[1] +
          "&submitbut=Submit");
  List Keys = [
    cookienrvt[0],
    cookienrvt[1],
    (RegExp("(?<=ASP.NET_SessionId=)(.*)(?=; path=/;)")
        .firstMatch(Response.headers.toString())?[0]),
    RegExp("(?<=AuthenticationToken=)(.*?)(?=;)")
        .firstMatch(Response.headers.toString())?[0],
  ];
  Keys[2] = RegExp("(.*)(?=; path)").firstMatch(Keys[2])?[0];
  return Keys;
}
