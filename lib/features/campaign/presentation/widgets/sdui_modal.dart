import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/utils/hex_color.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/utils/sdui_action_handler.dart';

class SduiCampaignModal extends StatelessWidget {
  const SduiCampaignModal({
    super.key,
    required this.campaign,
  });

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    final properties = campaign.properties;
    final primaryBtn = campaign.primaryButton;
    final secondaryBtn = campaign.secondaryButton;

    final actionHandler = SduiActionHandler(context);

    return Dialog(
      backgroundColor: HexColor.fromHex(properties.backgroundColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              properties.title,
              style: TextStyle(
                color: HexColor.fromHex(properties.titleColor),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (properties.imageUrl.isNotEmpty) ...[
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  properties.imageUrl,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor.fromHex(primaryBtn.buttonColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => actionHandler.execute(primaryBtn.action),
              child: Text(
                primaryBtn.text,
                style: TextStyle(color: HexColor.fromHex(primaryBtn.textColor)),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => actionHandler.execute(secondaryBtn.action),
              child: Text(
                secondaryBtn.text,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
