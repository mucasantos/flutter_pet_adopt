import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/usecases/get_active_campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit({
    required this.getActiveCampaign,
  }) : super(const CampaignInitial());

  final GetActiveCampaign getActiveCampaign;

  Future<void> fetchActiveCampaign() async {
    emit(const CampaignLoading());
    try {
      final campaign = await getActiveCampaign(const NoParams());
      if (campaign != null) {
        emit(CampaignLoaded(campaign));
      } else {
        emit(const NoCampaignActive());
      }
    } catch (error) {
      emit(CampaignError(error.toString()));
    }
  }
}
