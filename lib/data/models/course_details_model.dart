class CourseDetailsModel {
  int? status;
  String? errorNum;
  String? message;
  CourseDetailsModelCourse? course;

  CourseDetailsModel({this.status, this.errorNum, this.message, this.course});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNum = json['errorNum'];
    message = json['message'];
    course =
    json['course'] != null ? CourseDetailsModelCourse.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorNum'] = errorNum;
    data['message'] = message;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class CourseDetailsModelCourse {
  int? id;
  String? title;
  String? desc;
  int? annualPrice;
  List<String>? tags;
  String? image;
  String? thumbnail;
  String? introVideo;
  int? levelId;
  bool? isEnrolled;
  List<CourseDetailsModelCourseUnits>? units;
  String? levelTitle;

  CourseDetailsModelCourse(
      {this.id,
        this.title,
        this.desc,
        this.annualPrice,
        this.tags,
        this.image,
        this.thumbnail,
        this.introVideo,
        this.levelId,
        this.isEnrolled,
        this.units,
        this.levelTitle});

  CourseDetailsModelCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    annualPrice = json['annual_price'];
    tags = json['tags'].cast<String>();
    image = json['image'];
    thumbnail = json['thumbnail'];
    introVideo = json['intro_video'];
    levelId = json['level_id'];
    isEnrolled = json['is_enrolled'];
    if (json['units'] != null) {
      units = <CourseDetailsModelCourseUnits>[];
      json['units'].forEach((v) {
        units!.add(CourseDetailsModelCourseUnits.fromJson(v));
      });
    }
    levelTitle = json['level_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['annual_price'] = annualPrice;
    data['tags'] = tags;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['intro_video'] = introVideo;
    data['level_id'] = levelId;
    data['is_enrolled'] = isEnrolled;
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    data['level_title'] = levelTitle;
    return data;
  }
}

class CourseDetailsModelCourseUnits  {
  int? id;
  String? title;
  int? order;
  int? courseId;
  List<CourseDetailsModelCourseUnitsLessons>? lessons;
  String? duration;

  CourseDetailsModelCourseUnits (
      {this.id,
        this.title,
        this.order,
        this.courseId,
        this.lessons,
        this.duration});

  CourseDetailsModelCourseUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    order = json['order'];
    courseId = json['course_id'];
    if (json['lessons'] != null) {
      lessons = <CourseDetailsModelCourseUnitsLessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(CourseDetailsModelCourseUnitsLessons.fromJson(v));
      });
    }
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    data['course_id'] = courseId;
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    return data;
  }
}

class CourseDetailsModelCourseUnitsLessons {
  int? id;
  String? title;
  int? isAccessed;
  String? video;
  String? videoDuration;
  String? content;

  CourseDetailsModelCourseUnitsLessons(
      {this.id,
        this.title,
        this.isAccessed,
        this.video,
        this.videoDuration,
        this.content});

  CourseDetailsModelCourseUnitsLessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isAccessed = json['is_accessed'];
    video = json['video'];
    videoDuration = json['video_duration'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['is_accessed'] = isAccessed;
    data['video'] = video;
    data['video_duration'] = videoDuration;
    data['content'] = content;
    return data;
  }
}
