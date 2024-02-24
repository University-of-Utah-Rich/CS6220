% {
% [y^(n+1)~~y^(n)+(Delta t)/(2)(k_(1)+k_(2))","],[k_(1)=f(t_(n),y^(n))","],[k_(2)=f(t_(n)+h,y_(n)+Delta tk_(1)).]
% }



function y = rk2(t0, tf, y0, f, h)
   % 2nd order Runge-Kutta method for solving ODEs
   % Explicit using Fwd Euler
   %
   % Syntax: y = rk2(t0, tf, y0, f, h)
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
      y(1) = y0;
      for n = 1:length(t)
         k1 = h*f(t(n), y(n));
         k2 = h*f(t(n) + h, y(n) + h*k1);
         y(n+1) = h/2*(k1 + k2) + y(n);
      end
   end

