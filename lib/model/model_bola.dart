class Event {
  final String? strEvent;
  final String? strFilename;
  final String? strLeague;
  final String? strSeason;
  final String? dateEvent;
  final String? strTime;
  final String? strPoster;

  Event({
    this.strEvent,
    this.strFilename,
    this.strLeague,
    this.strSeason,
    this.dateEvent,
    this.strTime,
    this.strPoster,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      strEvent: json['strEvent'] as String?,
      strFilename: json['strFilename'] as String?,
      strLeague: json['strLeague'] as String?,
      strSeason: json['strSeason'] as String?,
      dateEvent: json['dateEvent'] as String?,
      strTime: json['strTime'] as String?,
      strPoster: json['strPoster'] as String?,
    );
  }
}