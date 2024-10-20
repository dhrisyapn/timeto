import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class CreatedSubject {
  final String name;
  final String staff;
  CreatedSubject(this.name, this.staff);
}

class _AddCourseState extends State<AddCourse> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final String email = FirebaseAuth.instance.currentUser!.email!;
  String? _selectedStaff;

  List<CreatedSubject> createdSubjects = [];
  List<Map<String, dynamic>> _staffData = [];
  @override
  void initState() {
    super.initState();
    _fetchStaffData();
  }

  void _fetchStaffData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference staffCollection =
        firestore.collection('users').doc(email).collection('staff');

    QuerySnapshot querySnapshot = await staffCollection.get();

    List<Map<String, dynamic>> staffData = querySnapshot.docs.map((doc) {
      return {
        'name': doc['name'],
      };
    }).toList();

    setState(() {
      _staffData = staffData;
    });
  }

  void _showAddSubjectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 333,
            // height: 290,
            decoration: ShapeDecoration(
              color: const Color(0xFF8CC1A9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      'Add New Subject',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Subject name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    width: 293,
                    height: 50,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _subjectController,
                        decoration: const InputDecoration(
                          hintText: 'New Subject Name',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 293,
                    height: 50,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField<String>(
                        value: _selectedStaff,
                        items: _staffData.map((data) {
                          return DropdownMenuItem<String>(
                            value: data['name'],
                            child: Text('${data['name']} '),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStaff = newValue;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Select Staff',
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: const Color(0xFF8CC1A9),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      String subjectName = _subjectController.text;
                      if (subjectName.isNotEmpty && _selectedStaff != null) {
                        createdSubjects
                            .add(CreatedSubject(subjectName, _selectedStaff!));
                        _subjectController.clear();
                        Navigator.of(context).pop();
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 293,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Add subject',
                          style: TextStyle(
                            color: Color(0xFF2A7A85),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Image.asset(
          'assets/name.png',
          height: 20,
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Add new course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Course name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextField(
                controller: _courseController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'New course name',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4000000059604645),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: const TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 15,
                ),
                cursorColor: const Color(0xFFffffff),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Subjects',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _showAddSubjectDialog,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF8CC1A9)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color(0xFFffffff),
                    ),
                    Text(
                      'Add new Subject',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: createdSubjects.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF8CC1A9)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          createdSubjects[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text(
                              createdSubjects[index].staff,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                createdSubjects.removeAt(index);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // save _courseController.text to collection users doc email subcollection course

                FirebaseFirestore firestore = FirebaseFirestore.instance;

                CollectionReference courseCollection = firestore
                    .collection('users')
                    .doc(email)
                    .collection('course');

                courseCollection.add({
                  'name': _courseController.text,
                }).then((value) {
                  for (var element in createdSubjects) {
                    courseCollection.doc(value.id).collection('subject').add({
                      'name': element.name,
                      'staff': element.staff,
                    });
                  }
                });

                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: ShapeDecoration(
                  color: const Color(0xFF8CC1A9),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Create course',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
