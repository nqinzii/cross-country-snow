% 原始数据整理
data_365 = [
    -3.00, -110;
    -2.50, -109;
    -2.20, -98;
    -2.00, -83;
    -1.90, -69;
    -1.80, -44;
    -1.78, -33;
    -1.76, -22;
    -1.74, -7;
    -1.73, 3;
    -1.72, 13;
    -1.71, 24;
    -1.69, 53;
    -1.67, 70;
    -1.65, 97;
    -1.63, 144;
    -1.61, 179;
    -1.50, 180;
    -1.00, 181;
    0.00, 181;
    1.00, 181;
    2.00, 180;
    3.00, 180
];

data_405 = [
    -3.00, -69;
    -2.50, -67;
    -1.50, -52;
    -1.40, -35;
    -1.38, -29;
    -1.36, -24;
    -1.34, -18;
    -1.33, -10;
    -1.32, -4;
    -1.31, 1;
    -1.30, 5;
    -1.29, 14;
    -1.28, 20;
    -1.27, 31;
    -1.25, 44;
    -1.23, 70;
    -1.20, 103;
    -1.18, 127;
    -1.16, 160;
    -1.14, 178;
    -1.10, 178;
    -0.80, 179;
    3.00, 181
];

data_436 = [
    -3.00, -108;
    -1.60, -108;
    -1.40, -91;
    -1.35, -83;
    -1.30, -75;
    -1.27, -62;
    -1.25, -53;
    -1.23, -45;
    -1.20, -28;
    -1.19, -18;
    -1.18, -11;
    -1.17, 3;
    -1.16, 15;
    -1.15, 27;
    -1.14, 42;
    -1.13, 57;
    -1.12, 78;
    -1.11, 87;
    -1.10, 107;
    -1.08, 134;
    -1.07, 152;
    -1.06, 171;
    -1.00, 178
];

data_546 = [
    -3.00, -95;
    -2.00, -97;
    -1.50, -93;
    -0.80, -84;
    -0.70, -71;
    -0.67, -52;
    -0.65, -39;
    -0.64, -26;
    -0.63, -1;
    -0.62, 7;
    -0.61, 28;
    -0.60, 42;
    -0.59, 58;
    -0.58, 87;
    -0.57, 109;
    -0.56, 150;
    -0.55, 175;
    -0.52, 178;
    -0.50, 178;
    -0.44, 178;
    0.00, 180;
    1.00, 181;
    2.00, 181
];

data_577 = [
    -3.00, -18;
    -2.50, -16;
    -1.00, -15;
    -0.65, -12;
    -0.60, -10;
    -0.57, -8;
    -0.55, -5;
    -0.54, -4;
    -0.53, -3;
    -0.52, -1;
    -0.51, 0;
    -0.50, 4;
    -0.49, 7;
    -0.47, 14;
    -0.45, 20;
    -0.43, 30;
    -0.35, 73;
    -0.30, 105;
    -0.25, 138;
    -0.20, 177;
    -0.10, 179;
    0.00, 179;
    1.00, 181;
    3.00, 181
];

% 创建表格
table_365 = array2table(data_365, 'VariableNames', {'UAK', 'IAK'});
table_405 = array2table(data_405, 'VariableNames', {'UAK', 'IAK'});
table_436 = array2table(data_436, 'VariableNames', {'UAK', 'IAK'});
table_546 = array2table(data_546, 'VariableNames', {'UAK', 'IAK'});
table_577 = array2table(data_577, 'VariableNames', {'UAK', 'IAK'});

% 导出表格
writetable(table_365, '365nm_data.xlsx');
writetable(table_405, '405nm_data.xlsx');
writetable(table_436, '436nm_data.xlsx');
writetable(table_546, '546nm_data.xlsx');
writetable(table_577, '577nm_data.xlsx');

% 定义绘图函数
function plot_data(data, title_str)
    figure;
    plot(data(:, 1), data(:, 2), 'b-', 'LineWidth', 1.5);
    title(title_str, 'FontSize', 14);
    xlabel('$U_{AK}$ (V)', 'Interpreter', 'latex', 'FontSize', 12);
    ylabel('$I_{AK}$ ($10^{-12}$ A)', 'Interpreter', 'latex', 'FontSize', 12);
    grid on;
    
    % 标注数据点
    marker_size = 3;
    hold on;
    plot(data(:, 1), data(:, 2), 'ro', 'MarkerSize', marker_size, 'MarkerFaceColor', 'r');
    
    % 选择标注点
    data_len = size(data, 1);
    if data_len >= 10
        middle_indices = linspace(2, data_len - 1, 8);
        indices = [1, round(middle_indices), data_len];
        indices = unique(indices);
    else
        indices = 1:data_len;
    end
    
    % 添加标注文本
    for i = indices
        x = data(i, 1);
        y = data(i, 2);
        text(x, y, sprintf('(%.2f, %.2f)', x, y), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
            'FontSize', 10, 'Color', 'blue');
    end
    
    % 标注I=0的位置
    sign_changes = find(diff(sign(data(:, 2))) ~= 0);
    if ~isempty(sign_changes)
        % 修正插值参数顺序：x=UAK, y=IAK
        u_zero = interp1(data(sign_changes:sign_changes+1, 1), ...
                         data(sign_changes:sign_changes+1, 2), ...
                         0, 'linear');
        text(u_zero, 0, sprintf('$U_s=%.2f$ V', u_zero), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
            'FontSize', 12, 'Color', 'red', 'Interpreter', 'latex');
        plot(u_zero, 0, 'ro', 'MarkerSize', marker_size, 'MarkerFaceColor', 'r');
    end
    
    % 保存图像（新增）
    filename = regexprep(title_str, '\s+', '_');  % 替换空格为下划线
    saveas(gcf, [filename '.png']);
    hold off;
end

% 绘制所有图像
plot_data(data_365, '365 nm 数据曲线');
plot_data(data_405, '405 nm 数据曲线');
plot_data(data_436, '436 nm 数据曲线');
plot_data(data_546, '546 nm 数据曲线');
plot_data(data_577, '577 nm 数据曲线');

disp('表格和图像已成功导出！');