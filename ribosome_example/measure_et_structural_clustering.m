function main
  addpath('../code_matlab')
  addpath('../code_matlab/plot_functions')

  % load file paths
  fps = parse_file_paths('FILE_PATHS.TXT');

  % load adjacency matrix
  adj_matrix = load(fps.adj_matrix);
  adj_matrix = adj_matrix.adj_matrix;

  % if expected clustering table already exists, load it
  % otherwise calculate from adjacency matrix
  exp_cl_fp = 'data/expected_clustering_table.mat';
  if exist(exp_cl_fp, 'file')  == 2
    loaded = load(exp_cl_fp);
    exp_clustering_table = loaded.exp_clustering_table;
  else
    % given ajacency matrix, calculate expected clustering
    display(['calculating expected clustering,'... 
             'takes 5-10 minutes for ribosomal structures'])
    exp_clustering_table = calc_expected_clust(adj_matrix);
    % save to disc for reuse
    save(exp_cl_fp, 'exp_clustering_table')
    disp(sprintf('expected clustering table saved to %s', exp_cl_fp)); 
  end

  % load trace scores, profiled to 2WDL pdb
  trace_result = load(fps.trace_result);
  trace_result = trace_result.trace_table;

  % calculate smoothness
  smoothness = rank_smoothness(trace_result, adj_matrix);
  
  % calculate clustering z-score and stats
  disp('Calculating ET clustering z-scores for each ET rank cutoff...');
  clust_z = calc_clust_z_score(adj_matrix, trace_result, exp_clustering_table);
  clust_z.z_score(end) = 0;
  fill_empty = true; % fill empty coverage bins

  % display the stats
  disp(' ');
  disp('Z-score stats:');
  [cz_max, cz_mean, cz_max35, cz_mean35] = zscore_stats(clust_z,...
                                       fill_empty);
  scores = [cz_max, cz_mean, cz_max35, cz_mean35, smoothness];
  % display as table
  out = array2table(scores, 'VariableNames', {'z_max' 'z_mean' 'z_max35' 'z_mean35' 'SMT'});
  display(out);
  display('LEGEND:');
  display('z_max     peak of the z-score curve');
  display('z_mean    average score, calculated over the entire curve');
  display('z_max35   peak of the z-score curve within 0-35% coverage (rank) bins');
  display('z_mean35  average score, calculated over the 0-35% coverage (rank) bins');
  display('SMT       ET smoothenss, total rank difference of neighboring nts');
  disp(' ');
  % plot
  sfp_fig = [fps.fig_small, 'ssu_clustering_zscore.png'];
  disp(sprintf('Plotting clustering z-score curve to %s', sfp_fig));
  plot_8cm(clust_z.cov_bin, clust_z.z_score, 'clustering z_c', sfp_fig) 
  % save clustering table to disc
  sfp_zscores = ([fps.results, 'results_clustering.xls']); 
  disp(sprintf('Writing raw clustering z-score scores to %s', sfp_zscores));
  writetable(out, sfp_zscores);
