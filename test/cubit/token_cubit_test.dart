import 'package:bloc_test/bloc_test.dart';
import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/test.dart';

void main() async {
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  group('TokenCubit', () {
    UserCubit? tokenCubit;
    setUp(() {
      tokenCubit = UserCubit();
    });
    tearDown(() {
      tokenCubit!.close();
    });

    test("The initial state of TokenCubit is TokenState(token: null)", () {
      expect(tokenCubit!.state, UserState());
    });

    blocTest(
      'The cubit should emit a TokenState(token: "testValue") when cubit.addToken("testValue") function is called',
      build: () => tokenCubit!,
      act: (UserCubit cubit) => cubit.addToken("testValue"),
      expect: () => [UserState(token: "testValue")],
    );

    blocTest(
      'The cubit should emit a TokenState(token: null) when cubit.removeToken() function is called',
      build: () => tokenCubit!,
      act: (UserCubit cubit) => cubit.removeToken(),
      expect: () => [UserState(token: null)],
    );
  });
}
