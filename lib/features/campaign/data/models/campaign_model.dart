import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';

class CampaignModel extends Campaign {
  const CampaignModel({
    required super.properties,
    required super.primaryButton,
    required super.secondaryButton,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    final propertiesJson = json['properties'];
    final primaryBtnJson = json['primaryButton'];
    final secondaryBtnJson = json['secondaryButton'];

    if (propertiesJson is! Map || primaryBtnJson is! Map || secondaryBtnJson is! Map) {
      throw const FormatException('Invalid campaign layout properties');
    }

    return CampaignModel(
      properties: CampaignPropertiesModel.fromJson(Map<String, dynamic>.from(propertiesJson)),
      primaryButton: CampaignButtonModel.fromJson(Map<String, dynamic>.from(primaryBtnJson)),
      secondaryButton: CampaignButtonModel.fromJson(Map<String, dynamic>.from(secondaryBtnJson)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'properties': (properties as CampaignPropertiesModel).toJson(),
      'primaryButton': (primaryButton as CampaignButtonModel).toJson(),
      'secondaryButton': (secondaryButton as CampaignButtonModel).toJson(),
    };
  }
}

class CampaignPropertiesModel extends CampaignProperties {
  const CampaignPropertiesModel({
    required super.backgroundColor,
    required super.title,
    required super.titleColor,
    required super.imageUrl,
  });

  factory CampaignPropertiesModel.fromJson(Map<String, dynamic> json) {
    return CampaignPropertiesModel(
      backgroundColor: json['backgroundColor'] as String? ?? '#FFFFFF',
      title: json['title'] as String? ?? '',
      titleColor: json['titleColor'] as String? ?? '#000000',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backgroundColor': backgroundColor,
      'title': title,
      'titleColor': titleColor,
      'imageUrl': imageUrl,
    };
  }
}

class CampaignButtonModel extends CampaignButton {
  const CampaignButtonModel({
    required super.buttonColor,
    required super.textColor,
    required super.text,
    required super.action,
  });

  factory CampaignButtonModel.fromJson(Map<String, dynamic> json) {
    final actionJson = json['action'];
    return CampaignButtonModel(
      buttonColor: json['buttonColor'] as String? ?? '#000000',
      textColor: json['textColor'] as String? ?? '#FFFFFF',
      text: json['text'] as String? ?? '',
      action: CampaignActionModel.fromJson(
        actionJson is Map ? Map<String, dynamic>.from(actionJson) : const {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buttonColor': buttonColor,
      'textColor': textColor,
      'text': text,
      'action': (action as CampaignActionModel).toJson(),
    };
  }
}

class CampaignActionModel extends CampaignAction {
  const CampaignActionModel({
    required super.type,
    required super.payload,
  });

  factory CampaignActionModel.fromJson(Map<String, dynamic> json) {
    return CampaignActionModel(
      type: json['type'] as String? ?? 'CLOSE_MODAL',
      payload: Map<String, dynamic>.from(json['payload'] ?? const {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'payload': payload,
    };
  }
}
