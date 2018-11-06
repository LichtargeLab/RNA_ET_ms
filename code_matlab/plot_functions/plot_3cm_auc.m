function plot_roc_curve_MINI(x1,y1,auc1,name,svp)
  % create figure
  fig = figure;
  hold on;
  % don't show image in MATLAB IDE
  set(gcf, 'Visible', 'off');
  box on;
  % set width and height to something square like 300x300 pixels
  position = get(gcf, 'Position');
  set(gcf, 'Position', [position(1) position(2) 300 300]);
  % set fonts and size
  set(gcf,'DefaultTextFontname', 'Arial');
  set(gcf,'DefaultTextFontSize', 10);

  %set axis font, font size, line width
  axis_font = 'Arial';
  axis_font_size = 10;
  axis_width = 1;
  %set(gca, 'FontName', axis_font)
  %set(gca, 'FontSize', axis_font_size)
  set(gca, 'LineWidth', axis_width);
  % default axis length is 0.775 by 0.815, make it a square
  ax_pos = get(gca, 'Position');
  ax_pos(3:4) = 0.8;
  ax_pos(1) = ax_pos(1)+0.01;
  set(gca, 'Position', ax_pos);

  %%% PLOT %%%
  plot(x1(2:end), y1(2:end), 'black', 'LineWidth', 1);
  plot([0 1], [0 1], 'black', 'LineWidth', 1);

  legend({sprintf('AUC=%1.2f', auc1)},...
         'Location', 'southeast');
  title(name);
  xlim([0,1])
  ylim([0,1])
  xlabel('TPR');
  ylabel('FPR');

  % Here we preserve the size of the image when we save it.
  width = 2;
  height = 2;
  set(gcf,'InvertHardcopy','on');
  set(gcf,'PaperUnits', 'inches');
  papersize = get(gcf, 'PaperSize');
  left = (papersize(1)- width)/2;
  bottom = (papersize(2)- height)/2;
  myfiguresize = [left, bottom, width, height];
  set(gcf,'PaperPosition', myfiguresize);


  set(gca,'XTick',0:0.5:1); %<- Still need to manually specify tick marks
  set(gca,'YTick',0:0.5:1); 

  print(svp, '-dpng', '-r300');
