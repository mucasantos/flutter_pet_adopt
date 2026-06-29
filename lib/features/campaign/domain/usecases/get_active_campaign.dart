import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/repositories/campaign_repository.dart';

class GetActiveCampaign implements UseCase<Campaign?, NoParams> {
  const GetActiveCampaign(this.repository);

  final CampaignRepository repository;

  @override
  Future<Campaign?> call(NoParams params) async {
    return repository.getActiveCampaign();
  }
}
