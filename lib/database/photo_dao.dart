import 'database.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'models.dart';

part 'photo_dao.g.dart';

@UseDao(tables: [Photos, SurveyPoints, SurveyItems, Surveys, Projects])
class PhotoDao extends DatabaseAccessor<CurbWheelDatabase> with _$PhotoDaoMixin {
  PhotoDao(CurbWheelDatabase db) : super(db);

  Future<List<Photo>> getAllPhotos() => select(photos).get();

  Stream<List<PhotoWithParents>> watchAllPhotos() => (select(photos).join([
      leftOuterJoin(
          surveyPoints, surveyPoints.id.equalsExp(photos.pointId)),
      leftOuterJoin(
          surveyItems, surveyItems.id.equalsExp(surveyPoints.surveyItemId)),
      leftOuterJoin(
          surveys, surveys.id.equalsExp(surveyItems.surveyId)),
      leftOuterJoin(
          projects, projects.id.equalsExp(surveys.projectId)),
      ]).watch().map((rows) {
            return rows.map((row) {
              return PhotoWithParents(
                photo: row.readTable(photos),
                point: row.readTable(surveyPoints),
                surveyItem: row.readTable(surveyItems),
                survey: row.readTable(surveys),
                project: row.readTable(projects),
              );
            })
            .toList();
    }));

  Stream<List<PhotoWithParents>> watchPhotosByProject(Project project) => (select(photos).join([
      leftOuterJoin(
          surveyPoints, surveyPoints.id.equalsExp(photos.pointId)),
      leftOuterJoin(
          surveyItems, surveyItems.id.equalsExp(surveyPoints.surveyItemId)),
      leftOuterJoin(
          surveys, surveys.id.equalsExp(surveyItems.surveyId)),
      leftOuterJoin(
          projects, projects.id.equalsExp(surveys.projectId)),
      ]).watch().map((rows) {
            return rows.map((row) {
              return PhotoWithParents(
                photo: row.readTable(photos),
                point: row.readTable(surveyPoints),
                surveyItem: row.readTable(surveyItems),
                survey: row.readTable(surveys),
                project: row.readTable(projects),
              );
            })
            .where((item) => item.project == project)
            .toList();
    }));

  Stream<List<PhotoWithParents>> watchPhotosBySurvey(Survey survey) => (select(photos).join([
      leftOuterJoin(
          surveyPoints, surveyPoints.id.equalsExp(photos.pointId)),
      leftOuterJoin(
          surveyItems, surveyItems.id.equalsExp(surveyPoints.surveyItemId)),
      leftOuterJoin(
          surveys, surveys.id.equalsExp(surveyItems.surveyId)),
      leftOuterJoin(
          projects, projects.id.equalsExp(surveys.projectId)),
      ]).watch().map((rows) {
            return rows.map((row) {
              return PhotoWithParents(
                photo: row.readTable(photos),
                point: row.readTable(surveyPoints),
                surveyItem: row.readTable(surveyItems),
                survey: row.readTable(surveys),
                project: row.readTable(projects),
              );
            })
            .where((item) => item.survey == survey)
            .toList();
    }));

  Stream<List<PhotoWithParents>> watchPhotosBySurveyItem(SurveyItem surveyItem) => (select(photos).join([
      leftOuterJoin(
          surveyPoints, surveyPoints.id.equalsExp(photos.pointId)),
      leftOuterJoin(
          surveyItems, surveyItems.id.equalsExp(surveyPoints.surveyItemId)),
      leftOuterJoin(
          surveys, surveys.id.equalsExp(surveyItems.surveyId)),
      leftOuterJoin(
          projects, projects.id.equalsExp(surveys.projectId)),
      ]).watch().map((rows) {
            return rows.map((row) {
              return PhotoWithParents(
                photo: row.readTable(photos),
                point: row.readTable(surveyPoints),
                surveyItem: row.readTable(surveyItems),
                survey: row.readTable(surveys),
                project: row.readTable(projects),
              );
            })
            .where((item) => item.surveyItem == surveyItem)
            .toList();
    }));

  Future insertPhoto(PhotosCompanion photo) => into(photos).insert(photo);

  Future updatePhoto(Photo photo) => update(photos).replace(photo);

  Future deletePhoto(Photo photo) => delete(photos).delete(photo);
}