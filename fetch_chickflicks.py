from letterboxdpy.list import List
import pandas as pd

list_instance = List("kaitienk", "chick-flicks")
movies = list_instance.movies

df = pd.DataFrame(movies.values()).drop(columns=["url","slug"])
df.to_csv("chick_flicks_titles.csv", index=False, encoding="utf-8")