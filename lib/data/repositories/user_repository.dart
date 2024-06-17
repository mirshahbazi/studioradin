import 'package:hasura_connect/hasura_connect.dart';

import '../../data/graphql/queries.dart';
import '../models/contact_model.dart';

class UserRepository {
  final HasuraConnect connection;
  Snapshot? currentSnapshot;

  UserRepository(this.connection);

  Future<ContactModel> getUsers() async {
    final result = await connection.query(
      getUsersQuery,
    );

    List<dynamic> userData = result['data']['users'];
    var users = ContactModel.fromJson(userData);
    return users;
  }
}
