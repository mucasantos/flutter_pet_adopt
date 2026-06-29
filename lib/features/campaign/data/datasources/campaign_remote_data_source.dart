import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/campaign/data/models/campaign_model.dart';

abstract class CampaignRemoteDataSource {
  Future<CampaignModel?> getActiveCampaign();
}

class CampaignRemoteDataSourceImpl implements CampaignRemoteDataSource {
  CampaignRemoteDataSourceImpl({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<CampaignModel?> getActiveCampaign() async {
    final response = await apiClient.get(_CampaignEndpoints.activeCampaign);

    try {
      if (response['hasCampaign'] == true && response.containsKey('ui')) {
        final uiData = response['ui'];
        if (uiData is Map) {
          return CampaignModel.fromJson(Map<String, dynamic>.from(uiData));
        }
      }

      if (response.containsKey('campaign')) {
        final campaignData = response['campaign'];
        if (campaignData == null) {
          return null;
        }
        return CampaignModel.fromJson(
            Map<String, dynamic>.from(campaignData as Map));
      }

      if (response.containsKey('properties')) {
        return CampaignModel.fromJson(response);
      }

      return null;
    } on FormatException catch (error) {
      throw ParsingException(message: error.message);
    } catch (_) {
      throw const ParsingException(
          message: 'Unable to parse campaign response.');
    }
  }
}

class _CampaignEndpoints {
  static const activeCampaign = '/campaign/modal';
}
