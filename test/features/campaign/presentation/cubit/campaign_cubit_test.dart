import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/entities/campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/domain/usecases/get_active_campaign.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_cubit.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetActiveCampaign extends Mock implements GetActiveCampaign {}

void main() {
  late MockGetActiveCampaign getActiveCampaign;

  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    getActiveCampaign = MockGetActiveCampaign();
  });

  CampaignCubit buildCubit() {
    return CampaignCubit(getActiveCampaign: getActiveCampaign);
  }

  const mockCampaign = Campaign(
    properties: CampaignProperties(
      backgroundColor: '#FFFFFF',
      title: 'Title',
      titleColor: '#000000',
      imageUrl: 'http://example.com/image.png',
    ),
    primaryButton: CampaignButton(
      buttonColor: '#000000',
      textColor: '#FFFFFF',
      text: 'Ok',
      action: CampaignAction(type: 'CLOSE_MODAL', payload: {}),
    ),
    secondaryButton: CampaignButton(
      buttonColor: '#000000',
      textColor: '#FFFFFF',
      text: 'Cancel',
      action: CampaignAction(type: 'CLOSE_MODAL', payload: {}),
    ),
  );

  group('CampaignCubit', () {
    blocTest<CampaignCubit, CampaignState>(
      'emits [CampaignLoading, CampaignLoaded] when campaign is successfully fetched',
      build: () {
        when(() => getActiveCampaign(any())).thenAnswer((_) async => mockCampaign);
        return buildCubit();
      },
      act: (cubit) => cubit.fetchActiveCampaign(),
      expect: () => [
        const CampaignLoading(),
        const CampaignLoaded(mockCampaign),
      ],
    );

    blocTest<CampaignCubit, CampaignState>(
      'emits [CampaignLoading, NoCampaignActive] when getActiveCampaign returns null',
      build: () {
        when(() => getActiveCampaign(any())).thenAnswer((_) async => null);
        return buildCubit();
      },
      act: (cubit) => cubit.fetchActiveCampaign(),
      expect: () => [
        const CampaignLoading(),
        const NoCampaignActive(),
      ],
    );

    blocTest<CampaignCubit, CampaignState>(
      'emits [CampaignLoading, CampaignError] when an error occurs',
      build: () {
        when(() => getActiveCampaign(any())).thenThrow(Exception('Server error'));
        return buildCubit();
      },
      act: (cubit) => cubit.fetchActiveCampaign(),
      expect: () => [
        const CampaignLoading(),
        const CampaignError('Exception: Server error'),
      ],
    );
  });
}
