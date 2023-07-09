import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addClub.dart';

class Department {
  final String id;
  final String name;

  Department(this.id, this.name);
}

class DepartmentListPage1 extends StatefulWidget {
  @override
  _DepartmentListPage1State createState() => _DepartmentListPage1State();
}

class _DepartmentListPage1State extends State<DepartmentListPage1> {
  final PageController _pageController = PageController();
  List<Department> departments = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Department').get();

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
          .collection('Department')
          .doc(departmentId)
          .delete();

      setState(() {
        departments.removeWhere((dept) => dept.id == departmentId);
      });
    } catch (e) {
      print('Error deleting Department: $e');
    }
  }

  Future<void> confirmDelete(BuildContext context, String departmentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this Department?'),
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
        title: Text('SOE Department List'),
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
    );
  }
}
