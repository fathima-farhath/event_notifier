import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addClub.dart';

class Department {
  final String id;
  final String name;

  Department(this.id, this.name);
}

class DepartmentListPage extends StatefulWidget {
  @override
  _DepartmentListPageState createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  final PageController _pageController = PageController();
  List<Department> departments = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Club').get();

    final List<Department> fetchedDepartments = [];

    snapshot.docs.forEach((doc) {
      final department = Department(doc.id, doc.data()['dept']);
      fetchedDepartments.add(department);
    });

    setState(() {
      departments = fetchedDepartments;
    });
  }

  Future<void> deleteDepartment(String departmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Club')
          .doc(departmentId)
          .delete();

      setState(() {
        departments.removeWhere((dept) => dept.id == departmentId);
      });
    } catch (e) {
      print('Error deleting Club: $e');
    }
  }

  Future<void> confirmDelete(BuildContext context, String departmentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this Club?'),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () async {
                await deleteDepartment(departmentId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club List'),
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (BuildContext context, int index) {
          final department = departments[index];

          return Card(
            child: ListTile(
              title: Text(department.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  confirmDelete(context, department.id);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => createClub(),
            ),
          );
        },
        child: Icon(Icons.add),
        elevation: 0.2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
