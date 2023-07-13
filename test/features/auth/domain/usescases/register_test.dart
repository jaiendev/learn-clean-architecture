import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:project_learn_clean_architecture/core/error/failures.dart';
// ignore: depend_on_referenced_packages
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_learn_clean_architecture/core/usecases/usecases.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/entities/register_param.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:project_learn_clean_architecture/features/auth/domain/usecases/register.dart';
import 'register_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
final RegisterParam registerParamSuccess = RegisterParam(
  email: 'trung123@gmail.com',
  password: '123456',
  fullName: 'Trung Dang',
);

final RegisterParam registerParamFailure = RegisterParam(
  email: 'trung@gmail.com',
  password: '123456',
  fullName: 'Trung Dang',
);

void main() {
  late MockAuthRepository mockRegisterRepository;
  late Register usecase;

  setUp(() {
    mockRegisterRepository = MockAuthRepository();
    usecase = Register(mockRegisterRepository);
  });

  test(
    'should register successful',
    () async {
      when(
        mockRegisterRepository.register(
          Params(object: registerParamSuccess),
        ),
      ).thenAnswer((_) => Future.value(const Right(true)));
      // act
      final Either<Failures, bool> result = await usecase(
        Params(object: registerParamSuccess),
      );
      // assert
      expect(
        result.isRight(),
        const Right<Failures, bool>(true).isRight(),
      );
      verify(mockRegisterRepository.register(
        Params(object: registerParamSuccess),
      ));
      verifyNoMoreInteractions(mockRegisterRepository);
    },
  );

  test(
    'should register failure - email exist',
    () async {
      when(
        mockRegisterRepository.register(
          Params(object: registerParamFailure),
        ),
      ).thenAnswer((_) => Future.value(const Right(false)));
      // act
      final Either<Failures, bool> result = await usecase(
        Params(object: registerParamFailure),
      );
      // assert
      expect(
        result.isRight(),
        const Right<Failures, bool>(false).isRight(),
      );
      verify(mockRegisterRepository.register(
        Params(object: registerParamFailure),
      ));
      verifyNoMoreInteractions(mockRegisterRepository);
    },
  );
}
