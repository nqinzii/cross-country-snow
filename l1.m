% 生成原始采样节点（Δx=0.5）
x0 = -5:0.5:5;
y0 = sin(x0);

% 生成目标插值节点（Δx=0.2）
x = -5:0.2:5;
y_true = sin(x); % 理论值

% 线性插值
y_linear = interp1(x0, y0, x, 'linear');
relative_error_linear = abs((y_linear - y_true) ./ y_true);

% 三次样条插值
y_spline = interp1(x0, y0, x, 'spline');
relative_error_spline = abs((y_spline - y_true) ./ y_true);

% 生成蓝绿黄渐变色映射（适配节点数量）
node_num = length(x);
blue = [0 0 1];
green = [0 1 0];
yellow = [1 1 0];
t = linspace(0, 1, node_num);
cmap = zeros(node_num, 3);
% 蓝到绿到黄渐变
cmap(:, 1) = interp1([0, 0.5, 1], [blue(1), green(1), yellow(1)], t);
cmap(:, 2) = interp1([0, 0.5, 1], [blue(2), green(2), yellow(2)], t);
cmap(:, 3) = interp1([0, 0.5, 1], [blue(3), green(3), yellow(3)], t);

% 三维可视化
figure('Position', [100 100 1200 500])
% 线性插值部分
subplot(1, 2, 1)
scatter3(x, y_linear, relative_error_linear, 50, cmap, 'filled')
hold on
scatter3(x, y_true, zeros(size(x)), 30, 'x', 'Color', 'k')
title('线性插值三维可视化')
xlabel('x值'); ylabel('函数值'); zlabel('相对误差')
legend('插值结果', '理论值')

% 三次样条插值部分
subplot(1, 2, 2)
scatter3(x, y_spline, relative_error_spline, 50, cmap, 'filled')
hold on
scatter3(x, y_true, zeros(size(x)), 30, 'x', 'Color', 'k')
title('三次样条插值三维可视化')
xlabel('x值'); ylabel('函数值'); zlabel('相对误差')
legend('插值结果', '理论值')