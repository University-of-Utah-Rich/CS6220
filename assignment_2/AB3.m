function [tvec,yvec] = AB3(t0,y0,y1,f,h,N)
    % [tvec,yvec] = AB3(t0,y0,y1,f,h,N)
    % Adams-Bashforth 3rd-order method
    % Inputs
    % t0,y0: initial condition
    % y1:    additional start-up value
    % f:     names of the right-hand side function f(t,y)
    % h:     stepsize
    % N:     number of steps
    % Outputs
    % tvec: vector of t values
    % yvec: vector of corresponding y values
    
    yvec = zeros(N+1,1);
    tvec = linspace(t0,t0+N*h,N+1)';
    yvec(1) = y0;
    yvec(2) = y1;
    for n=1:N-2
       fvalue1 = f(tvec(n),yvec(n));
       fvalue2 = f(tvec(n+1),yvec(n+1));
       fvalue3 = f(tvec(n+2),yvec(n+2));
       yvec(n+2) = yvec(n+1)+h/2*(3*fvalue2-fvalue1);
       yvec(n+3) = yvec(n+2)+h/12*(23*fvalue3-16*fvalue2+5*fvalue1);
    end