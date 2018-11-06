
function [data_table] = read_trace_file_rvET(fp)

  data = importdata(fp);

  data(1:2,:) = [];

  sequence = data(:,3);
  sequence = strjoin(sequence, '');


  t = cell2table(data, 'VariableNames',{'alignment_num' 'nt_num' 'nt_type' 'rank'...
                                        'variability_num' 'variability_type' 'rho' 'coverage'});
  t.alignment_num = cellfun(@str2num, t.alignment_num);
  t.nt_num = cellfun(@str2num, t.nt_num);
  t.rank = cellfun(@str2num, t.rank);
  t.variability_num = cellfun(@str2num, t.variability_num);
  t.rho = cellfun(@str2num, t.rho);
  t.coverage = cellfun(@str2num, t.coverage);    

  data_table = t;

