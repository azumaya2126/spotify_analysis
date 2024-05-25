
pacman::p_load(tidyverse, spotifyr, corrplot)

Sys.setenv(SPOTIFY_CLIENT_ID = "44af3e1025034575bf0766d197d738e6")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "d96455b022fe4e04876162dfab9c66b5")
access_token <- get_spotify_access_token()


gen <- get_artist_audio_features("Gen Hoshino") 

gen <- gen %>% 
  select(album_name, album_release_year, track_name, 
         danceability, energy, loudness, speechiness, acousticness, valence, tempo, duration_ms)

gen %>% 
  select_if(is.numeric) %>% 
  cor() %>% 
  corrplot(tl.col="black",  addCoef.col = "black", method = "shade", shade.col = NA)


gen %>% 
  filter(album_name == "POP VIRUS") %>% 
  summary()

gen %>% 
  filter(album_name == "YELLOW DANCER") %>% 
  summary()

gen %>% 
  arrange(desc(danceability)) %>% 
  head()

gen %>% 
  filter(album_name == "POP VIRUS") %>% 
  arrange(desc(energy))
