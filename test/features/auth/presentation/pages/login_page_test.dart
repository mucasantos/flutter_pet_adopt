import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/pages/login_page.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  late MockAuthCubit cubit;

  setUpAll(() {
    registerFallbackValue(const AuthState());
  });

  setUp(() {
    cubit = MockAuthCubit();
    when(
      () => cubit.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async {});
  });

  Future<void> pumpSubject(WidgetTester tester, AuthState state) {
    when(() => cubit.state).thenReturn(state);
    whenListen(cubit, const Stream<AuthState>.empty(), initialState: state);

    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>.value(
          value: cubit,
          child: const LoginPage(),
        ),
      ),
    );
  }

  testWidgets('validates the form before submitting', (tester) async {
    await pumpSubject(
      tester,
      const AuthState(status: AuthStatus.unauthenticated),
    );

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Informe seu email.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
  });

  testWidgets('submits email and password when form is valid', (tester) async {
    await pumpSubject(
      tester,
      const AuthState(status: AuthStatus.unauthenticated),
    );

    await tester.enterText(
        find.byType(TextFormField).at(0), 'samuel@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');

    await tester.tap(find.text('Login'));
    await tester.pump();

    verify(
      () => cubit.login(
        email: 'samuel@example.com',
        password: '123456',
      ),
    ).called(1);
  });
}
