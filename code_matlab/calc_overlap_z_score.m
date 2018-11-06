
function z_score_table = main(coverages, active_site)

  % ranks = ['/home/ilya/Documents/Experiments/2014/committee_suggestions/'...
  %         'hammerhead/PDB_mapping_etc/functional_site/hhr_fs.csv']
  % data = importdata(ranks);

  % active_site = find(data(:,9)~=0);

  % active_site


  % coverages = trace_data_rvet.coverage;
  % nt_num = trace_data_rvet.nt_num;

  coverage_bins = unique(coverages);
  len = length(coverage_bins);
  cluster_weight_ary = [];

  N = length(coverages); % total molecule size
  f = length(active_site); % number of functional residues in molecule

  t = [];
  for i=1:len
    coverage_bin = coverage_bins(i);
    index_nts_in_bin = find(coverages <= coverage_bin); % selection

    m = length(index_nts_in_bin); % selection size, nts in bin

    % expected number of functional residues in selected sample
    exp_f_in_m = f*(m/N);
    % variance of exp_mn
    variance_exp = exp_f_in_m*((N-f)/N)*((N-m)/(N-1));
    std_dev = sqrt(variance_exp);
    fs_in_bin = intersect(active_site, index_nts_in_bin); % overlap between selection and active site
    k = length(fs_in_bin); % functional residues in selection
    z_score_overlap = (k - exp_f_in_m)/std_dev;

    if k == exp_f_in_m
      z_score_overlap = 0;
    end

    % row = [m coverage_bin k exp_f_in_m z_score_overlap];
    actual_coverage_bin = m/N;
    row = [m actual_coverage_bin k exp_f_in_m z_score_overlap];
    
    t = [t;row];
  end

  z_score_table = table(t(:,1), t(:,2), t(:,3), t(:,4), t(:,5),'VariableNames', {'m', 'cov_bin',...
                  'observed' 'expected' 'z_score'});


