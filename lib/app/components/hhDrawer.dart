import 'package:flutter/material.dart';

class HhDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            "Brice Allard",
            style: TextStyle(fontSize: 20.0),
          ),
          accountEmail: Text(
            "briceallard@gmail.com",
            style: TextStyle(fontSize: 12.0),
          ),
          currentAccountPicture: GestureDetector(
            onTap: () => print("This is the current user"),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.briceallard.com/static/img/logo-main.ef47e8a.png'),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/drawer_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop)),
          ),
        ),
        ListTile(
          title: Text(
            "Schedule",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.calendar_today),
        ),
        ListTile(
          title: Text(
            "Registration",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.class_),
        ),
        ListTile(
          title: Text(
            "Lodging",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.hotel),
        ),
        ListTile(
          title: Text(
            "Dining",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.local_dining),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Sponsors",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.people),
        ),
        ListTile(
          title: Text(
            "About",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.info),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.settings),
        ),
        ListTile(
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.exit_to_app),
        ),
      ],
    );
  }
}
