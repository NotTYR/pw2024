List ProcessHtml(html) {
  List Notifications = [];
  String temp = "";
  String temprow = "";
  var anothertemp =
      html.substring(html.indexOf('<tbody>') + 7, html.indexOf('</tbody>'));
  //remove spaces
  for (var i = 0; i < anothertemp.length; i++) {
    if (anothertemp[i] == " ") {
      if (i != 0) {
        if (anothertemp[i - 1] != " ") {
          temp = temp + anothertemp[i];
        }
      }
    } else {
      temp = temp + anothertemp[i];
    }
  }
  temp = temp.replaceAll("\n", "");
  for (var i = 0; i < RegExp("<td>").allMatches(temp).length; i++) {
    Notifications.add(ProcessRow(
        temp.substring(temp.indexOf('<tr>') + 4, temp.indexOf('</tr>'))));
    temp = temp.substring(temp.indexOf('</tr>') + 5).trim();
  }
  return Notifications;
}

List ProcessRow(String temprow) {
  List output = [];
  String row = temprow;
  for (var i = 0; i < 7; i++) {
    var td = RegExp("(<td.*?)>").firstMatch(row)?[0];
    if (td != null) {
      final content =
          row.substring(row.indexOf(td) + td.length, row.indexOf("</td>"));
      output.add(content.trim());
      row = row.substring(row.indexOf("</td>") + 5);
    }
  }
  //tidy up notifications
  //id
  output[6] = RegExp('(?<=<a href="\/Board\/content\/)[0-9]*')
      .firstMatch(output[2].trim())?[0];
  output[1] = RegExp('(?<=tooltip-data=")(.*)(?=">)').firstMatch(output[1])?[0];
  output[2] =
      RegExp('(?<=>)(.*)(?=</a>)').firstMatch(output[2])?[0].toString().trim();
  output[3] = RegExp('(?<=alt=")(.*)(?=".*?\/>)').firstMatch(output[3])?[0];

  //target

  //viewer response idk if i need this but ok
  output[5] = [
    RegExp('(?<=Viewer:)(.*)(?=<)').firstMatch(output[5])?[0].toString().trim(),
    RegExp('(?<=Response:)(.*)').firstMatch(output[5])?[0].toString().trim(),
  ];
  output.removeAt(4);
  return output;
}
