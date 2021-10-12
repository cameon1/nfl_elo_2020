calc_exp_score <- function(home_rating, away_rating) {
     return(1 / (1 + 10^((away_rating - home_rating) / 400)))
   }
 
   calc_new_rating <- function(team_rating, observed_score, exp_score, k_factor = 15) {
      return(team_rating + k_factor * (observed_score - exp_score))
   }

  init_hou_elo  <- nfl_538_week_0_elo_ratings %>%
  filter(team == "Houston Texans") %>%
  pull(elo_rating)

  init_kc_elo <- nfl_538_week_0_elo_ratings %>%
  filter(team == "Kansas City Chiefs") %>%
  pull(elo_rating)

  calc_exp_score(init_hou_elo, init_kc_elo)  
  calc_new_rating(init_hou_elo, 0,
                  calc_exp_score(init_hou_elo,init_kc_elo))  
  