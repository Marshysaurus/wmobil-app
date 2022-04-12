import 'package:flutter/material.dart';

class LinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final BuildContext context;
  final Function onTap;

  const LinkTile(
      {Key key, this.icon, this.title, this.route, this.context, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () => onTap(context, route),
        child: Column(children: <Widget>[
          ListTile(
            trailing: new Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(74, 74, 74, 1),
              size: 16,
            ),
            title: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: new Icon(
                    icon,
                    color: Color.fromRGBO(74, 74, 74, 1),
                    size: 24,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Color.fromRGBO(74, 74, 74, 1),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Color.fromRGBO(184, 184, 184, 1),
          )
        ]));
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final Color color;

  const ActionTile({Key key, this.icon, this.title, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: onTap,
        child: Column(children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: new Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
          Divider(
            color: Color.fromRGBO(184, 184, 184, 1),
            height: 1,
          )
        ]));
  }
}

class InformationTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const InformationTile({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Row(
          children: <Widget>[
            icon != null
                ? Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: new Icon(
                      icon,
                      color: Color.fromRGBO(74, 74, 74, 1),
                      size: 24,
                    ),
                  )
                : Container(color: Colors.white // This is optional
                    ),
            Text(title,
                style: TextStyle(
                  color: Color.fromRGBO(74, 74, 74, 1),
                ))
          ],
        ),
      ),
      Divider(
        height: 1,
        color: Color.fromRGBO(184, 184, 184, 1),
      )
    ]);
  }
}

class SwitchTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool status;
  final Function onTap;

  const SwitchTile({Key key, this.icon, this.title, this.status, this.onTap})
      : super(key: key);

  @override
  _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        trailing: Switch(
          value: widget.status,
          onChanged: (value) {
            widget.onTap();
            setState(() {

            });
          },
          activeTrackColor: Color.fromRGBO(53, 175, 46, 1),
          activeColor: Color.fromRGBO(53, 175, 46, 1),
        ),
        title: Row(
          children: <Widget>[
            Text(widget.title,
                style: TextStyle(
                  color: Color.fromRGBO(74, 74, 74, 1),
                ))
          ],
        ),
      ),
      Divider(
        height: 1,
        color: Color.fromRGBO(184, 184, 184, 1),
      )
    ]);
  }
}
