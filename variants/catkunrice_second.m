% 定义目标函数
objective = @(x) x(1) * x(2);

% 定义约束条件
constraints = @(x) [x(2) - 5; 7 - x(2)];

% 求解最优化问题
x0 = [0.5; 6]; % 初始解
lb = [0.1; 5]; % 变量下界
ub = [1; 7]; % 变量上界
options = optimoptions('fmincon', 'Display', 'iter');
[x, fval] = fmincon(objective, x0, [], [], [], [], lb, ub, constraints, options);

% 打印结果
disp(['最优解：b = ', num2str(x(1)), ', d = ', num2str(x(2))]);
disp(['最优值：', num2str(fval)]);
