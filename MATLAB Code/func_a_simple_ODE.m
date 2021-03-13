%% Homework Assignment - 4 by Tushar Goel** %%
% Taking reference from the example given in the assignment %
function func_a_simple_ODE()
    close all;

    % time vector
    t = 0:0.01:2;

    % initial states
    x_10 = 0;
    x_20 = 0;

    % parameters
    r = 30;
    Jm = 0.001;
    Jl = Jm;
    M = 0.1;
    g = 9.81;
    l = 0.1;
    u = 0.1;
    Bl = [0.001, 0.01, 0.1, 1];
    Bm= Bl;

    % Figure Representation and Display
    fh1 = figure('Name', 'A simple ODE(x1)');
    ah1 = axes('parent',fh1);
    hold(ah1,'on');
    xlabel(ah1,'time');
    fh2 = figure('Name', 'A simple ODE(x2)');
    ah2 = axes('parent',fh2);
    hold(ah2,'on');
    xlabel(ah2,'time');

    % Relations
    beta = M*g*l/(Jm*r^2+Jl);
    alpha_vector = (Bm*r+Bl)/(Jm*r^2+Jl);


    for i = 1:4
        alpha = alpha_vector(i);
        % solving ODE
        [t,x]=ode45(@func,t,[x_10,x_20]);
        % plotting solutions
        figure(1)
        plot(ah1,t,x(:,1));
        title('A simple ODE (x1)');
        figure(2)
        plot(ah2,t,x(:,2));
        title('A simple ODE (x2)');
    end

% function
    function dxdt=func(t,x)
        dx1 = x(2);
        dx2 = - alpha*x(2) - beta*sin(x(1)) + u;
        dxdt = [dx1;dx2];
    end
end