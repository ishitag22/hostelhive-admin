import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class notices extends StatefulWidget {
  const notices({super.key});

  @override
  State<notices> createState() => _noticesState();
}
String getCurrentDate() {
  final now = DateTime.now();
  final formattedDate = DateFormat('d MMMM').format(
      now);
  return formattedDate;
}
class _noticesState extends State<notices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.dehaze_outlined),
            color: Colors.black,
            onPressed: (){ Scaffold.of(context).openDrawer();},
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          centerTitle: true,
          title: Text(getCurrentDate(), style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.post_add_rounded),color: Colors.black,)
          ],
        ),
        body: Column(
            children:[
              ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    index= index+1;
                    return Card(
                      margin: EdgeInsets.only(bottom:16),
                      child: ListTile(
                        title: Text('Previous Notice $index'),
                        subtitle: Text('Description of Previous Notice'),
                      ),
                    );
                  }

              )
            ]
        )

    );
  }
}
