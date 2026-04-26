import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/profile/presentation/pages/profile_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit cubit;

  setUpAll(() {
    registerFallbackValue(const AuthState());
  });

  setUp(() {
    cubit = MockAuthCubit();
    when(() => cubit.logout()).thenAnswer((_) async {});
  });

  Future<void> pumpSubject(WidgetTester tester, AuthState state) {
    when(() => cubit.state).thenReturn(state);
    whenListen(cubit, const Stream<AuthState>.empty(), initialState: state);

    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>.value(
          value: cubit,
          child: const ProfilePage(),
        ),
      ),
    );
  }

  testWidgets('renders authenticated user data and logs out', (tester) async {
    await pumpSubject(
      tester,
      const AuthState(
        status: AuthStatus.authenticated,
        session: sampleAuthSession,
      ),
    );

    expect(find.text('Samuel Santos'), findsOneWidget);
    expect(find.text('samuel@example.com'), findsAtLeastNWidgets(1));
    expect(find.text('token-...7890'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Logout'),
      300,
      scrollable: find.byType(Scrollable),
    );
    await tester.tap(find.text('Logout'));
    await tester.pump();

    verify(() => cubit.logout()).called(1);
  });
}
