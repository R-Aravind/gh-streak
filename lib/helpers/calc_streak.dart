/*
  calcStreak method

  inputs:
  Object : weeks
  - weeks returned by GitHub graphQl API
  i.e. :result.data["user"]["contributionsCollection"]["contributionCalendar"]["weeks"]

  Checks contribution count of each day till

  output: 
  Map<String, int> : result
  
  */
Map<String, int> calcStreak(weeks) {
  List<int> contributions = [];
  int streak = 0, longestStreak = 0, curStreak = 0, contribToday = 0;
  Map<String, int> result = {
    "streak": streak,
    "longestStreak": longestStreak,
    "contribToday": contribToday,
  };

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

    longestStreak = streak;
    i = contributions.length - 1;
    while (i-- > 0) {
      if (contributions[i] > 0) {
        curStreak++;
      } else {
        if (curStreak > longestStreak) longestStreak = curStreak;
        curStreak = 0;
      }
    }

    contribToday = contributions[contributions.length - 1];

    result = {
      "streak": streak,
      "longestStreak": longestStreak,
      "contribToday": contribToday,
    };
  } catch (error) {
    print(error);
  }

  return result;
}
