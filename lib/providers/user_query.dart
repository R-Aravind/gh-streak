final String dataQuery = """
  query user(\$Username: String!) {
    user(login: \$Username) {
      login
      name
      contributionsCollection {
        hasAnyContributions
        hasAnyRestrictedContributions
        hasActivityInThePast
        contributionYears
        contributionCalendar {
          totalContributions
          weeks {
            firstDay
            contributionDays {
              contributionCount
              weekday
            }
          }
        }
      }
    }
  }
  """;
