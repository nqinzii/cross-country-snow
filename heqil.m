% 完整实验数据输入
data_365 = [
    -3.00, -110; -2.50, -109; -2.20, -98; -2.00, -83; -1.90, -69;
    -1.80, -44; -1.78, -33; -1.76, -22; -1.74, -7; -1.73, 3;
    -1.72, 13; -1.71, 24; -1.69, 53; -1.67, 70; -1.65, 97;
    -1.63, 144; -1.61, 179; -1.50, 180; -1.00, 181; 0.00, 181;
    1.00, 181; 2.00, 180; 3.00, 180
];

data_405 = [
    -3.00, -69; -2.50, -67; -1.50, -52; -1.40, -35; -1.38, -29;
    -1.36, -24; -1.34, -18; -1.33, -10; -1.32, -4; -1.31, 1;
    -1.30, 5; -1.29, 14; -1.28, 20; -1.27, 31; -1.25, 44;
    -1.23, 70; -1.20, 103; -1.18, 127; -1.16, 160; -1.14, 178;
    -1.10, 178; -0.80, 179; 3.00, 181
];

data_436 = [
    -3.00, -108; -1.60, -108; -1.40, -91; -1.35, -83; -1.30, -75;
    -1.27, -62; -1.25, -53; -1.23, -45; -1.20, -28; -1.19, -18;
    -1.18, -11; -1.17, 3; -1.16, 15; -1.15, 27; -1.14, 42;
    -1.13, 57; -1.12, 78; -1.11, 87; -1.10, 107; -1.08, 134;
    -1.07, 152; -1.06, 171; -1.00, 178
];

data_546 = [
    -3.00, -95; -2.00, -97; -1.50, -93; -0.80, -84; -0.70, -71;
    -0.67, -52; -0.65, -39; -0.64, -26; -0.63, -1; -0.62, 7;
    -0.61, 28; -0.60, 42; -0.59, 58; -0.58, 87; -0.57, 109;
    -0.56, 150; -0.55, 175; -0.52, 178; -0.50, 178; -0.44, 178;
    0.00, 180; 1.00, 181; 2.00, 181
];

data_577 = [
    -3.00, -18; -2.50, -16; -1.00, -15; -0.65, -12; -0.60, -10;
    -0.57, -8; -0.55, -5; -0.54, -4; -0.53, -3; -0.52, -1;
    -0.51, 0; -0.50, 4; -0.49, 7; -0.47, 14; -0.45, 20;
    -0.43, 30; -0.35, 73; -0.30, 105; -0.25, 138; -0.20, 177;
    -0.10, 179; 0.00, 179; 1.00, 181; 3.00, 181
];

%% 专业绘图配置
curve_properties = {
    % 颜色           标记类型  标记尺寸  线型   标签       
    [0.00, 0.45, 0.74]  'o'      10       '-'   '365 nm'  % 蓝色圆形标记
    [0.85, 0.33, 0.10]  's'      10       '--'  '405 nm'  % 橙色方形标记
    [0.93, 0.69, 0.13]  'd'      10       ':'   '436 nm'  % 黄色菱形标记
    [0.49, 0.18, 0.56]  '^'      10       '-.'  '546 nm'  % 紫色三角标记
    [0.47, 0.67, 0.19]  'v'      10       '-'   '577 nm'  % 绿色倒三角标记
};

figure_config = struct(...
    'size',         [800, 600],...    % 像素尺寸
    'dpi',          300,...          % 输出分辨率
    'axes_limits',  [-3.5, 3.5, -120, 200],...  % 坐标范围
    'grid',         'on'...
);

%% 创建科研级画布
figure('Units', 'pixels', 'Position', [100, 100, figure_config.size],...
       'Color', 'white', 'PaperPositionMode', 'auto');
ax = axes('LineWidth', 1.2, 'FontSize', 11);
hold(ax, 'on');
grid(ax, figure_config.grid);
box(ax, 'on');

%% 核心绘图模块
all_data = {data_365, data_405, data_436, data_546, data_577};

for idx = 1:5
    % 提取数据
    U = all_data{idx}(:,1);
    I = all_data{idx}(:,2);
    
    % 绘制主曲线
    plot(U, I,...
        'Color',    curve_properties{idx,1},...
        'LineWidth', 2,...
        'LineStyle', curve_properties{idx,4},...
        'DisplayName', curve_properties{idx,5});
    
    % 计算并标记I=0点
    sign_change = find(diff(sign(I)) ~= 0);
    if ~isempty(sign_change)
        Us = interp1(I(sign_change:sign_change+1), U(sign_change:sign_change+1), 0);
        
        % 增强型标记（无文本标注）
        plot(Us, 0,...
            'Marker',          curve_properties{idx,2},...
            'MarkerSize',      curve_properties{idx,3},...
            'MarkerEdgeColor', 'k',...
            'MarkerFaceColor', curve_properties{idx,1},...
            'LineWidth', 1.5);
    end
end

%% 图表精修
xlabel('Voltage $U_{AK}$ (V)', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('Current $I_{AK}$ ($\times 10^{-12}$ A)', 'Interpreter', 'latex', 'FontSize', 13);
title('Zero-Current Intercept Markers', 'FontSize', 14, 'FontWeight', 'bold');
legend('show', 'Location', 'northeast', 'FontSize', 10);
axis(figure_config.axes_limits);

%% 输出图像
print(gcf, '-dpng', '-r300', 'intercept_markers.png');
disp('图像已保存为 intercept_markers.png');