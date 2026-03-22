clear;
clc;

% Read the data from the CSV file (读取Xiaohao1的数据)
data = readtable('Xiaohao1.csv');

% Extract columns for convenience
depth = data.Depth;
hzml = data.hzlm;
ucs_pred = data.UCS_pred;
ucs_traditional = data.UCS_traditional;
es_pred = data.Es_pred;
es_traditional = data.Es_traditional;
us_pred = data.us_pred;
us_traditional = data.us_traditional;
fai_pred = data.Fai_pred;
fai_traditional = data.Fai_traditional;
c_pred = data.C_pred;
c_traditional = data.C_traditional;

% Classify HMLZ into categories (煤体结构分类)
category = ones(size(hzml));           % Default: dull coal (暗煤)
category(hzml > 15.2) = 4;             % bright coal (亮煤)
category(hzml > 5 & hzml <= 15.2) = 3; % semi-bright coal (半亮煤)
category(hzml > 1.9 & hzml <= 5) = 2;  % semi-dull coal (半暗煤)

% Define colors for each category (定义颜色)
colors = [0.4, 0.4, 0.4;      % 暗煤 - 灰色
          0.7, 0.5, 0.3;      % 半暗煤 - 棕色
          0.8, 0.7, 0.4;      % 半亮煤 - 黄棕色
          0.9, 0.9, 0.6];     % 亮煤 - 浅黄色

% Create a new figure with 7 subplots
% 画布宽度设为2400，右侧留出足够空白放图例
fig = figure('Color', 'w', 'Position', [50, 50, 2400, 600]);

% 用于控制实测数据点的采样间隔
sample_interval = 120; 
sample_indices = 1:sample_interval:length(depth);

% 设置全局字体，确保中文不乱码 (推荐宋体)
font_name = 'SimSun'; 

%% ================== 输入参数区 (放在最左侧) ==================

%% Chart 1: HMLZ 曲线 (作为首个输入条件)
subplot('Position', [0.04, 0.1, 0.10, 0.8]);
plot(hzml, depth, 'b-', 'LineWidth', 1.5);
set(gca, 'YDir', 'reverse', 'FontName', font_name); 
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('HMLZ 随深度变化', 'FontName', font_name, 'FontSize', 12);
grid on;

%% Chart 2: HMLZ Categories (煤体结构柱状图，与HMLZ紧密相邻)
ax2 = subplot('Position', [0.15, 0.1, 0.04, 0.8]); 
hold on;

n_points = length(depth);

% 逐层填充颜色
for j = 1:n_points
    if j < n_points
        seg_depth_top = depth(j);
        seg_depth_bottom = depth(j+1);
    else
        seg_depth_top = depth(j);
        seg_depth_bottom = depth(j);
    end
    cat_idx = category(j);
    x_coords = [0, 1, 1, 0];
    y_coords = [seg_depth_top, seg_depth_top, seg_depth_bottom, seg_depth_bottom];
    fill(x_coords, y_coords, colors(cat_idx, :), 'EdgeColor', 'none');
end

set(gca, 'YDir', 'reverse', 'FontName', font_name); 
xlim([0, 1]);
xticks([]);
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('煤体结构', 'FontName', font_name, 'FontSize', 12);
grid on;

%% ================== 预测结果区 (放在右侧) ==================
% 注意：此处开始，x轴起始点为0.24，与前面输入区稍微拉开一点间隙，强调因果逻辑

%% Chart 3: UCS Comparison (单轴抗压强度)
subplot('Position', [0.24, 0.1, 0.10, 0.8]);
plot(ucs_pred, depth, 'Color', [0.0, 0.65, 0.9], 'LineStyle', '-', 'LineWidth', 1.5, 'DisplayName', '本文方法');
hold on;
% plot(ucs_traditional, depth, 'Color', [0.8, 0.4, 0.2], 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', '传统方法');
plot(ucs_pred(sample_indices), depth(sample_indices), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k', 'DisplayName', '实测数据');
set(gca, 'YDir', 'reverse', 'FontName', font_name); 
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('单轴抗压强度 (UCS)', 'FontName', font_name, 'FontSize', 12);
legend('Location', 'best', 'FontName', font_name);
grid on;

%% Chart 4: Elastic Modulus (弹性模量)
subplot('Position', [0.37, 0.1, 0.10, 0.8]);
plot(es_pred, depth, 'Color', [0.95, 0.35, 0.25], 'LineStyle', '-', 'LineWidth', 1.5, 'DisplayName', '本文方法');
hold on;
% plot(es_traditional, depth, 'Color', [0.6, 0.2, 0.1], 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', '传统方法');
plot(es_pred(sample_indices), depth(sample_indices), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k', 'DisplayName', '实测数据');
set(gca, 'YDir', 'reverse', 'FontName', font_name);
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('弹性模量 (E_s)', 'FontName', font_name, 'FontSize', 12);
legend('Location', 'best', 'FontName', font_name);
grid on;

%% Chart 5: Poisson's Ratio (泊松比)
subplot('Position', [0.50, 0.1, 0.10, 0.8]);
plot(us_pred, depth, 'Color', [0.5, 0.85, 0.35], 'LineStyle', '-', 'LineWidth', 1.5, 'DisplayName', '本文方法');
hold on;
% plot(us_traditional, depth, 'Color', [0.3, 0.5, 0.2], 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', '传统方法');
plot(us_pred(sample_indices), depth(sample_indices), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k', 'DisplayName', '实测数据');
set(gca, 'YDir', 'reverse', 'FontName', font_name);
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('泊松比 (\mu_s)', 'FontName', font_name, 'FontSize', 12);
legend('Location', 'best', 'FontName', font_name);
grid on;

%% Chart 6: Internal Friction Angle (内摩擦角)
subplot('Position', [0.63, 0.1, 0.10, 0.8]);
plot(fai_pred, depth, 'Color', [0.75, 0.45, 0.9], 'LineStyle', '-', 'LineWidth', 1.5, 'DisplayName', '本文方法');
hold on;
% plot(fai_traditional, depth, 'Color', [0.5, 0.3, 0.6], 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', '传统方法');
plot(fai_pred(sample_indices), depth(sample_indices), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k', 'DisplayName', '实测数据');
set(gca, 'YDir', 'reverse', 'FontName', font_name);
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('内摩擦角 (\phi)', 'FontName', font_name, 'FontSize', 12);
legend('Location', 'best', 'FontName', font_name);
grid on;

%% Chart 7: Cohesion (内聚力)
subplot('Position', [0.76, 0.1, 0.10, 0.8]);
plot(c_pred, depth, 'Color', [1.0, 0.7, 0.1], 'LineStyle', '-', 'LineWidth', 1.5, 'DisplayName', '本文方法');
hold on;
% plot(c_traditional, depth, 'Color', [0.7, 0.5, 0.05], 'LineStyle', '--', 'LineWidth', 1.5, 'DisplayName', '传统方法');
plot(c_pred(sample_indices), depth(sample_indices), 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k', 'DisplayName', '实测数据');
set(gca, 'YDir', 'reverse', 'FontName', font_name);
ylabel('深度 (m)', 'FontName', font_name, 'FontSize', 12);
title('内聚力 (C)', 'FontName', font_name, 'FontSize', 12);
legend('Location', 'best', 'FontName', font_name);
grid on;

%% ======== 提取独立的、不遮挡的图例 (放在最右侧空白) ========
% 先创建4个不可见的Dummy图形对象用于生成图例颜色块
h1 = fill(NaN, NaN, colors(1,:), 'EdgeColor', 'none');
h2 = fill(NaN, NaN, colors(2,:), 'EdgeColor', 'none');
h3 = fill(NaN, NaN, colors(3,:), 'EdgeColor', 'none');
h4 = fill(NaN, NaN, colors(4,:), 'EdgeColor', 'none');

% 创建图例，并将其硬性定位于最右侧空白处
lgd_labels = {'暗淡煤 (HMLZ \leq 1.9)', '半暗煤 (1.9 < HMLZ \leq 5)', ...
              '半亮煤 (5 < HMLZ \leq 15.2)', '光亮煤 (HMLZ > 15.2)'};
lgd = legend([h1, h2, h3, h4], lgd_labels, 'FontName', font_name, 'FontSize', 11);

% Position: [left, bottom, width, height]
% 固定放置在画布最右侧的绝对空白区域 (x=0.88)，彻底避免遮挡
set(lgd, 'Position', [0.88, 0.45, 0.10, 0.15], 'Box', 'on'); 

%% Export Graphics (输出为xiaohao1的图片)
exportgraphics(gcf, 'xiaohao1_RockMechanicalProperty.png', 'Resolution', 1200);
close(gcf);