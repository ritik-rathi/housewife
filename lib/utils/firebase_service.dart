import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_app/screens/todo_list/tasks.dart';

class FirebaseService {
  CollectionReference cRef = Firestore.instance.collection("todo");
  Future<Tasks> getTask(String title, String time, String description) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      DocumentSnapshot ds = await tx.get(cRef.document(title));
      final Tasks task = new Tasks(
          // color: color,
          // completed: completed,
          time: time,
          description: description,
          title: title);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      print(data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Tasks.fromMap(mapData);
    }).catchError((onError) {
      print('$onError');
      return null;
    });
  }

  Stream<QuerySnapshot> getList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshot = cRef.snapshots();
    if (offset != null) {
      snapshot = snapshot.skip(offset);
    }
    if (limit != null) {
      snapshot = snapshot.take(limit);
    }
    return snapshot;
  }
}
