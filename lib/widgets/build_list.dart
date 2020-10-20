import 'package:bhoot/models/fluorophores.dart';
import 'package:bhoot/pages/details_page.dart';
import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const BuildList({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> map = snapshot.data.docs.elementAt(index).data();
        Fluorophores fluorophores = Fluorophores.fromMap(map);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
          child: Card(
            color: Colors.white.withOpacity(0.75),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsPage(
                          fluorophores: fluorophores,
                        );
                      },
                    ),
                  );
                },
                title: Text("${fluorophores.name}"),
                subtitle: Text("${fluorophores.safety}"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }
}
