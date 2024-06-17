import '../../data/models/contact_model.dart';
import '../../data/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<ContactModel> call() async {
    return await repository.getUsers();
  }
}
