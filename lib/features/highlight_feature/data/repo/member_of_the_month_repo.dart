import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/highlight_feature/data/models/hightlight_model.dart';

abstract class MemberOfTheMonthRepo {
  Future<Either<Failure, void>> addMemberOfTheMonth(
    HighlightModel memberOfTheMonthModel,
  );
  Future<Either<Failure, List<HighlightModel>>> getMemberOfTheMonth();

  Future<Either<Failure, void>> deleteMemberOfTheMonth();
}
