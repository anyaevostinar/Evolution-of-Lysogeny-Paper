# importing the modules
from random import randint
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
  
host_inc_vals = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

sym_inc_vals = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

host_inc_vals.reverse()


host_res = []
sym_res = []
sym_repro = []
host_repro = []
synergy = 2
res_update = 50


for h in range(len(host_inc_vals)):
    host_res.append([None] * len(sym_inc_vals))
    for s in range(len(sym_inc_vals)):
        success = 1-abs(host_inc_vals[h] - sym_inc_vals[s])
        host_res[h][s] = res_update * success * synergy

cmap = sns.cm.rocket_r

hm = sns.heatmap(data = host_res, 
                xticklabels = sym_inc_vals, 
                yticklabels = host_inc_vals, 
                cmap=cmap, 
                cbar_kws={'label': 'Host Resources After Prophage Interaction'})
plt.xlabel("Prophage Incorporation Value")
plt.ylabel("Bacterium Incorporation Value")

plt.savefig('heatmap.png')