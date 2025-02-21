import 'package:flutter/material.dart';
import 'package:mongo5a/models/group_model.dart';
import 'package:mongo5a/services/mongo_service.dart';

class GroupsScreens extends StatefulWidget {
  const GroupsScreens({super.key});

  @override
  State<GroupsScreens> createState() => _GroupsScreensState();
}

class _GroupsScreensState extends State<GroupsScreens> {
  List<GroupModel> groups = [];

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  void _fetchGroups () async{
    groups = await MongoService().getGroups();
    print('En fetch: $groups');
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Mongo de grupos'),
        ),
        body: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index){
            var group = groups[index];
            return oneTile(group);
          },
        ),
    );
  }

  ListTile oneTile(GroupModel group){
    return ListTile(
      title: Text(group.name),
      subtitle: Text(group.type),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
          onPressed: null,
          icon: Icon(Icons.edit)),
          IconButton(
          onPressed:null,
          icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}