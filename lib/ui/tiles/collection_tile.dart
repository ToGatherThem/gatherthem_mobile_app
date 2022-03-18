import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_bool.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_int.dart';
import 'package:gatherthem_mobile_app/models/collection.dart';

class CollectionTile extends StatelessWidget {
  final String title;

  const CollectionTile({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocBool blocRound = BlocBool(initValue: false);
    bool swapped = false;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  StreamBuilder<bool>(
                    stream: blocRound.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      if(snapshot.data!){
                        return const Icon(
                          Icons.abc_rounded,
                          size: 55,
                        );
                      }else {
                        return const Icon(

                          Icons.photo,
                          size: 55,
                        );
                      }
                    }
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Collection(title: 'Im a teapot')),
                );
                // swapped = !swapped;
                // blocRound.setBool(swapped);
              }),
        ),
      ),
    );
  }

  Widget returnCollection(String title) {
    print("I'm a teapot");
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Collection(
        title: "I'm a teapot",
      ),
    );
  }
}
