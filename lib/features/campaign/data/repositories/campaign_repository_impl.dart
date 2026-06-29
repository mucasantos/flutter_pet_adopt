import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/campaign/data/datasources/campaign_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/repositories/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  const CampaignRepositoryImpl({
    required this.remoteDataSource,
  });

  final CampaignRemoteDataSource remoteDataSource;

  @override
  Future<Campaign?> getActiveCampaign() async {
    try {
      return await remoteDataSource.getActiveCampaign();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while loading active campaign.'),
      );
    }
  }
}
