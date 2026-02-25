function NewIndividuals = GenerateNewIndividuals(Population, Fitness, Bounds)
    NumberOfGaussianFunctions = size(Population, 1);
    NumberOfParameters = size(Population, 2);
    PopulationSize = size(Population, 3);
    NewIndividuals = zeros(NumberOfGaussianFunctions, NumberOfParameters, PopulationSize);
    
    % For Roulette Wheel Selection
    CDF = cumsum(Fitness / sum(Fitness));

    for i=1:2:PopulationSize
        % Select two random members of the population to be potential parents
        Parent1 = Population(:, :, find(rand <= CDF, 1));
        Parent2 = Population(:, :, find(rand <= CDF, 1));

        % Crossover
        if (rand < 0.8)
            alpha = -0.5 + 2*rand(NumberOfGaussianFunctions, NumberOfParameters);
            Child1 = min(max(alpha.*Parent1 + (1-alpha).*Parent2, Bounds(1,:)), Bounds(2,:));
            Child2 = min(max(alpha.*Parent2 + (1-alpha).*Parent1, Bounds(1,:)), Bounds(2,:));
            Child1(:,6) = round(Child1(:,6));
            Child2(:,6) = round(Child2(:,6));
        else
            % If the Crossover does not occur, the individuals pass to the next generation as they are
            NewIndividuals(:,:,i) = Parent1;
            NewIndividuals(:,:,i+1) = Parent2;
            continue
        end

        % Mutation
        if (rand < 0.05)
            Child1 = min(max(Child1 + randn(NumberOfGaussianFunctions, NumberOfParameters), Bounds(1,:)), Bounds(2,:));
            Child2 = min(max(Child2 + randn(NumberOfGaussianFunctions, NumberOfParameters), Bounds(1,:)), Bounds(2,:));
            Child1(:,6) = round(Child1(:,6));
            Child2(:,6) = round(Child2(:,6));
        end

        % Store the new individuals in the population
        NewIndividuals(:,:,i) = Child1;
        NewIndividuals(:,:,i+1) = Child2;
    end
end
