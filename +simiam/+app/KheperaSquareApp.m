classdef KheperaSquareApp < handle

% Copyright (C) 2013, Georgia Tech Research Corporation
% see the LICENSE file included with this software
    
    properties
        supervisors
        initialized
        root
        follower1_iter
        follower2_iter
        follower1_x_points
        follower1_y_points
        follower2_x_points
        follower2_y_points
    end
    
    methods
        function obj = KheperaSquareApp(root)
            obj.supervisors = simiam.containers.ArrayList(3);
            obj.initialized = false; 
            obj.root = root;
            
            %Create points for a square for follower 1
            obj.follower1_x_points = [1, 1, 0.5, 0.5]
            obj.follower1_y_points = [1, 0.5, 0.5, 1] 
            
            % ...and likewise for follower 2
            obj.follower2_x_points = [-1, -1, -0.5, -0.5];
            obj.follower2_y_points = [-1, -0.5, -0.5, -1];
            
            %Use these iter variables to keep track of where we're at in
            %points arrays
            obj.follower1_iter = 1;
            obj.follower2_iter = 1;
        
            
        end
        
        function run(obj, dt)
            
            aFollowerRobot1 = obj.supervisors.elementAt(2);
            aFollowerRobot2 = obj.supervisors.elementAt(3); 
            
            if ~obj.initialized
                aFollowerRobot1.goal = [obj.follower1_x_points(obj.follower1_iter), obj.follower1_y_points(obj.follower1_iter)];
                aFollowerRobot2.goal = [obj.follower2_x_points(obj.follower2_iter), obj.follower2_y_points(obj.follower2_iter)]; 
                obj.follower1_iter = obj.follower1_iter + 1; 
                obj.follower2_iter = obj.follower2_iter + 1;
                obj.initialized = true; 
            end

            if aFollowerRobot1.at_goal
                
                aFollowerRobot1.goal = [obj.follower1_x_points(obj.follower1_iter), obj.follower1_y_points(obj.follower1_iter)];
                
                %Reset the iter variable if needed. Otherwise, increment
                if isequal(obj.follower1_iter, 4)
                    obj.follower1_iter = 1;
                else
                    obj.follower1_iter = obj.follower1_iter + 1; 
                end
            end
            if aFollowerRobot2.at_goal
                
                aFollowerRobot2.goal = [obj.follower2_x_points(obj.follower2_iter), obj.follower2_y_points(obj.follower2_iter)];
                
                %Reset the iter variable if needed. Otherwise, increment
                if isequal(obj.follower2_iter, 4)
                    obj.follower2_iter = 1;
                else
                    obj.follower2_iter = obj.follower2_iter + 1;
                end
            end
            
        end
        
        function ui_press_mouse(obj, click_src)
            aLeader = obj.supervisors.elementAt(1);
            aLeader.goal = click_src;
        end
    end
    
end