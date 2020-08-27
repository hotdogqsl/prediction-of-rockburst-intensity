# prediction-of-rockburst-intensity
The code is written by Matlab, which is used for real-time prediction of rockburst intensity.

tSNE_dimension_reduction.m is used to reduce dimension of the database by tSNE algorithm.

KMeans_clustering_main.m is the main function of k-means algorithm, and KMeans_clustering.m is its sub function.

KMeans_plot.m is used to show clustering process under different iterations.

Canopy_clustering.m is used to determine the value of k in k-means algorithm in advance. 

correlation.m is used to calculate the correlation coefficient between variables.

prediction_nopruning.m is used to train the precursor tree without pruning and predict rockburst intensity.

prediction_pruning.m is used to train the precursor tree with pruning and predict rockburst intensity.

bp_dr.m is used for dimension reduction in the engineering application phase, and initpop_generate.m, subpop_generate.m and ismature.m are its sub functions.

dist.m is used to assign clustering label in the engineering application phase.

