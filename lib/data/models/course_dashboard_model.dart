class CourseDashboardModel {
  int? status;
  String? errorNum;
  String? message;
  Course? course;

  CourseDashboardModel({this.status, this.errorNum, this.message, this.course});

  CourseDashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNum = json['errorNum'];
    message = json['message'];
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
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

class Course {
  int? id;
  String? title;
  String? desc;
  String? introVideo;
  String? thumbnail;
  String? image;
  List<String>? tags;
  int? levelId;
  bool? isEnrolled;
  int? sessionsLeftNo;
  List<int>? avialableLessonsIDs;
  List<CourseDashboardModelCourseUnits>? units;
  String? levelTitle;

  Course(
      {this.id,
        this.title,
        this.desc,
        this.introVideo,
        this.thumbnail,
        this.image,
        this.tags,
        this.levelId,
        this.isEnrolled,
        this.sessionsLeftNo,
        this.avialableLessonsIDs,
        this.units,
        this.levelTitle});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    introVideo = json['intro_video'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    tags = json['tags'].cast<String>();
    levelId = json['level_id'];
    isEnrolled = json['is_enrolled'];
    sessionsLeftNo = json['sessions_left_no'];
    avialableLessonsIDs = json['avialable_lessons_IDs'].cast<int>();
    if (json['units'] != null) {
      units = <CourseDashboardModelCourseUnits>[];
      json['units'].forEach((v) {
        units!.add(CourseDashboardModelCourseUnits.fromJson(v));
      });
    }
    levelTitle = json['level_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['intro_video'] = introVideo;
    data['thumbnail'] = thumbnail;
    data['image'] = image;
    data['tags'] = tags;
    data['level_id'] = levelId;
    data['is_enrolled'] = isEnrolled;
    data['sessions_left_no'] = sessionsLeftNo;
    data['avialable_lessons_IDs'] = avialableLessonsIDs;
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    data['level_title'] = levelTitle;
    return data;
  }
}

class CourseDashboardModelCourseUnits {
  int? id;
  String? title;
  int? order;
  List<Containers>? containers;
  String? duration;

  CourseDashboardModelCourseUnits({this.id, this.title, this.order, this.containers, this.duration});

  CourseDashboardModelCourseUnits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    order = json['order'];
    if (json['containers'] != null) {
      containers = <Containers>[];
      json['containers'].forEach((v) {
        containers!.add(Containers.fromJson(v));
      });
    }
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['order'] = order;
    if (containers != null) {
      data['containers'] = containers!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    return data;
  }
}

class Containers {
  int? id;
  String? type;
  int? order;
  int? quizId;
  int? lessonId;
  int? unitId;
  Lesson? lesson;
  Quiz? quiz;

  Containers(
      {this.id,
        this.type,
        this.order,
        this.quizId,
        this.lessonId,
        this.unitId,
        this.lesson,
        this.quiz});

  Containers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    order = json['order'];
    quizId = json['quiz_id'];
    lessonId = json['lesson_id'];
    unitId = json['unit_id'];
    lesson =
    json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null;
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['order'] = order;
    data['quiz_id'] = quizId;
    data['lesson_id'] = lessonId;
    data['unit_id'] = unitId;
    if (lesson != null) {
      data['lesson'] = lesson!.toJson();
    }
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    return data;
  }
}

class Lesson {
  int? id;
  String? title;
  int? isAccessed;
  String? video;
  String? videoDuration;
  String? content;

  Lesson(
      {this.id,
        this.title,
        this.isAccessed,
        this.video,
        this.videoDuration,
        this.content});

  Lesson.fromJson(Map<String, dynamic> json) {
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

class Quiz {
  int? id;
  List<String>? codes;
  String? title;
  int? degree;
  String? quizDuration;
  int? validatedWeeks;

  Quiz(
      {this.id,
        this.codes,
        this.title,
        this.degree,
        this.quizDuration,
        this.validatedWeeks});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codes = json['codes'].cast<String>();
    title = json['title'];
    degree = json['degree'];
    quizDuration = json['quiz_duration'];
    validatedWeeks = json['validated_weeks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['codes'] = codes;
    data['title'] = title;
    data['degree'] = degree;
    data['quiz_duration'] = quizDuration;
    data['validated_weeks'] = validatedWeeks;
    return data;
  }
}
