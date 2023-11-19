import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required title}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Positioned(child: Align(alignment: Alignment.topRight,
          child: Container(width: 200, height: 200,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.075),blurRadius: 1,spreadRadius: 1,offset: const Offset(0,1))],
                color: Colors.amberAccent ),),),),
        Positioned(top: 170, left: -5,
          child: Align(alignment: Alignment.topRight,
            child: Container(width: 200, height: 200,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.075),blurRadius: 1,spreadRadius: 1,offset: const Offset(0,1))],
                  color: Colors.amberAccent ),),),),

        Positioned(top: 190, left: 20,
          child: Align(alignment: Alignment.topRight,
            child: Container(width: 200, height: 200,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.075),blurRadius: 1,spreadRadius: 1,offset: const Offset(0,1))],
                  color:Colors.amberAccent ),),),),
        const Positioned(top: 100,left: 20,
            child: Text('Welcome',style: TextStyle(fontWeight: FontWeight.w700,fontFamily:'Quicksand',fontSize: 48,color: Colors.white ),))

      ],

    );
  }
}
