import 'package:logger/models/log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Log>> getLogsForDay(DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final response = await _client
        .from('daily_logs')
        .select()
        .gte('created_at', startOfDay.toIso8601String())
        .lt('created_at', endOfDay.toIso8601String())
        .order('start_time', ascending: true);

    return (response as List).map((log) => Log.fromJson(log)).toList();
  }

  Future<void> addLog(Log log) async {
    await _client.from('daily_logs').insert(log.toJson());
  }
}
