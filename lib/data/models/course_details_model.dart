///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class CourseDetailsModelCourseUnitsLessons {
/*
{
  "id": 41,
  "title": "Lesson 32",
  "video": "https://www.youtube.com/watch?v=0yOqxzl-4DI",
  "video_duration": "10:07:30",
  "content": "foo foo foo",
  "created_at": "2023-12-13T11:52:22.000000Z",
  "updated_at": "2023-12-13T11:52:22.000000Z"
}
*/

  int? id;
  String? title;
  String? video;
  String? videoDuration;
  String? content;
  String? createdAt;
  String? updatedAt;

  CourseDetailsModelCourseUnitsLessons({
    this.id,
    this.title,
    this.video,
    this.videoDuration,
    this.content,
    this.createdAt,
    this.updatedAt,
  });
  CourseDetailsModelCourseUnitsLessons.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    video = json['video']?.toString();
    videoDuration = json['video_duration']?.toString();
    content = json['content']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['video'] = video;
    data['video_duration'] = videoDuration;
    data['content'] = content;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CourseDetailsModelCourseUnits {
/*
{
  "id": 41,
  "title": "Unit-40",
  "order": 63,
  "course_id": 3,
  "created_at": "2023-12-13T11:52:22.000000Z",
  "updated_at": "2023-12-13T11:52:22.000000Z",
  "duration": "10:07:30",
  "lessons": [
    {
      "id": 41,
      "title": "Lesson 32",
      "video": "https://www.youtube.com/watch?v=0yOqxzl-4DI",
      "video_duration": "10:07:30",
      "content": "foo foo foo",
      "created_at": "2023-12-13T11:52:22.000000Z",
      "updated_at": "2023-12-13T11:52:22.000000Z"
    }
  ]
}
*/

  int? id;
  String? title;
  int? order;
  int? courseId;
  String? createdAt;
  String? updatedAt;
  String? duration;
  List<CourseDetailsModelCourseUnitsLessons?>? lessons;

  CourseDetailsModelCourseUnits({
    this.id,
    this.title,
    this.order,
    this.courseId,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.lessons,
  });
  CourseDetailsModelCourseUnits.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    order = json['order']?.toInt();
    courseId = json['course_id']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    duration = json['duration']?.toString();
    if (json['lessons'] != null) {
      final v = json['lessons'];
      final arr0 = <CourseDetailsModelCourseUnitsLessons>[];
      v.forEach((v) {
        arr0.add(CourseDetailsModelCourseUnitsLessons.fromJson(v));
      });
      lessons = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    data['course_id'] = courseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['duration'] = duration;
    if (lessons != null) {
      final v = lessons;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['lessons'] = arr0;
    }
    return data;
  }
}

class CourseDetailsModelCourse {
/*
{
  "id": 3,
  "title": "مادة الفيزياء",
  "desc": "يحتوي الكورس علي العديد من التفاصيل والاختبارات المهمة التي تؤهل الطالب لاتقان المادة",
  "annual_price": 600,
  "tags": [
    "الفيزياء"
  ],
  "image": "assets/images/courses/physics.jpg",
  "thumbnail": "assets/images/courses/physics-thumbnail.jpg",
  "level_id": 2,
  "created_at": "0",
  "updated_at": "0",
  "is_enrolled": false,
  "units": [
    {
      "id": 41,
      "title": "Unit-40",
      "order": 63,
      "course_id": 3,
      "created_at": "2023-12-13T11:52:22.000000Z",
      "updated_at": "2023-12-13T11:52:22.000000Z",
      "duration": "10:07:30",
      "lessons": [
        {
          "id": 41,
          "title": "Lesson 32",
          "video": "https://www.youtube.com/watch?v=0yOqxzl-4DI",
          "video_duration": "10:07:30",
          "content": "foo foo foo",
          "created_at": "2023-12-13T11:52:22.000000Z",
          "updated_at": "2023-12-13T11:52:22.000000Z"
        }
      ]
    }
  ],
  "level_title": "الصف الثاني الاعدادي"
}
*/

  int? id;
  String? title;
  String? desc;
  int? annualPrice;
  List<String?>? tags;
  String? image;
  String? thumbnail;
  int? levelId;
  String? createdAt;
  String? updatedAt;
  bool? isEnrolled;
  List<CourseDetailsModelCourseUnits?>? units;
  String? levelTitle;

  CourseDetailsModelCourse({
    this.id,
    this.title,
    this.desc,
    this.annualPrice,
    this.tags,
    this.image,
    this.thumbnail,
    this.levelId,
    this.createdAt,
    this.updatedAt,
    this.isEnrolled,
    this.units,
    this.levelTitle,
  });
  CourseDetailsModelCourse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    desc = json['desc']?.toString();
    annualPrice = json['annual_price']?.toInt();
    if (json['tags'] != null) {
      final v = json['tags'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      tags = arr0;
    }
    image = json['image']?.toString();
    thumbnail = json['thumbnail']?.toString();
    levelId = json['level_id']?.toInt();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    isEnrolled = json['is_enrolled'];
    if (json['units'] != null) {
      final v = json['units'];
      final arr0 = <CourseDetailsModelCourseUnits>[];
      v.forEach((v) {
        arr0.add(CourseDetailsModelCourseUnits.fromJson(v));
      });
      units = arr0;
    }
    levelTitle = json['level_title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['annual_price'] = annualPrice;
    if (tags != null) {
      final v = tags;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['tags'] = arr0;
    }
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['level_id'] = levelId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_enrolled'] = isEnrolled;
    if (units != null) {
      final v = units;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['units'] = arr0;
    }
    data['level_title'] = levelTitle;
    return data;
  }
}

class CourseDetailsModel {
/*
{
  "status": 200,
  "errorNum": "S000",
  "message": "Course detials has been returned successfully",
  "course": {
    "id": 3,
    "title": "مادة الفيزياء",
    "desc": "يحتوي الكورس علي العديد من التفاصيل والاختبارات المهمة التي تؤهل الطالب لاتقان المادة",
    "annual_price": 600,
    "tags": [
      "الفيزياء"
    ],
    "image": "assets/images/courses/physics.jpg",
    "thumbnail": "assets/images/courses/physics-thumbnail.jpg",
    "level_id": 2,
    "created_at": "0",
    "updated_at": "0",
    "is_enrolled": false,
    "units": [
      {
        "id": 41,
        "title": "Unit-40",
        "order": 63,
        "course_id": 3,
        "created_at": "2023-12-13T11:52:22.000000Z",
        "updated_at": "2023-12-13T11:52:22.000000Z",
        "duration": "10:07:30",
        "lessons": [
          {
            "id": 41,
            "title": "Lesson 32",
            "video": "https://www.youtube.com/watch?v=0yOqxzl-4DI",
            "video_duration": "10:07:30",
            "content": "foo foo foo",
            "created_at": "2023-12-13T11:52:22.000000Z",
            "updated_at": "2023-12-13T11:52:22.000000Z"
          }
        ]
      }
    ],
    "level_title": "الصف الثاني الاعدادي"
  }
}
*/

  int? status;
  String? errorNum;
  String? message;
  CourseDetailsModelCourse? course;

  CourseDetailsModel({
    this.status,
    this.errorNum,
    this.message,
    this.course,
  });
  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    errorNum = json['errorNum']?.toString();
    message = json['message']?.toString();
    course = (json['course'] != null) ? CourseDetailsModelCourse.fromJson(json['course']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}