
clc;
clear;
close all;

% Objective Function (Booth Function)
objective = @(x,y) (x+2*y-7)^2 + (2*x+y-5)^2;

% PSO Parameters
num_particles = 10;
max_iterations = 50;

w = 0.7;       % Inertia weight
c1 = 2.0;      % Cognitive coefficient
c2 = 2.0;      % Social coefficient

lower_bound = -10;
upper_bound = 10;

% Initialize particles
positions = lower_bound + ...
    (upper_bound-lower_bound)*rand(num_particles,2);

velocities = zeros(num_particles,2);

% Initialize Personal Best
pbest_positions = positions;
pbest_values = zeros(num_particles,1);

for i = 1:num_particles
    pbest_values(i) = objective(positions(i,1),positions(i,2));
end

% Initialize Global Best
[gbest_value, index] = min(pbest_values);

gbest_position = pbest_positions(index,:);

% Main PSO Loop
for iteration = 1:max_iterations

    for i = 1:num_particles

        for j = 1:2

            r1 = rand();
            r2 = rand();

            % Velocity Update
            velocities(i,j) = ...
                w*velocities(i,j) ...
                + c1*r1*(pbest_positions(i,j)-positions(i,j)) ...
                + c2*r2*(gbest_position(j)-positions(i,j));

            % Position Update
            positions(i,j) = positions(i,j) + velocities(i,j);

            % Boundary Check
            positions(i,j) = max(lower_bound, ...
                min(positions(i,j),upper_bound));

        end

        % Calculate Fitness
        fitness = objective(positions(i,1),positions(i,2));

        % Update Personal Best
        if fitness < pbest_values(i)

            pbest_values(i) = fitness;
            pbest_positions(i,:) = positions(i,:);

        end

        % Update Global Best
        if fitness < gbest_value

            gbest_value = fitness;
            gbest_position = positions(i,:);

        end

    end

    % Display Iteration Results
    fprintf('Iteration: %d | x = %.4f | y = %.4f | Fitness = %.8f\n', ...
        iteration, gbest_position(1), ...
        gbest_position(2), gbest_value);

end

% Final Solution
fprintf('\nFinal Solution\n');

fprintf('Optimal x = %.6f\n',gbest_position(1));
fprintf('Optimal y = %.6f\n',gbest_position(2));
fprintf('Minimum Fitness = %.10f\n',gbest_value);
