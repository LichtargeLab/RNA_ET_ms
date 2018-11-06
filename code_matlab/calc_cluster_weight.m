
function [cluster_weight] = calc_clusters(adjacency_matrix, indecies_of_interest)
  adjacency_matrix = adjacency_matrix + adjacency_matrix';
  %adjacency_matrix(adjacency_matrix > 0) = 1; % in case matrix already symmetrical
  %adjacency_matrix = adjacency_matrix - diag(diag(adjacency_matrix));
  % indecies of interests are the positions in the matrix
  adjacency_matrix_subset = adjacency_matrix(indecies_of_interest, indecies_of_interest);
  
  cluster_weight = sum(adjacency_matrix_subset(:))/2;
