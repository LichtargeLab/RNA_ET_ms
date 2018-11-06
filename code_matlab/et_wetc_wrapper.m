
% ET code by AW: /home/novikov/Documents/Scripts/code2/wetc

function trace_data = main(aln_fp, outname, scoring, query)
  wetc_code = '../et_bin/wetc';
  TEMP_DIR = '../et_temp';

  % cp alignmnet to the et temp folder
  [pathstr, name, ext] = fileparts(aln_fp);
  cmd = sprintf('cp %s %s', aln_fp, TEMP_DIR);
  system(cmd);
  aln_fp = sprintf('%s/%s%s', TEMP_DIR, name, ext);

  % set output to et temp folder
  outname = sprintf('%s/%s', TEMP_DIR, outname);
  
  % set wetc command
  cmd = sprintf('%s -p %s -x %s -%s -dnaet -o %s -skip_query',...
                wetc_code, aln_fp, query, scoring, outname);
  x = system(cmd);

  outname = sprintf('%s.ranks', outname);
  
  trace_data = nan;
  if scoring == 'realval'
    trace_data = read_trace_file_rvET(outname);
  else
    trace_data = read_trace_file_ENTROPY(outname);
  end
