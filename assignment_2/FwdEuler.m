function x = FwdEuler( f, x0, t0, tf, dt )
    % FwdEuler( f, x0, t0, tf, h )
    % f: function handle for the ODE
    % x0: initial condition
    %     Default: 0
    % t0: initial time
    %     Default: 0
    % tf: final time
    %     Default: 1
    % dt: step size
    %     Default: 0.01


        % Set default values if arguments are not provided
        if nargin < 5
            dt = 0.01; % Default step size
        end
        if nargin < 4
            tf = 1; % Default final time
        end
        if nargin < 3
            t0 = 0; % Default initial time
        end
        if nargin < 2
            x0 = 0; % Default initial condition
        end
    

    t = t0:dt:tf;
    x = zeros(length(t) );
    x(1) = x0; % initial condition
    for n = 1:length(t)-1
        x(:,n+1) = x(:,n) + dt*f(t(n),x(:,n));
    end
end