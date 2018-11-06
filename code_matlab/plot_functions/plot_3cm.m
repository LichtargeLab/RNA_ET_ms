function plot_ovz1_MINI(x,y,name,sfp)
  %create figure
  fig = figure();
  hold on;
  % don't show image in MATLAB IDE
  set(gcf, 'Visible', 'off');
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
  %ax_pos(1) = ax_pos(1)+0.01
  %set(gca, 'Position', ax_pos);

  box on;

  h1 = plot(x, y, 'black', 'LineWidth', 1);
  title(name, 'FontSize', 8);
  % plot random line

  % legend([h1, h2], '', '',...
  %      'Location', 'southwest');

  ymax = max([y;y]) + 1;
  xlim([0,1]);
  ylim([-1,10.8]);
  %xlabel('ET coverage');
  %ylabel('overlap z-score');
  set(gca,'YTick', [0, 2, 4, 6, 8, 10]);
  set(gca,'Xtick', 0:0.5:1);
  
  % Here we preserve the size of the image when we save it.
  width = 1.7;
  height = 1.7;
  set(gcf,'InvertHardcopy','on');
  set(gcf,'PaperUnits', 'inches');
  papersize = get(gcf, 'PaperSize');
  left = (papersize(1)- width)/2;
  bottom = (papersize(2)- height)/2;
  myfiguresize = [left, bottom, width, height];
  set(gcf,'PaperPosition', myfiguresize);

  print(sfp, '-dpng', '-r300');
  hold off;
  clear fig;
