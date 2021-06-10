
int calcStreak(weeks) {
  /*
  calcStreak method

  inputs:
  - weeks object returned by GitHub graphQl API
  i.e. :result.data["user"]["contributionsCollection"]["contributionCalendar"]["weeks"]

  Checks contribution count of each day till

  output: <int>
  - streak
  */

  List<int> contributions = [];
  int streak = 0;

  try {
    for (int i = 0; i < weeks.length; i++) {
      for (int j = 0; j < weeks[i]["contributionDays"].length; j++) {
        contributions.add(weeks[i]["contributionDays"][j]["contributionCount"]);
      }
    }

    int i = contributions.length - 1;
    while (contributions[i] > 0) {
        streak++;
        i--;
    }
  } catch (_) {

  }
  
  return streak;
}