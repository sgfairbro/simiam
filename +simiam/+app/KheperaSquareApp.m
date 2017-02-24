classdef KheperaSquareApp < handle

% Copyright (C) 2013, Georgia Tech Research Corporation
% see the LICENSE file included with this software
    
    properties
        supervisors
        root
        square_iter
        side
        square_x_array
        square_y_array
    end
    
    methods
        function obj = KheperaSquareApp(root)
            obj.supervisors = simiam.containers.ArrayList(3);
            obj.root = root;
            obj.square_iter = 1; 
            obj.side
            obj.square_x_array = [obj.side; 0; -obj.side; 0]; 
            obj.square_y_array = [0; obj.side; 0; -obj.side]; 
            
        end
        
        function run(obj, dt)
            aFollowerRobot1 = obj.supervisors.elementAt(2);
            aFollowerRobot2 = obj.supervisors.elementAt(3); 
            
%             [xf, yf, thetaf] = aFollowerRobot1.state_estimate.unpack();
%             [xf2, yf2, thetaf2] = aFollowerRobot2.state_estimate.unpack(); 
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
%             aFollower1 = obj.supervisors.elementAt(2);
%             aFollower2 = obj.supervisors.elementAt(3);
%             
%             aFollower1.goal = [x_n; y_n];
%             aFollower2.goal = [x_n2;y_n2]; 
        end
        
        function ui_press_mouse(obj, click_src)
            aLeader = obj.supervisors.elementAt(1);
            aLeader.goal = click_src;
        end
    end
    
end