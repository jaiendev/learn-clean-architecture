import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/login_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/login.dart';
import 'login_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
final LoginParam loginParamSuccess = LoginParam(
  email: 'trung@gmail.com',
  password: '123456',
);

final LoginParam loginParamFailure = LoginParam(
  email: 'abc@gmail.com',
  password: '123456',
);

void main() {
  late MockAuthRepository mockLoginRepository;
  late Login usecase;

  setUp(() {
    mockLoginRepository = MockAuthRepository();
    usecase = Login(mockLoginRepository);
  });

  test(
    'should sign in successful',
    () async {
      when(
        mockLoginRepository.logIn(
          Params(object: loginParamSuccess),
        ),
      ).thenAnswer((_) => Future.value(const Right(true)));
      // act
      final Either<Failures, bool> result = await usecase(
        Params(object: loginParamSuccess),
      );
      // assert
      expect(
        result.isRight(),
        const Right<Failures, bool>(true).isRight(),
      );
      verify(mockLoginRepository.logIn(
        Params(object: loginParamSuccess),
      ));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );

  test(
    'should sign in failure - no Params not LoginValue',
    () async {
      // act
      final Either<Failures, bool> result = await usecase(
        const Params(object: {}),
      );
      // assert
      expect(
        result.isLeft(),
        true,
      );

      verifyNever(
        mockLoginRepository.logIn(
          Params(object: loginParamFailure),
        ),
      );
    },
  );

  test(
    'should sign in failure - password wrong',
    () async {
      when(
        mockLoginRepository.logIn(
          Params(object: loginParamFailure),
        ),
      ).thenAnswer((_) => Future.value(const Right(false)));
      // act
      final Either<Failures, bool> result = await usecase(
        Params(object: loginParamFailure),
      );
      // assert
      expect(
        result.isRight(),
        const Right<Failures, bool>(false).isRight(),
      );
      verify(mockLoginRepository.logIn(
        Params(object: loginParamFailure),
      ));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}
