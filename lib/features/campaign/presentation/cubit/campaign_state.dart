import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object?> get props => [];
}

class CampaignInitial extends CampaignState {
  const CampaignInitial();
}

class CampaignLoading extends CampaignState {
  const CampaignLoading();
}

class CampaignLoaded extends CampaignState {
  const CampaignLoaded(this.campaign);

  final Campaign campaign;

  @override
  List<Object?> get props => [campaign];
}

class NoCampaignActive extends CampaignState {
  const NoCampaignActive();
}

class CampaignError extends CampaignState {
  const CampaignError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
