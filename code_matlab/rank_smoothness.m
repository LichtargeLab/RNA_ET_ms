% see PMC3799481

function smoothness = main(ranks_data, adj_matrix)

  ranks = ranks_data.coverage;
  [col, row] = find(adj_matrix); % find pairs in matrix
  
  smoothness = 0;
  for i=1:length(col)
    c = col(i);
    r = row(i);
    rank_diff = (ranks(c) - ranks(r))^2;
    smoothness = smoothness + rank_diff;
  end
