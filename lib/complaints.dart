import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Complaints', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: ComplaintsList(),
    );
  }
}

class ComplaintsList extends StatelessWidget {
  void _deleteComplaint(String docId) {
    FirebaseFirestore.instance.collection('complaints').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,));
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No complaints available.'));
        }

        // Extract complaint data from the snapshot
        List<Complaint> complaints = snapshot.data!.docs.map((doc) {
          return Complaint.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${complaints[index].hostel ?? 'Unknown Hostel'} - ${complaints[index].room}'),
              subtitle: Text('Bed: ${complaints[index].bed}\n'
                  'Category: ${complaints[index].category ?? 'Uncategorized'}\n'
                  'Description: ${complaints[index].description ?? 'No description'}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteComplaint(complaints[index].docId);
                },
              ),
            );
          },
        );
      },
    );
  }
}

class Complaint {
  final String docId;
  final String? hostel;
  final int? room;
  final int? bed;
  final String? description;
  final String? category;

  Complaint({required this.docId, this.hostel, this.room, this.bed, this.description, this.category});

  factory Complaint.fromMap(String docId, Map<String, dynamic> map) {
    return Complaint(
      docId: docId,
      hostel: map['hostel'],
      room: map['room'],
      bed: map['bed'],
      description: map['description'],
      category: map['category'],
    );
  }
}
