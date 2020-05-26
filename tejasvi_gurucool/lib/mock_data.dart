import 'package:tejasvi_gurucool/models/batch_model.dart';
import 'package:tejasvi_gurucool/models/file_model.dart';
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
      batches: <int>[1]
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
      batches: <int>[1],
      );

  static List<ModuleFile> files = <ModuleFile>[
    new ModuleFile(id: 1, name: "item1", path: "https://cdn.pixabay.com/photo/2014/08/26/19/20/document-428331_960_720.jpg", type: FileType.IMAGE_FILE),
    new ModuleFile(id: 3, name: "item3", path: "https://www.youtube.com/watch?v=LKWwDWrWgk4", type: FileType.VIDEO_FILE),
    new ModuleFile(id: 4, name: "item4", path: "https://appletree.or.kr/quick_reference_cards/Unix-Linux/Linux%20Command%20Line%20Cheat%20Sheet.pdf", type: FileType.PDF_FILE)
  ];

  static List<ModuleItem> mathModule1Items1 = <ModuleItem>[
    new ModuleItem(
        id: 1,
        title: "Math Module 1 Item 1",
        description: "Math Module 1 Item 1 Description", file: files[0]),
    new ModuleItem(
        id: 2,
        title: "Math Module 1 Item 2",
        description: "Math Module 1 Item 2 Description", file: files[1]),
    new ModuleItem(
        id: 3,
        title: "Math Module 1 Item 3",
        description: "Math Module 1 Item 3 Description", file: files[2]),
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

  static List<ModuleItem> moduleItems = mathModule1Items1 + mathModule1Items2;

  static List<StudyModule> mathModules = <StudyModule>[
    new StudyModule(
        id: 1,
        title: "Math Module 1",
        shortDescription: "Math Module 1 short Description",
        longDescription: "Math Module 1 Long Description",
        items: <int>[1, 2, 3, 4]),
    new StudyModule(
        id: 2,
        title: "Math Module 2",
        shortDescription: "Math Module 2 short Description",
        longDescription: "Math Module 2 Long Description",
        items: <int>[5, 6, 7, 8]),
    new StudyModule(
        id: 3,
        title: "Math Module 3",
        shortDescription: "Math Module 3 short Description",
        longDescription: "Math Module 3 Long Description"),
  ];

  static List<StudyModule> scienceModules = <StudyModule>[
    new StudyModule(
        id: 4,
        title: "Science Module 1",
        shortDescription: "Science Module 1 short Description",
        longDescription: "Science Module 1 Long Description"),
    new StudyModule(
        id: 5,
        title: "Science Module 2",
        shortDescription: "Science Module 2 short Description",
        longDescription: "Science Module 2 Long Description"),
    new StudyModule(
        id: 6,
        title: "Science Module 3",
        shortDescription: "Science Module 3 short Description",
        longDescription: "Science Module 3 Long Description"),
  ];

  static List<StudyModule> englishModules = <StudyModule>[
    new StudyModule(
        id: 7,
        title: "English Module 1",
        shortDescription: "English Module 1 short Description",
        longDescription: "English Module 1 Long Description"),
    new StudyModule(
        id: 8,
        title: "English Module 2",
        shortDescription: "English Module 2 short Description",
        longDescription: "English Module 2 Long Description"),
    new StudyModule(
        id: 9,
        title: "English Module 3",
        shortDescription: "English Module 3 short Description",
        longDescription: "English Module 3 Long Description"),
  ];

  static List<StudyModule> modules = mathModules + scienceModules + englishModules;

  static List<Subject> subjects = <Subject>[
    new Subject(
        id: 1,
        name: "Maths",
        description: "Maths for 10-A",
        modules: <int>[1, 2, 3]),
    new Subject(
        id: 2,
        name: "Science",
        description: "Science for 10-A",
        modules: <int>[4, 5, 6]),
    new Subject(
        id: 3,
        name: "English",
        description: "English for 10-A",
        modules: <int>[7, 8, 9]),
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
    new Batch(id: 1, name: "10-A", announcements: announcements, subjects: <int>[1, 2, 3]),
  ];
}
