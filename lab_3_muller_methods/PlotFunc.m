function [] = PlotFunc(ys1, xs1, ticks, name, ylab)
    plot(xs1, ys1, 'Color', 'k');
    title(name);
    xlabel('x');
    ylabel(ylab);
    xticks(ticks);
    line(xlim(), [0,0], 'LineWidth', 1, 'Color', 'k', 'LineStyle', '--');
end