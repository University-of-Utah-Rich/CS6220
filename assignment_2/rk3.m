


function y = rk3(t0, tf, y0, f, h)
    % 3rd order Runge-Kutta method for solving ODEs
    % Explicit using Fwd Euler
    %
    % Syntax: y = rk3(t0, tf, y0, f, h)
    %
    % Inputs:
    %    t0 - initial time
    %    tf - final time
    %    y0 - initial condition
    %    f - function handle for the ODE
    %    h - step size
    %
    % Outputs:
    %    y - solution to the ODE
    %
    % Example:
    %    y = rk2(0, 1, 1, @(t, y) t + y, 0.1);
 
       t = t0:h:tf;
       y = zeros(1, length(t));
       c2 = 1/3;
       c3 = 2/3;
       a21 = 1/3;
       a31 = 0;
       a32 = 2/3;
       b1 = 1/4;
       b2 = 0;
       b3 = 3/4;

       y(1) = y0;
       for n = 1:length(t)
          k1 = h*f(t(n), y(n));
          k2 = h*f(t(n) + c2*h, y(n) + a21*k1);
          k3 = h*f(t(n) + c3*h, y(n) + a31*k1 + a32*k2);
          y(n+1) = y(n) + b1*k1 + b2*k2 + b3*k3;
       end
    end