import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';

abstract class CampaignRepository {
  Future<Campaign?> getActiveCampaign();
}
