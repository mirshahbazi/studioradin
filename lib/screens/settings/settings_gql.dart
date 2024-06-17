// String deleteUserMutation = """
// mutation DeleteUser{
//   deleteUser
// }
// """;
//
// String meQuery = """
// query Me{
//   me{
//     id
//     name
//   }
// }
// """;
//
// String renameUserMutation = """
// mutation RenameUser(\$name: String){
//   renameUser(name: \$name){
//     error{
//       path
//       message
//     }
//     id
//   }
// }
// """;


String deleteUserMutation = """
mutation DeleteUser(\$userId: uuid!) {
  delete_users(where: {id: {_eq: \$userId}}) {
    affected_rows
  }
}
""";

String meQuery = """
query Me {
  users(where: {id: {_eq: "current_user_id"}}) {
    id
    full_name
  }
}
""";

String renameUserMutation = """
mutation RenameUser(\$id: uuid!, \$name: String!) {
  update_users(where: {id: {_eq: \$id}}, _set: {full_name: \$name}) {
    returning {
      id
      full_name
    }
  }
}
""";
