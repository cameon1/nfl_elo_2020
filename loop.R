for(game_i in 1:nrow(nfl_games_20)){
  home_team <- nfl_games_20$home_team[game_i]
  away_team <- nfl_games_20$away_team[game_i]
  
    h_score <- nfl_games_20$game_result[game_i]
    game_week <- nfl_games_20$week[game_i]
    
    home_rating <- nfl_538_week_0_elo_ratings %>%
        filter(team == home_team) %>% 
        arrange(desc(week)) %>%
        slice(1) %>%
        pull (elo_rating)
      
      away_rating <- nfl_538_week_0_elo_ratings %>%
        filter(team == away_team) %>%
        arrange(desc(week)) %>%
        pull (elo_rating)
      
  new_h_rating <- calc_new_rating(home_rating, h_score,
                                 calc_exp_score(home_rating, away_rating))
  
  new_a_rating <- calc_new_rating(away_rating, 1 - h_score,
                                  calc_exp_score(away_rating, home_rating))
                                  
  update_ratings <- tibble(team = c(home_team,away_team),
                           elo_rating = c(new_h_rating,new_a_rating),
                           week = rep(game_week, 2))
  
  nfl_538_week_0_elo_ratings <- nfl_538_week_0_elo_ratings %>%
    bind_rows(update_ratings)
 
}
  


