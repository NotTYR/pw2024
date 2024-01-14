import 'history.dart';
import 'post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final SessionId;
  final RVT;
  final Auth;
  final List Notifications;
  const HomePage(
      {super.key,
      required this.Notifications,
      required this.SessionId,
      required this.RVT,
      required this.Auth});

  @override
  State<HomePage> createState() =>
      _HomePageState(this.Notifications, this.SessionId, this.RVT, this.Auth);
}

class _HomePageState extends State<HomePage> {
  final SessionId;
  final RVT;
  final Auth;
  final Notifications;
  _HomePageState(this.Notifications, this.SessionId, this.RVT, this.Auth);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Iemb Client'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.history,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => History())));
              },
            )
          ],
        ),
        body: Container(
            child: NotificationsViewer(
          Notifications: Notifications,
          SessionId: SessionId,
          RVT: RVT,
          Auth: Auth,
        )));
  }
}

class NotificationsViewer extends StatelessWidget {
  final Notifications;
  final SessionId;
  final RVT;
  final Auth;
  const NotificationsViewer(
      {super.key,
      required this.Notifications,
      required this.SessionId,
      required this.RVT,
      this.Auth});

  @override
  Widget build(BuildContext context) {
    if (Notifications.length != 0) {
      return ListView(
        children: List.generate(
            Notifications.length,
            (index) => IembNotification(
                  Notification: Notifications[index],
                  Auth: Auth,
                  RVT: RVT,
                  SessionId: SessionId,
                )),
      );
    } else {
      return Center(child: Text('Looks like you are up to date!'));
    }
  }
}

class IembNotification extends StatelessWidget {
  final SessionId;
  final RVT;
  final Auth;
  final List Notification;
  const IembNotification(
      {super.key,
      required this.Notification,
      required this.Auth,
      required this.RVT,
      required this.SessionId});

  @override
  Widget build(BuildContext context) {
    var priority = Colors.green;
    if (Notification[3] == "Urgent") {
      priority = Colors.red;
    } else if (Notification[3] == "Important") {
      priority = Colors.yellow;
    }
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: priority),
          borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Post(
                          PostId: Notification[5],
                          RVT: RVT,
                          SessionId: SessionId,
                          Auth: Auth,
                        )));
            //view page
          },
          child: (Column(
            children: [
              //name
              Text(
                Notification[1],
              ),
              //time
              Text(
                Notification[0],
              ),
              //title
              Text(
                Notification[2],
                textAlign: TextAlign.left,
              )
            ],
          ))),
    );
  }
}
