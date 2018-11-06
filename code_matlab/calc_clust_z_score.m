
function cluster_table = calc_clustering_table(dist_matrix_struct, trace_data_rvet, exp_cluster_table)

  coverages = trace_data_rvet.coverage;
  nt_num = trace_data_rvet.nt_num;
  coverage_bins = unique(coverages);
  len = length(coverage_bins);
  cluster_weight_ary = [];
  m = [];
  for i=1:len
    coverage_bin = coverage_bins(i);
    index_nts_in_bin = find(coverages <= coverage_bin);
    cluster_weight = calc_cluster_weight(dist_matrix_struct, index_nts_in_bin);
    cluster_weight_ary = [cluster_weight_ary; cluster_weight];
    m = [m; length(index_nts_in_bin)]; % keep track of number nts in bin
  end

  obs_cluster_table = table(m, cluster_weight_ary,...
                        'VariableNames', {'m' 'obs_clust_weight'});

  cluster_table = join(obs_cluster_table, exp_cluster_table, 'Key', 'm');

  % calc z_score
  obs_weight = cluster_table.obs_clust_weight;
  exp_weight = cluster_table.exp_clust_weight;
  weight_std_dev = cluster_table.exp_std_dev;
  z_score = (obs_weight-exp_weight)./weight_std_dev; % note correct notation for right-array division ./

  % add z-score to table, and rearrage some colums
  cluster_table = [cluster_table(:,1), cluster_table(:,3), cluster_table(:,2), cluster_table(:,4:5)];
  z_score_table = table(z_score,'VariableNames', {'z_score'});


  cluster_table = [cluster_table, z_score_table];
