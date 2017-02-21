classdef PositionPlotter < handle
% PLOTTER supports plotting a robots position
%
% Properties:
%   t           - timestep
%   x           - x position
%   y           - y position
%
% Methods:
%   plot_pos - plots a position over time
    
    properties
    %% PROPERTIES
    
        t   % Time
        x   % x position
        y   % y position
        
        h
        g
        a
    end
    
    methods
        function obj = PositionPlotter()
        % PLOTTER Constructor
        
            obj.t = 0;
            obj.y = 0;
            obj.x = 0;
            obj.h = -1;
            obj.g = -1;
            
            figure;
            obj.a = axes;
            ax = gca; 
            ax.Title.String = 'Position Plot'; 
            
            set(obj.a, 'NextPlot', 'add');
            hold(obj.a, 'all');
            obj.t = 0;
        end
        
        function plot_pos(obj, dt, y, x)
        %% PLOT_pos Plots a robot's position
        
            if ~ishandle(obj.h)
                obj.h = plot(obj.a, x, y, 'b', 'LineStyle', 'none', 'Marker', '*');
                obj.x = obj.x(end);
                obj.y = obj.y(end);
            end
            
            obj.t = [obj.t obj.t(end)+dt];
            obj.y = [obj.y y];
            obj.x = [obj.x x];
            
            set(obj.h, 'XData', obj.x);
            set(obj.h, 'YData', obj.y);   
            
        end
        
        function switch_2d_ref(obj)
            obj.h = -1;
        end
        
    end
    
end
