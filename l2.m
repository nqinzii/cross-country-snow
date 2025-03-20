% 基础数据准备（同前）
x0 = -5:0.5:5; y0 = sin(x0);
x = -5:0.2:5; y_true = sin(x);
y_linear = interp1(x0, y0, x, 'linear');
y_spline = interp1(x0, y0, x, 'spline');

% 绘制动态散点
figure('Position', [100, 100, 1000, 600])
scatter3(x, y_true, ones(size(x))*1, 50, 'bo', 'filled', 'DisplayName', '理论值')
hold on
scatter3(x, y_linear, ones(size(x))*2, 50, 'r^', 'filled', 'DisplayName', '线性插值')
scatter3(x, y_spline, ones(size(x))*3, 50, 'g*', 'filled', 'DisplayName', '三次样条插值')

% 动态旋转设置
title('动态三维散点对比')
xlabel('x值'), ylabel('函数值'), zlabel('数据类型标识')
legend('Location', 'northeast')
axis tight

% 动态旋转动画
for i = 1:360
    view(i, 30)
    drawnow
end