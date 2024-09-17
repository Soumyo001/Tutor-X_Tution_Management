//user
const userIdColumn = 'userId';
const fullNameColumn = 'fullName';
const phoneNumberColumn = 'phoneNumber';
const userEmailColumn = 'email';
const userPasswordColumn = 'password';
const userEducationColumn = 'education';
const userLocationColumn = 'location';
const userTypeColumn = 'type';
const userReportsColumn = 'userReports';
const userResourceListColumn = 'resources';

//tutor
const tutorIdColumn = 'tutorId';
const tutorAvailabilityStatusColumn = 'status';
const tutorMediumOfInterestColumn = 'mediumOfInterest';
const tutorExpectedStudentColumn = 'expectedStudent';
const tutorSubjectOfInterestColumn = 'subjectOfInterest';
const tutorExpectedSalaryColumn = 'expectedSalary';
const tutorProfessionColumn = 'profession';
const tutorVerificationColumn = 'verificationStatus';
const tutorSelfDescriptionColumn = 'tutorSelfDescription';
const tutorBackgroundCheckColumn = 'backgroundChecks';
const tutorSessionsListColumn = 'sessions';
const requestListColumn = 'requests';
const reportListColumn = 'reports';
const messegeListColumn = 'messeges';
const tutorImagePathColumn = 'imagePath';

//student
const studentIdColumn = 'studentId';
const studentFirstNameColumn = 'firstName';
const studentLastNameColumn = 'lastName';
const studentMediumColumn = 'studentMedium';
const studentSelfDescriptionColumn = 'studentSelfDescription';
const studentSessionColumn = 'session';
const studentReviewListColumn = 'studentReviews';
const studentImagePathColumn = 'imagePath';

//resource
const resourceIdColumn = 'resourceId';
const resourceTitleColumn = 'resourceTitle';
const resourceDescriptionColumn = 'resourceDescription';
const resourceUrlColumn = 'resourceUrl';
const resourceUploadDateColumn = 'uploadDate';
const resourceUserColumn = 'user';

//session
const sessionIdColumn = 'sessionId';
const sessionStartDateColumn = 'startDate';
const sessionEndDateColumn = 'endDate';
const sessionDurationColumn = 'duration';
const sessionStatusColumn = 'sessionStatus';
const sessionStudentColumn = 'student';
const sessionTutorColumn = 'tutor';
const sessionPaymentColumn = 'payment';

//payment
const paymentIdColumn = 'paymentId';
const paymentAmountColumn = 'amount';
const paymentDateColumn = 'paymentDate';
const paymentMethodColumn = 'paymentMethod';
const paymentStatusColumn = 'paymentStatus';
const paymentSessionColumn = 'session';

//request
const requestIdColumn = 'requestId';
const requestDateColumn = 'requestDate';
const requestuidFromColumn = 'uidFrom';
const requestuidToColumn = 'uidTo';
const isrequestFromTutorColumn = 'isFromTutor';
const requestStatusColumn = 'status';
const requestStudentColumn = 'student';
const requestTutorColumn = 'tutor';

//report
const reportIdColumn = 'reportId';
const reportUidFromColumn = 'uidFrom';
const reportUidToColumn = 'uidTo';
const reportTextColumn = 'reportText';
const reportDateColumn = 'reportDate';
const reportStudentColumn = 'student';
const reportTutorColumn = 'tutor';

//messege
const messegeIdColumn = 'messegeId';
const messegeTextColumn = 'messegeText';
const messegeUidFromColumn = 'uidFrom';
const messegeUidToColumn = 'uidTo';
const messegeTimeStampColumn = 'timeStamp';

//background_checks
const backgroundCheckIdColumn = 'checkId';
const backgroundTutorBackgroundCheckedTypeColumn = 'backgroundCheckedType';
const backgroundCheckDateColumn = 'checkedDate';
const backgroundCheckResultColumn = 'result';
const backgroundCheckTutorColumn = 'tutor';

//student_review
const studentReviewIdColumn = 'studentReviewId';
const studentReviewRatingColumn = 'rating';
const studentReviewTextColumn = 'reviewText';
const studentReviewDateColumn = 'reviewDate';
const studentReviewStudentColumn = 'student';

//student_post
const studentPostIdColumn = 'studentPostId';
const studentPostFullNameColumn = 'fullName';
const studentPostTutionDaysColumn = 'days';
const studentPostLocationColumn = 'location';
const studentPostDescriptionColumn = 'description';
const studentPostEducationColumn = 'education';
const studentPostStudentMediumColumn = 'studentMedium';
const studentPostStudentTypesColumn = 'studentTypes';
const studentPostSubjectTypesColumn = 'subjectTypes';
const studentPostSalaryColumn = 'salary';

//tutor_post
const tutorPostIdColumn = 'tutorPostId';
const tutorPostFullNameColumn = 'fullName';
const tutorPostBioColumn = 'bio';
const tutorPostLocationColumn = 'location';
const tutorPostDescriptionColumn = 'description';
const tutorPostSubjectOfInterestColumn = 'subjectTypes';
const tutorPostStudentMediumColumn = 'studentMedium';
const tutorPostExpectedStudentColumn = 'studentTypes';

const fireStoreMessegeTableName = 'chat_rooms';
const fireStoreMessegeSubTableName = 'messege';
