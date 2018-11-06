function fps = parse_file_paths(fp_txt)
  % PARSE_FILE_PATHS parses directory pointers
  %   FPS = PARSE_FILE_PATHS(FP_TXT) 
  %   
  %   FP_TXT - delimited text file with dir paths
  %   FPS - matlab struct of tokens pointing to dir paths
  %

  % open and parse paths file
  fid = fopen(fp_txt);
  c = textscan(fid,'%s %s', 'Delimiter', '=',...
               'CommentStyle', '%');
  tokens = c{1};
  paths = c{2};
  
  % hash tokens and their paths 
  fps = struct();
  for i=1:length(tokens)
    token = strtrim(tokens{i});
    fp = strtrim(paths{i});
    fps.(token) = fp;
  end
