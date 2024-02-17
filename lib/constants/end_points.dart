/////////////////////////////////////////////////////////////////////////////
const String domain = "https://edumaster.mabdelsamie.online";
const String baseURL = "$domain/api/";

const courses = 'courses';
const authCourses = 'student/courses';
const banners = 'banners';
const levels = 'levels';
const courseDetails = 'courses/course-details';
const courseFiltered = 'student/courses/filtered';
const supportPath = 'support-info';
///////////////////////////////////////////////////////////////////////////



//////////////////////// STUDENT ///////////////////////////////////////////
const userLoginPath = 'auth/student/login';
const studentRegisterPath = 'auth/student/register';
const subscribeToCourseByIdStudentPath = 'auth/student/subscriptions/subscribe-by-id';
const subscribeToCourseByCodeStudentPath = 'auth/student/subscriptions/subscribe-by-code';
const coursePackagesStudentPath = 'auth/student/subscriptions/course-packages';
const enrolledCoursesStudentPath = 'auth/student/courses/enrolled';
const courseDashboardStudentPath = 'auth/student/courses/dashboard';
////////////////////////////////////////////////////////////////////////////




//////////////////////// PARENT ///////////////////////////////////////////
const parentRegisterPath = 'auth/parent/register';
const parentLoginPath = 'auth/parent/login';
const addStudentPath = 'auth/parent/add-student';
const getStudentPath = 'auth/parent/get-parent-students';
////////////////////////////////////////////////////////////////////////////