import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String, dynamic>> tasksRef = FirebaseFirestore.instance.collection("Tasks");
