abstract class DriveHelper {
  static String thumbnail(String driveId) =>
      'https://drive.google.com/thumbnail?id=$driveId&sz=w1280';

  static String watchUrl(String driveId) =>
      'https://drive.google.com/file/d/$driveId/view';

  static String embedUrl(String driveId) =>
      'https://drive.google.com/file/d/$driveId/preview';
}
