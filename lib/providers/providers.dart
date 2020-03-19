import 'package:decisive_app/core/datastore/profile_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProfileRepository>(
    create: (context) => ProfileRepository(),
  ),
];
