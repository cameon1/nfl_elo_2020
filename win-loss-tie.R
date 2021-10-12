nfl_games_20 <- nfl_games_20 %>%
  mutate(game_outcome = case_when(
    h_score > a_score ~ 1,
    h_score > a_score ~ 0.5
    TRUE ~ 0
  ))
  
