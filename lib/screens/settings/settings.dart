// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:studioradin/screens/settings/settings_gql.dart';
//
// import '../../constants/colors.dart';
// import '../../constants/gradients.dart';
// import '../../state/app_state.dart';
//
// class SettingScreen extends StatelessWidget {
//   final inputController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: appBarComponent(context),
//       body: body(context),
//     );
//   }
//
//   Widget appBarComponent(context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(kToolbarHeight),
//       child: Row(
//               children: <Widget>[
//       Container(
//         width: 90,
//         height: 80,
//         padding: const EdgeInsets.only(right: 20),
//         decoration: const BoxDecoration(
//           gradient: BRIGHT_ORANGE_GRADIENT,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(100),
//           ),
//         ),
//         child: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: WHITE_COLOR,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//               ],
//             ),
//     );
//   }
//
//   Widget body(context) {
//     return ListView(
//       children: <Widget>[headerComponent(), ...settingsListComponent(context)],
//     );
//   }
//
//   Widget headerComponent() {
//     return Container(
//       padding: const EdgeInsets.only(left: 25, top: 30),
//       child: const Text("Settings", style: TextStyle(fontSize: 36)),
//     );
//   }
//
//   List<Widget> settingsListComponent(context) {
//     final appState = Provider.of<AppState>(context);
//
//     return [
//       Container(margin: const EdgeInsets.only(top: 20)),
//       meQueryComponent(context, appState),
//       darkModeComponent(appState),
//       logOutComponent(appState, context),
//       deleteUserMutationComponent(context, appState),
//       aboutAppComponent(context)
//     ];
//   }
//
//   Widget meQueryComponent(context, appState) {
//     return Query(
//       options: QueryOptions(
//
//         document: gql(meQuery),
//             ),
//       builder: (res, {refetch, fetchMore}) {
//         var data = {};
//         if (res.data != null) data = res.data?["me"] ?? {};
//         return renameMutationComponent(context, data, appState);
//       },
//     );
//   }
//
//   Widget renameMutationComponent(context, Map name, appState) {
//     return Mutation(
//       options: MutationOptions(
//         document: gql(renameUserMutation),
//
//       ),
//       builder: (run, res) => displayNameComponent(context, run, name),
//     );
//   }
//
//   Widget displayNameComponent(context, runMutation, name) {
//     return settingsItemComponent(
//       title: "Change your display name",
//       info: "Your name is set to '${name['name'] ?? ""}'",
//       color: const Color(0xFFDE6614),
//       onPressed: () => displayDialog(context, runMutation, rename: true),
//     );
//   }
//
//   Widget darkModeComponent(appState) {
//     return settingsItemComponent(
//       title: "Enable Dark Theme",
//       info: "Switch to dark theme",
//       color: const Color(0xFFDE5215),
//       onPressed: () async {
//         final pref = await SharedPreferences.getInstance();
//         appState.toggleTheme();
//         final dark = appState.currentTheme.brightness == Brightness.dark;
//         await pref.setBool("dark", dark);
//       },
//     );
//   }
//
//   Widget logOutComponent(appState, context) {
//     return settingsItemComponent(
//       title: "Log out",
//       info: "Log out from your account",
//       color: Colors.red,
//       onPressed: () async {
//         await resetApp(appState, context);
//       },
//     );
//   }
//
//   Widget deleteUserMutationComponent(context, appState) {
//     return Mutation(
//       options: MutationOptions(
//         document: gql(deleteUserMutation),
//         onCompleted: (result) async {
//           if (result != null) {
//             await resetApp(appState, context);
//           }
//         },
//       ),
//       builder: (runMutation, result) {
//         return deleteItemComponent(context, runMutation);
//       },
//     );
//   }
//
//   Future<void> resetApp(appState, context) async {
//     final pref = await SharedPreferences.getInstance();
//     await pref.clear();
//     appState.setToken("");
//     appState.setLight();
//     // Navigator.of(context).pushAndRemoveUntil(
//     //     MaterialPageRoute(builder: (context) => AuthScreen()), (val) => false);
//   }
//
//   Widget deleteItemComponent(context, RunMutation runMutation) {
//     return settingsItemComponent(
//       title: "Delete Account",
//       info: "Delete your account permanently",
//       color: Colors.red.shade700,
//       onPressed: () => displayDialog(context, runMutation),
//     );
//   }
//
//   Widget aboutAppComponent(context) {
//     return settingsItemComponent(
//       title: "About app",
//       info: "View info about the app",
//       color: const Color(0xFF2A99A0),
//       onPressed: () {
//         // Navigator.push(
//         //     context, MaterialPageRoute(builder: (context) => AboutScreen()));
//       },
//     );
//   }
//
//   Widget settingsItemComponent(
//       {String? title, String? info, Color? color, VoidCallback? onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         padding: const EdgeInsets.only(left: 25, right: 25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(margin: const EdgeInsets.only(top: 20)),
//             Text(
//               title!,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Container(margin: const EdgeInsets.only(top: 5)),
//             Text(info!, style: const TextStyle(fontFamily: 'Roboto', fontSize: 14)),
//             Container(margin: const EdgeInsets.only(top: 20)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   displayDialog(
//     BuildContext context,
//     RunMutation runMutation, {
//     bool rename = false,
//   }) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 1),
//           titlePadding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 rename
//                     ? 'Enter a name'
//                     : 'Do you really wanna delete your accout?',
//                 style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//               ),
//               if (rename)
//                 TextField(
//                   scrollPadding: const EdgeInsets.all(0),
//                   controller: inputController,
//                   decoration: const InputDecoration(
//                     hintText: "Name",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   ElevatedButton(
//                     child: const Text('CANCEL'),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//
//
//                   Container(margin: const EdgeInsets.only(left: 15)),
//                   ElevatedButton(
//                     // textColor: PALE_ORANGE,
//                     child: const Text("OK"),
//                     onPressed: () {
//                       final name = inputController.text;
//                       if (name != "" || !rename) runMutation({"name": name});
//                       Navigator.pop(context);
//                     },
//                   )
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
