function [exp_clust_and_stddev_table] = main(adj_matrix)
  len = length(adj_matrix); % molecule length
  subsum = get_subsum(adj_matrix);
  
  output = [];
  for m=0:len % number of nucleotides, m/l = coverage bin
    sisj_exp=m*(m-1.0)/(len*(len-1.0));
    scw_exp = nnz(adj_matrix) * sisj_exp;
    
    ratio = [0 0 0];
    ratio(1) = m*(m-1)/(len*(len-1));
    ratio(2) = ratio(1)*(m-2)/(len-2);
    ratio(3) = ratio(2)*(m-3)/(len-3);

    avg_sq_weight=subsum*ratio';

    std_dev_sq=(avg_sq_weight-(scw_exp^2));  % AVERAGE OF SQUARE WEIGHT
    std_dev = sqrt(std_dev_sq);              %         IS NOT
                                             % THE SQUARE OF THE WEIGHT AVERAGE
  
    % string = sprintf('%d\t%1.3f\t%1.3f', m, scw_exp, std_dev);
    % disp(string);
    output_line = [m, m/len, scw_exp, std_dev];
    output = [output; output_line];
  end

  o = output; % MATLAB, why cant i convert a double array into table directly >_<
  exp_clust_and_stddev_table = table(o(:,1), o(:,2), o(:,3), o(:,4),...
        'VariableNames', {'m' 'cov_bin' 'exp_clust_weight' 'exp_std_dev'});

function [subsum] = get_subsum(adj_matrix)

  [r, c] = find(adj_matrix);
  len = size([r,c]);
  len = len(1);
  subsum = [0 0 0];
  for i=1:len
    %complete = i/length([r,c])
    index_i = r(i);
    index_j = c(i);
    for j=1:len
      index_k = r(j);
      index_l = c(j);
      indecies = [index_i, index_j, index_k, index_l];
      x = length(unique(indecies));
      if x == 2
        subsum(1) = subsum(1) + 1;
      elseif x == 3
        subsum(2) = subsum(2) + 1;
      elseif x ==4
        subsum(3) = subsum(3) + 1;
      end
    end
  end
