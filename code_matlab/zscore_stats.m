
function [zsc_max, zsc_mean, zsc_max35, zsc_mean35] = get_z_stats(zsc_table, fill)
% GET_Z_STATS calculates max, mean, mean35, max35 z-scores
%             input is z-score table (zscore vs coverage, see scripts below)
%             if FILL set to TRUE fills in empty ET coverage bins
%             according to Mihalek et al 2003 (lowest ajdancent z-score)
%
%   [zsc_max, zsc_mean, zsc_max35, zsc_mean35] = GET_Z_STATS(zsc_table, fill)
%
%   See also calc_overlap_z_score_raw_list, calc_overlap_z_score3,
%            calc_clustering_zscore
%
%   Rationale for filling bins:
%   Total theoretical number of coverage bins is L, length of molecule,
%   (if each nt has unique rank) in practice, many nts share the same ET
%   rank, so some ranks bins don't exist  in the table (again, bc there
%   are no nts with that particular rank) to account for the empty bins,
%   we fill them in with lower z-score from the two adjacent bins


  zsc1 = zsc_table.z_score;
  covr1 = zsc_table.cov_bin;
  
  if fill ~= true
    zsc_max = max(zsc1);
    zsc_mean = mean(zsc1);
    covr35 = find(covr1 <= 0.35);
    zsc_max35 = max(zsc1(covr35));
    zsc_mean35 = mean(zsc1(covr35));
  else
    % get length the molecule (size of last coverage bin)
    L = zsc_table.m(end);

    filled_m = [];
    filled_zsc = zeros(1,L);

    % does bin exist in ranking table?
    bins = ismember(1:L, zsc_table.m);
    filled_zsc(bins) = zsc_table.z_score;

%    filled_zsc2 = zeros(1,L);
%    for i=1:L
%      inx = find(ismember(zsc_table.m, i));
%      if isempty(inx) == 0
%        filled_zsc2(i) = zsc_table.z_score(inx);
%      end 
%    end
%    isequal(filled_zsc, filled_zsc2)

    % for vacant bins, scan adjacent non-empty bins, and choose lower z-score
    for i=1:L
      if bins(i) == 0
        if i == 1 % if first bin is empty, look right only
          zsc_bin_left = look_right(i, bins);
          filled_zsc(i) = filled_zsc(zsc_bin_left);
          bins(i) = 1;
        else
          % look left (upstream)
          zsc_bin_left = look_left(i, bins);
          z_left = filled_zsc(zsc_bin_left);
          % look right (downstream)
          zsc_bin_right = look_right(i, bins);
          z_right = filled_zsc(zsc_bin_right);
          if z_right < z_left
            filled_zsc(i) = z_right;
          else
            filled_zsc(i) = z_left;
          end
          bins(i) = 1;
        end
      end

    end

    new_table = [(1:L)'/L, filled_zsc', ismember(1:L, zsc_table.m)'];

    zsc_max = max(new_table(:,2));
    zsc_mean = mean(new_table(:,2));
    covr35 = find(new_table(:,1) <= 0.35);
    zsc_max35 = max(new_table(covr35,2));
    zsc_mean35 = mean(new_table(covr35,2));

  end

function non_zero_bin = look_right(ind, bins)
  for i = ind:length(bins)
    if bins(i) == 1
      non_zero_bin = i;
      break;
    end  
  end


function non_zero_bin = look_left(ind, bins)
  for i = ind:-1:1
    if bins(i) == 1
      non_zero_bin = i;
      break;
    end  
  end


