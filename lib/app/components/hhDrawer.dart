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
        createPageTile('Home', Icons.home, () => _navigate('/home', context)),
        createPageTile('Navigation', Icons.map, () => _navigate('/map', context)),
        createPageTile('Events', Icons.calendar_today, () => _navigate('/events', context)),
        createPageTile('Local', Icons.hotel),
        Divider(),
        createPageTile('Sponsors', Icons.business, () => _navigate('/sponsors', context)),
        createPageTile('About', Icons.info ),
        Divider(),
        createPageTile('Logout', Icons.exit_to_app, _logout)
      ],
    );
  }

  ListTile createPageTile(String name, IconData icon, [handler]) {
    return ListTile(
          title: Text(
            name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(
            icon,
            size: 22.0,
          ),
          onTap: handler,
        );
  }

  void _navigate(String page, context) {
    Navigator.of(context).pushReplacementNamed(page);
  }

  void _logout() => _presenter.logout();

}
