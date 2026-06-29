import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/cubit/app_shell_cubit.dart';
import 'package:flutter_pet_adopt/features/app_shell/presentation/pages/app_shell_page.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_cubit.dart';
import 'package:flutter_pet_adopt/features/campaign/presentation/cubit/campaign_state.dart';
import 'package:mocktail/mocktail.dart';

class MockCampaignCubit extends MockCubit<CampaignState> implements CampaignCubit {}

void main() {
  testWidgets('switches tabs through AppShellCubit', (tester) async {
    final mockCampaignCubit = MockCampaignCubit();
    when(() => mockCampaignCubit.state).thenReturn(const CampaignInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AppShellCubit>(
              create: (_) => AppShellCubit(),
            ),
            BlocProvider<CampaignCubit>(
              create: (_) => mockCampaignCubit,
            ),
          ],
          child: const AppShellPage(
            pages: [
              Center(child: Text('Home page')),
              Center(child: Text('Favorites page')),
              Center(child: Text('Add page')),
              Center(child: Text('Profile page')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Home page'), findsOneWidget);

    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('Favorites page'), findsOneWidget);

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Add page'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile page'), findsOneWidget);
  });
}
