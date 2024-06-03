
pacman::p_load(tidyverse, spotifyr, corrplot)

Sys.setenv(SPOTIFY_CLIENT_ID = "44af3e1025034575bf0766d197d738e6")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "d96455b022fe4e04876162dfab9c66b5")
access_token <- get_spotify_access_token()


gen <- get_artist_audio_features("Gen Hoshino") 
gen <- gen %>% 
  select(album_name, album_release_year, track_name, 
         danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence,
         tempo, duration_ms) %>% 
  rename(album = album_name, 
         year = album_release_year,
         track = track_name) 
  gen %>% 
  summary()

gen %>% 
  filter(album_name == "YELLOW DANCER") %>% 
  summary()

gen %>% 
  arrange(desc(acousticness)) %>% 
  head(15)

gen %>% 
  filter(acousticness < 0.1)

gen %>% 
  select(album, year) %>% 
  unique() %>% 
  arrange(year)

gen %>% 
  select_if(is.numeric) %>% # 数値型の列のみ選択
  cor() %>%
  corrplot(tl.col="black",  addCoef.col = "black", method = "square", shade.col = NA)


# デフォルトだと黒文字が見えないので、見えるくらいに色指定
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

gen %>% 
  select_if(is.numeric) %>%
  cor() %>%
  corrplot(method = "color", # 出力はセルに色塗り
           addCoef.col = "black", # 係数の文字色
           tl.col = "black", # 変数の文字色
           col = col(200), # 色を200分割グラデーション
           type = "upper", # 行列の上側のみ
           tl.srt = 45, # 変数名が長いので45度に傾ける
           diag = FALSE,  # 同じ変数同士の相関(1)を隠す
           p.mat = p,
           sig.level = 0.01, # 閾値
           insig = "blank" # 有意でないセルは空白に
           )

p <- gen %>% 
  select_if(is.numeric) %>%
  cor.mtest()
