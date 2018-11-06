function trace_alignment
  addpath('../code_matlab'); 
  % trace the 16S alignment
  aln_path = 'prof_SSU.msf';
  fps = parse_file_paths('FILE_PATHS.TXT');
  
  aln_fp = fps.aln;
  output_name = 'trace_result';
  scoring = 'realval'; % rvET
  query = 'query_pdb'; % 2WDK query sequence in alignment
  trace_table = et_wetc_wrapper(aln_fp, output_name, scoring, query);
  % save trace result as binary
  sfp = fps.trace_result;
  save(sfp, 'trace_table');
  % mv output of wetc script to results/
  system('mv ../et_temp/trace_result* results/');

  display('***')
  display(sprintf('ET wrapper: trace complete, output moved to %s', fps.results))
