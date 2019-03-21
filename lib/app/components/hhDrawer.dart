import 'package:flutter/material.dart';

class HhDrawer extends StatelessWidget {
  final String _name;
  final String _email;

  HhDrawer(this._name, this._email);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            _name,
            style: TextStyle(fontSize: 18.0),
          ),
          accountEmail: Text(
            _email,
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
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "Home",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.map,
            size: 22.0,
          ),
          onTap: () => navigate('/home', context),
        ),
        ListTile(
          title: Text(
            "Navigation",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.map,
            size: 22.0,
          ),
          onTap: () => navigate('/map', context),
        ),
        ListTile(
          title: Text(
            "Events",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.calendar_today,
            size: 22.0,
          ),
          onTap: () => Navigator.of(context).pushReplacementNamed('/events'),
        ),
        ListTile(
          title: Text(
            "Local",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.hotel,
            size: 22.0,
          ),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Sponsors",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.people,
            size: 22.0,
          ),
        ),
        ListTile(
          title: Text(
            "About",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.info,
            size: 22.0,
          ),
        ),
        Divider(),
        ListTile(
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.settings,
            size: 22.0,
          ),
        ),
        ListTile(
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            Icons.exit_to_app,
            size: 22.0,
          ),
        ),
      ],
    );
  }

  void navigate(String page, context) {
    Navigator.of(context).pushReplacementNamed(page);
  }
}
