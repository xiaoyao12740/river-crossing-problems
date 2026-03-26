function river_crossing()
    % 1表示左岸，0表示右岸
    left_bank = [1, 1, 1]; % 初始状态，人、猫、鸡、米都在左岸
    right_bank = [0, 0, 0];

    dfs(left_bank, right_bank, [], []);

    function dfs(left, right, path_left, path_right)
        if check_state(left, right)
            % 输出找到的解决方案
            disp('找到解决方案：');
            disp('左岸:');
            disp(path_left);
            disp('右岸:');
            disp(path_right);
            return;
        end

        % 尝试所有可能的船只载人和物品的组合
        for i = 1:8
            [boat, items] = get_combination(i);
            [new_left, new_right] = cross_river(left, right, boat, items);
            if is_valid_state(new_left) && is_valid_state(new_right)
                % 更新记录路径
                new_path_left = [path_left; new_left];
                new_path_right = [path_right; new_right];
                % 递归搜索
                dfs(new_left, new_right, new_path_left, new_path_right);
            end
        end
    end

    function [b, i] = get_combination(index)
        % 获取船只载人和物品的组合，共8种可能性
        switch index
            case 1
                b = 1;
                i = [1];
            case 2
                b = 1;
                i = [2];
            case 3
                b = 1;
                i = [3];
            case 4
                b = 1;
                i = [1, 2];
            case 5
                b = 1;
                i = [1, 3];
            case 6
                b = 1;
                i = [2, 3];
            case 7
                b = 1;
                i = [1, 2, 3];
            case 8
                b = 1;
                i = [];
        end
    end

    function [new_left, new_right] = cross_river(left, right, boat, items)
        % 根据船只载人和物品的组合更新状态
        new_left = left;
        new_right = right;
        new_left(1) = left(1) - boat;
        new_right(1) = 1 - new_left(1);
        for i = items
            new_left(i+1) = left(i+1) - 1;
            new_right(i+1) = 1 - new_left(i+1);
        end
    end

    function valid = is_valid_state(state)
        % 检查状态是否合法，不满足条件的状态为无效状态
        valid = (state(2) == 0 || state(2) == state(1)) && (state(3) == 0 || state(3) == state(1));
    end

    function found = check_state(left, right)
        % 检查是否达到目标状态，即所有人和物品都在右岸
        found = all(right);
    end
end