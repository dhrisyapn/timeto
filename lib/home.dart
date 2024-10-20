// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeto/addcourse.dart';
import 'package:timeto/course.dart';
import 'package:timeto/signin.dart';
import 'package:timeto/transitions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _staffController = TextEditingController();
  //get current user email
  final String email = FirebaseAuth.instance.currentUser!.email!;

  Future<void> generateTimetable() async {
    final String email = FirebaseAuth.instance.currentUser!.email!;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    final DocumentReference userDoc = userCollection.doc(email);
    final CollectionReference coursesCollection = userDoc.collection('course');

    // Fetch all courses
    final QuerySnapshot coursesSnapshot = await coursesCollection.get();
    for (var courseDoc in coursesSnapshot.docs) {
      final String courseName = courseDoc['name'];
      final CollectionReference subjectsCollection =
          courseDoc.reference.collection('subject');

      // Fetch all subjects for the course
      final QuerySnapshot subjectsSnapshot = await subjectsCollection.get();
      final List<Map<String, String>> subjects = [];
      for (var subjectDoc in subjectsSnapshot.docs) {
        subjects
            .add({'name': subjectDoc['name'], 'staff': subjectDoc['staff']});
      }

      // Initialize timetable
      final Map<String, List<Map<String, String>>> timetable = {
        'Monday': [],
        'Tuesday': [],
        'Wednesday': [],
        'Thursday': [],
        'Friday': []
      };

      // Generate timetable ensuring no staff clash
      final Set<String> assignedStaff = {};
      for (String day in timetable.keys) {
        for (var subject in subjects) {
          final String staff = subject['staff']!;
          if (!assignedStaff.contains(staff)) {
            timetable[day]!.add({
              'period': 'Period ${timetable[day]!.length + 1}',
              'subject': subject['name']!,
              'staff': staff
            });
            assignedStaff.add(staff);
          }
        }
        assignedStaff.clear(); // Reset assignedStaff for next day
      }

      // Print timetable for the course
      print('Timetable for course: $courseName');
      for (String day in timetable.keys) {
        print('$day:');
        for (var period in timetable[day]!) {
          print(
              '${period['period']}: ${period['subject']} (Staff: ${period['staff']})');
        }
      }
      await userDoc.collection('timetable').doc(courseName).set(timetable);
    }
  }

  void _showAddStaffDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            //height: MediaQuery.of(context).size.height * 0.3,
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
                      'Add New Staff',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Staff name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
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
                        controller: _staffController,
                        decoration: InputDecoration(
                          hintText: 'New Staff Name',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4000000059604645),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      String staffName = _staffController.text;
                      if (staffName.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .collection('staff')
                            .add({
                          'name': staffName,
                        });
                        _staffController.clear();

                        Navigator.of(context).pop();
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
                          'Add staff',
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

  Widget courses(String name, String id, String count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              EnterRoute(
                  page: CoursePage(
                id: id,
                name: name,
              )));
        },
        child: Container(
          width: double.infinity,
          height: 61,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$count subjects',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset('assets/arrow.png', height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget staffs(String name, String id) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(email)
                        .collection('staff')
                        .doc(id)
                        .delete();
                  },
                  child: Image.asset('assets/delete.png', height: 20))
            ],
          ),
        ),
      ),
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
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context,
                  EnterRoute(page: const SigninPage()), (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  await generateTimetable();
                  Navigator.pop(context);
                },
                child: Container(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/timetable.png',
                        height: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Generate Timetable',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                'Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //get name, id, count values from collection users, doc emial, collection course and call courses()
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('course')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length > 0
                        ? FutureBuilder<List<Widget>>(
                            future: Future.wait(snapshot.data!.docs
                                .map<Future<Widget>>((doc) async {
                              String courseId = doc.id;
                              String courseName = doc['name'];
                              QuerySnapshot subjectSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(email)
                                      .collection('course')
                                      .doc(courseId)
                                      .collection('subject')
                                      .get();
                              int subjectCount = subjectSnapshot.size;

                              return courses(courseName, courseId,
                                  subjectCount.toString());
                            }).toList()),
                            builder: (context, futureSnapshot) {
                              if (futureSnapshot.connectionState ==
                                  ConnectionState.done) {
                                return Column(
                                  children: futureSnapshot.data!,
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
                          )
                        : const Center(
                            child: Text(
                              'No Course added',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideRightRoute(page: const AddCourse()));
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF8CC1A9)),
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
                        'Add new course',
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
                height: 20,
              ),
              const Text(
                'Staffs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //get name, course values from collection users, doc emial, collection staff and call staffs()
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('staff')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.length > 0
                        ? Column(
                            children: snapshot.data!.docs.map<Widget>((doc) {
                              return staffs(doc['name'], doc.id);
                            }).toList(),
                          )
                        : const Center(
                            child: Text(
                              'No staff added',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _showAddStaffDialog,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF8CC1A9)),
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
                        'Add new staff',
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
            ],
          ),
        ),
      ),
    );
  }
}
