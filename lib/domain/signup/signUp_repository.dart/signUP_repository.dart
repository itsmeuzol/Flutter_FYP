
import 'package:finalyear/domain/signup/signupApi/signupApi.dart';
import 'package:finalyear/domain/signup/signupModel/signUpModel.dart';

class UserRepository {
  Future<bool> register(SignUpModel user) async {
        return await UserAPI().register(user);

  }
}
