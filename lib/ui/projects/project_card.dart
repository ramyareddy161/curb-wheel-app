import 'package:flutter/material.dart';
import '../../database/database.dart';
import '../map/map_screen.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key key,
    this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.white.withAlpha(100),
        onTap: () {
          Navigator.pushNamed(context, MapScreen.routeName,
              arguments: MapScreenArguments(project)
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text(
                project.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(project.organization),
            ),
          ],
        ),
      ),
    );
  }
}
