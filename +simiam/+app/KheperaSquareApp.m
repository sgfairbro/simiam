classdef KheperaSquareApp < handle

% Copyright (C) 2013, Georgia Tech Research Corporation
% see the LICENSE file included with this software
    
    properties
        supervisors
        initialized
        root
        follower1_iter
        follower2_iter
        side
        square_x_array
        square_y_array
    end
    
    methods
        function obj = KheperaSquareApp(root)
            obj.supervisors = simiam.containers.ArrayList(3);
            obj.initialized = false; 
            obj.root = root;
            obj.follower1_iter = 1;
            obj.follower2_iter = 1;
            obj.side = 0.3;
            obj.square_x_array = [obj.side; 0; -obj.side; 0]; 
            obj.square_y_array = [0; obj.side; 0; -obj.side]; 
        
            
        end
        
        function run(obj, dt)
            
            aFollowerRobot1 = obj.supervisors.elementAt(2);
            aFollowerRobot2 = obj.supervisors.elementAt(3); 
            
            if ~obj.initialized
                [xf, yf, ~] = aFollowerRobot1.state_estimate.unpack();
                [xf2, yf2, ~] = aFollowerRobot2.state_estimate.unpack();
                
                fprintf('follower1 position: (%0.3f,%0.3f)\n', xf, yf);
                %fprintf('follower2 position: (%0.3f,%0.3f)\n', xf2, yf2);
                
                aFollowerRobot1.goal = [xf +obj.square_x_array(obj.follower1_iter)*obj.side, yf +obj.square_y_array(obj.follower1_iter)*obj.side];  
                aFollowerRobot2.goal = [xf2 +obj.square_x_array(obj.follower2_iter)*obj.side, yf2 +obj.square_y_array(obj.follower2_iter)*obj.side]; 
                
                obj.follower1_iter = obj.follower1_iter + 1; 
                obj.follower2_iter = obj.follower2_iter + 1;
                obj.initialized = true; 
            end
            
 
%             
%             u = [xf-x; yf-y];
%             u2 = [xf2 - x; yf2 - y]; 
%             
%             theta_d = atan2(u(2),u(1));
%             theta_d2 = atan2(u(2), u(1)); 
%             
%             x_n = x+0.25*cos(theta_d);
%             x_n2 = x+0.25*cos(theta_d); 
%             
%             y_n = y+0.25*sin(theta_d);
%             y_n2 = y+0.25*sin(theta_d2); 
%             
%             

            if aFollowerRobot1.at_goal
                [xf, yf, ~] = aFollowerRobot1.state_estimate.unpack();
                aFollowerRobot1.goal = [xf +obj.square_x_array(obj.follower1_iter)*obj.side, yf +obj.square_y_array(obj.follower1_iter)*obj.side];
              
                fprintf('follower1 position: (%0.3f,%0.3f)\n', xf, yf);
                
                if isequal(obj.follower1_iter, 4)
                    obj.follower1_iter = 1;
                else
                    obj.follower1_iter = obj.follower1_iter + 1; 
                end
            end
            if aFollowerRobot2.at_goal
                [xf2, yf2, ~] = aFollowerRobot2.state_estimate.unpack();  
                aFollowerRobot2.goal = [xf2 +obj.square_x_array(obj.follower2_iter)*obj.side, yf2 +obj.square_y_array(obj.follower2_iter)*obj.side]; 
                
                %fprintf('follower2 position: (%0.3f,%0.3f)\n', xf2, yf2);
                
                if isequal(obj.follower2_iter, 4)
                    obj.follower2_iter = 1;
                else
                    %obj.follower2_iter = obj.follower2_iter + 1;
                end
            end
            
        end
        
        function ui_press_mouse(obj, click_src)
            aLeader = obj.supervisors.elementAt(1);
            aLeader.goal = click_src;
        end
    end
    
end