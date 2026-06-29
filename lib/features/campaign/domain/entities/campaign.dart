import 'package:equatable/equatable.dart';

class Campaign extends Equatable {
  const Campaign({
    required this.properties,
    required this.primaryButton,
    required this.secondaryButton,
  });

  final CampaignProperties properties;
  final CampaignButton primaryButton;
  final CampaignButton secondaryButton;

  @override
  List<Object?> get props => [properties, primaryButton, secondaryButton];
}

class CampaignProperties extends Equatable {
  const CampaignProperties({
    required this.backgroundColor,
    required this.title,
    required this.titleColor,
    required this.imageUrl,
  });

  final String backgroundColor;
  final String title;
  final String titleColor;
  final String imageUrl;

  @override
  List<Object?> get props => [backgroundColor, title, titleColor, imageUrl];
}

class CampaignButton extends Equatable {
  const CampaignButton({
    required this.buttonColor,
    required this.textColor,
    required this.text,
    required this.action,
  });

  final String buttonColor;
  final String textColor;
  final String text;
  final CampaignAction action;

  @override
  List<Object?> get props => [buttonColor, textColor, text, action];
}

class CampaignAction extends Equatable {
  const CampaignAction({
    required this.type,
    required this.payload,
  });

  final String type;
  final Map<String, dynamic> payload;

  @override
  List<Object?> get props => [type, payload];
}
