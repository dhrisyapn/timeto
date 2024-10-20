import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  final String id;
  final String name;

  const CoursePage({super.key, required this.id, required this.name});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class Subject {
  final String name;
  final String staff;

  Subject(this.name, this.staff);
}

class _CoursePageState extends State<CoursePage> {
  final TextEditingController _subjectController = TextEditingController();
  String? _selectedStaff;
  final String email = FirebaseAuth.instance.currentUser!.email!;
  List<Map<String, dynamic>> _staffNames = [];
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
      _staffNames = staffData;
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
            height: 290,
            decoration: ShapeDecoration(
              color: const Color(0xFF8CC1A9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add New Subject',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text(
                        'Subject name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
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
                        decoration: InputDecoration(
                          hintText: 'New Subject Name',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: DropdownButtonFormField<String>(
                      value: _selectedStaff,
                      items: _staffNames.map((data) {
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
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                      dropdownColor: const Color(0xFF8CC1A9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      String subjectName = _subjectController.text;
                      if (subjectName.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(email)
                            .collection('course')
                            .doc(widget.id)
                            .collection('subject')
                            .doc(subjectName)
                            .set({
                          'name': subjectName,
                          'staff': _selectedStaff,
                        });
                        _subjectController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: double.infinity,
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

  Widget subject(String subjectName, String staffName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                      subjectName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      staffName,
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
              GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(email)
                        .collection('course')
                        .doc(widget.id)
                        .collection('subject')
                        .doc(subjectName)
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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Timetable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('timetable')
                    .doc(widget.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final courseDoc = snapshot.data!;
                    if (!courseDoc.exists) {
                      return const Center(
                        child: Text(
                          'No timetable available.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    final timetableData =
                        courseDoc.data() as Map<String, dynamic>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Table(
                          border: TableBorder.all(color: Colors.white),
                          children: [
                            TableRow(
                              children: [
                                const TableCell(
                                  child: Center(
                                    child: Text(
                                      'Day',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                for (int i = 1; i <= 4; i++)
                                  TableCell(
                                    child: Center(
                                      child: Text(
                                        'Period $i',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            for (String day in [
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday'
                            ])
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Center(
                                      child: Text(
                                        day.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  for (int period = 1; period <= 4; period++)
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          timetableData[day]?[period - 1]
                                                  ?['subject'] ??
                                              '',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Error loading timetable.',
                        style: TextStyle(color: Colors.white),
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
                height: 20,
              ),
              const Text(
                'Subjects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('course')
                    .doc(widget.id)
                    .collection('subject')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return Column(
                    children: documents
                        .map((DocumentSnapshot document) => subject(
                              document['name'],
                              document['staff'],
                            ))
                        .toList(),
                  );
                },
              ),
              GestureDetector(
                onTap: _showAddSubjectDialog,
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
            ],
          ),
        ),
      ),
    );
  }
}
