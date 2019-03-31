import 'package:flutter/material.dart';
import 'package:hnh/app/components/hhDrawerPresenter.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';

class HhDrawer extends StatelessWidget {
  final String _name;
  final String _email;
  final HHDrawerPresenter _presenter;

  // exception to the rule of clean architecture, not necessarily a violation but unclean:
  // getting the singleton inside a component
  HhDrawer(this._name, this._email): _presenter = HHDrawerPresenter(DataAuthenticationRepository());

  @override
  Widget build(BuildContext context) {
    _presenter.logoutOnComplete = () => _navigate('/login', context);
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
          onTap: () => _navigate('/home', context),
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
          onTap: () => _navigate('/map', context),
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
          onTap: () => _navigate('/events', context),
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
          onTap: () => _navigate('/sponsors', context),
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
          onTap: _logout,
        ),
      ],
    );
  }

  void _navigate(String page, context) {
    Navigator.of(context).pushReplacementNamed(page);
  }

  void _logout() => _presenter.logout();

}
