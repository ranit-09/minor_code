
import random

# Objective Function (Booth Function)
def objective(x, y):
    return (x + 2*y - 7)**2 + (2*x + y - 5)**2

# PSO Parameters
num_particles = 10
max_iterations = 50

w = 0.7
c1 = 2.0
c2 = 2.0

lower_bound = -10
upper_bound = 10

# Initialize particles
positions = []
velocities = []

pbest_positions = []
pbest_values = []

# Random initialization
for i in range(num_particles):

    x = random.uniform(lower_bound, upper_bound)
    y = random.uniform(lower_bound, upper_bound)

    positions.append([x, y])

    velocities.append([0, 0])

    pbest_positions.append([x, y])
    pbest_values.append(objective(x, y))

# Find Global Best
gbest_index = pbest_values.index(min(pbest_values))

gbest_position = pbest_positions[gbest_index].copy()
gbest_value = pbest_values[gbest_index]

# Main PSO Loop
for iteration in range(max_iterations):

    for i in range(num_particles):

        for j in range(2):

            r1 = random.random()
            r2 = random.random()

            # Velocity Update
            velocities[i][j] = (
                w * velocities[i][j]
                + c1 * r1 * (
                    pbest_positions[i][j] - positions[i][j]
                )
                + c2 * r2 * (
                    gbest_position[j] - positions[i][j]
                )
            )

            # Position Update
            positions[i][j] += velocities[i][j]

            # Boundary Check
            positions[i][j] = max(
                lower_bound,
                min(positions[i][j], upper_bound)
            )

        # Calculate Fitness
        fitness = objective(
            positions[i][0],
            positions[i][1]
        )

        # Update Personal Best
        if fitness < pbest_values[i]:

            pbest_values[i] = fitness
            pbest_positions[i] = positions[i].copy()

        # Update Global Best
        if fitness < gbest_value:

            gbest_value = fitness
            gbest_position = positions[i].copy()

    print(
        "Iteration:", iteration + 1,
        "Best x =", round(gbest_position[0], 4),
        "Best y =", round(gbest_position[1], 4),
        "Fitness =", round(gbest_value, 6)
    )

# Final Solution
print("\nFinal Solution")

print("x =", gbest_position[0])
print("y =", gbest_position[1])

print("f(x,y) =", gbest_value)
