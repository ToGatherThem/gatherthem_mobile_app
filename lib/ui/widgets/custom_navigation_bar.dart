import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/lists/collections_list.dart';

class CustomNavigationBar extends StatelessWidget{
  const CustomNavigationBar({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize= 40;
    double addCircleSize= 60;
   return Stack(
     clipBehavior: Clip.none,
     alignment: Alignment.bottomCenter,
     children: [
       Container(
         decoration: BoxDecoration(
             borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
             color: Theme.of(context).bottomAppBarColor
         ),
         height: 50,
         child: Padding(
           padding: EdgeInsets.only(left: width/5, right: width/5),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               InkWell(
                 child: Icon(
                   Icons.home_rounded,
                   size: iconSize,
                   color: Theme.of(context).primaryColor,
                 ),
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const CollectionsList()),
                 );
               },),
               Icon(
                 Icons.person,
                 size: iconSize,
                 color: Theme.of(context).primaryColor,
               )
             ],
           ),
         ),
       ),
       Positioned(
         top: -30,
         child: Container(
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
               color: Theme.of(context).focusColor
           ),
           height: addCircleSize,
           width: addCircleSize,
           child
               : Icon(Icons.add,
             size: iconSize,
             color: Theme.of(context).primaryColor,
           ),
         ),
       ),
     ],
   );
  }

}