import 'package:logger/components/log_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({super.key});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  final supabase = Supabase.instance.client;
  List<dynamic> activities = [];

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    final response = await supabase.from('activities').select();
    setState(() {
      activities = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final item = activities[index];
        return LogCard(
          startTime: item['start_time'],
          endTime: item['end_time'],
          title: item['title'],
          description: item['description'],
          effort: item['effort'],
          important: item['important'],
        );
      },
    );
  }
}
