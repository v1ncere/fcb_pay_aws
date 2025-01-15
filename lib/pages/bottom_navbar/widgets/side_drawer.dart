import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app.dart';
import '../../home/home.dart';
import '../../../utils/utils.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: BlocSelector<AccountsHomeBloc, AccountsHomeState, String>(
              selector: (state) => state.username,
              builder: (context, username) {
                return Text(username);
              }
            ),
            accountName: const Text('Hello'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color(0xFF00695C),
              child: ClipOval(
                child: Icon(
                  FontAwesomeIcons.faceSmile,
                  color: Colors.white,
                  size: 50
                )
              )
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetString.profileBG)
              )
            )
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.circlePlus),
            title: const Text('Add account'),
            onTap: () => context.pushNamed(RouteName.addAccount) // navigate to add account,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => context.pushNamed(RouteName.settings), // navigate to add account,
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              context.read<AppBloc>().add(LoggedOut());
              context.goNamed(RouteName.login);
            }
          )
        ]
      )
    );
  }
}