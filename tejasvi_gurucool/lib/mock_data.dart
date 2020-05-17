import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/module_item.dart';
import 'package:tejasvi_gurucool/models/study_module_model.dart';
import 'package:tejasvi_gurucool/models/subject_model.dart';
import 'package:tejasvi_gurucool/models/user_model.dart';

import 'models/announcement_model.dart';

class Mock {
  static User user = new User(
      id: 1,
      firstName: "Brijesh",
      lastName: "Patel",
      middleName: "Jayendrabhai",
      birthDate: new DateTime(1995, 5, 28),
      phoneNo: 5877001874,
      username: "b.patel28",
      email: "b.patel9528@gmail.com",
      password: "1234567",
      createdOn: DateTime.now().subtract(new Duration(days: 5)),
      updatedOn: DateTime.now(),
      batches: batches
      );

  static User user2 = new User(
      id: 2,
      firstName: "Nitin",
      lastName: "Patel",
      middleName: "ManiBhai",
      birthDate: new DateTime(1978, 7, 20),
      phoneNo: 5877001874,
      username: "n.patel20",
      email: "n.patel20@gmail.com",
      password: "789123456",
      createdOn: DateTime.now().subtract(new Duration(days: 5)),
      updatedOn: DateTime.now(),
      batches: batches,
      );

  static List<ModuleItem> mathModule1Items1 = <ModuleItem>[
    new ModuleItem(
        id: 1,
        title: "Math Module 1 Item 1",
        description: "Math Module 1 Item 1 Description"),
    new ModuleItem(
        id: 2,
        title: "Math Module 1 Item 2",
        description: "Math Module 1 Item 2 Description"),
    new ModuleItem(
        id: 3,
        title: "Math Module 1 Item 3",
        description: "Math Module 1 Item 3 Description"),
    new ModuleItem(
        id: 4,
        title: "Math Module 1 Item 4",
        description: "Math Module 1 Item 4 Description"),
  ];

  static List<ModuleItem> mathModule1Items2 = <ModuleItem>[
    new ModuleItem(
        id: 5,
        title: "Math Module 1 Item 5",
        description: "Math Module 1 Item 1 Description"),
    new ModuleItem(
        id: 6,
        title: "Math Module 1 Item 6",
        description: "Math Module 1 Item 2 Description"),
    new ModuleItem(
        id: 7,
        title: "Math Module 1 Item 7",
        description: "Math Module 1 Item 3 Description"),
    new ModuleItem(
        id: 8,
        title: "Math Module 1 Item 8",
        description: "Math Module 1 Item 4 Description"),
  ];

  static List<StudyModule> mathModules = <StudyModule>[
    new StudyModule(
        id: 1,
        title: "Math Module 1",
        shortDescription: "Math Module 1 short Description",
        longDescription: "Math Module 1 Long Description",
        items: mathModule1Items1),
    new StudyModule(
        id: 2,
        title: "Math Module 2",
        shortDescription: "Math Module 2 short Description",
        longDescription: "Math Module 2 Long Description",
        items: mathModule1Items2),
    new StudyModule(
        id: 3,
        title: "Math Module 3",
        shortDescription: "Math Module 3 short Description",
        longDescription: "Math Module 3 Long Description"),
  ];

  static List<StudyModule> scienceModules = <StudyModule>[
    new StudyModule(
        id: 4,
        title: "Math Module 1",
        shortDescription: "Math Module 1 short Description",
        longDescription: "Math Module 1 Long Description"),
    new StudyModule(
        id: 5,
        title: "Math Module 2",
        shortDescription: "Math Module 2 short Description",
        longDescription: "Math Module 2 Long Description"),
    new StudyModule(
        id: 6,
        title: "Math Module 3",
        shortDescription: "Math Module 3 short Description",
        longDescription: "Math Module 3 Long Description"),
  ];

  static List<StudyModule> englishModules = <StudyModule>[
    new StudyModule(
        id: 7,
        title: "English Module 1",
        shortDescription: "Math Module 1 short Description",
        longDescription: "Math Module 1 Long Description"),
    new StudyModule(
        id: 8,
        title: "English Module 2",
        shortDescription: "Math Module 2 short Description",
        longDescription: "Math Module 2 Long Description"),
    new StudyModule(
        id: 9,
        title: "English Module 3",
        shortDescription: "Math Module 3 short Description",
        longDescription: "Math Module 3 Long Description"),
  ];

  static List<Subject> subjects = <Subject>[
    new Subject(
        id: 1,
        name: "Maths",
        description: "Maths for 10-A",
        modules: mathModules),
    new Subject(
        id: 1,
        name: "Science",
        description: "Science for 10-A",
        modules: scienceModules),
    new Subject(
        id: 1,
        name: "English",
        description: "English for 10-A",
        modules: englishModules),
  ];

  static List<Announcement> announcements = <Announcement>[
    // new Announcement(
    //     id: 1, text: "Test 1", sender: user, timestamp: new DateTime.now()),
    // new Announcement(
    //     id: 2, text: "Test 2", sender: user2, timestamp: new DateTime.now()),
    // new Announcement(
    //     id: 3, text: "Test 3", sender: user, timestamp: new DateTime.now()),
    // new Announcement(
    //     id: 4, text: "Test 4", sender: user2, timestamp: new DateTime.now())
  ];

  static List<Batch> batches = <Batch>[
    new Batch(id: 1, name: "10-A", announcements: announcements, subjects: subjects),
    new Batch(id: 1, name: "10-B", announcements: announcements, subjects: subjects),
    new Batch(id: 1, name: "10-C", announcements: announcements, subjects: subjects)
  ];
}
