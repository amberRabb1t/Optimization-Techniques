close all;
clear;
clc;

% Set random seed for reproducibility
rng(1);

% Range of input variables
MinU1 = -1;
MaxU1 = 2;
MinU2 = -2;
MaxU2 = 1;

% Range of variances in the Gaussian Functions
MinSigma = 0.05;
MaxS1 = MaxU1 - MinU1;
MaxS2 = MaxU2 - MinU2;

% Parameter bounds determined by the above
Minimums = [-1, MinU1, MinSigma, MinU2, MinSigma, 0];
Maximums = [1, MaxU1, MaxS1, MaxU2, MaxS2, 1];
Bounds = [Minimums; Maximums];

% Genetic Algorithm parameters
NumberOfGaussianFunctions = 15;
NumberOfParameters = 6;
PopulationSize = 200;
NumberOfGenerations = 1000;
NumberOfDatapoints = 10000;

% Population initialization
Population = zeros(NumberOfGaussianFunctions, NumberOfParameters, PopulationSize, NumberOfGenerations + 1);
% Coefficients of the Gaussian Functions
Population(:,1,:,1) = -1 + 2*rand(NumberOfGaussianFunctions, PopulationSize);
% Variances
Population(:,3,:,1) = 0.5*ones(NumberOfGaussianFunctions, PopulationSize);
Population(:,5,:,1) = 0.5*ones(NumberOfGaussianFunctions, PopulationSize);
% Activation Variables
Population(:,6,:,1) = ones(NumberOfGaussianFunctions, PopulationSize);

% Accuracy metrics
MSE = zeros(PopulationSize, NumberOfGenerations + 1);
Fitness = zeros(PopulationSize, NumberOfGenerations + 1);

% Actual function to estimate
syms f(u1,u2);
f(u1,u2) = sin(u1+u2)*sin(u2^2);
% Used to derive input-output data to measure against
U1 = MinU1 + (MaxU1-MinU1)*rand(1, NumberOfDatapoints);
U2 = MinU2 + (MaxU2-MinU2)*rand(1, NumberOfDatapoints);
Y = double(subs(f, {u1,u2}, {U1,U2}));

% Execution of Genetic Algorithm
for i=1:NumberOfGenerations
    % Evaluate the fitness of the current population
    [MSE(:,i), Fitness(:,i)] = EvaluateFitness(U1, U2, Population(:,:,:,i), Y);
    % Generate new individuals for the next generation
    Population(:,:,:,i+1) = GenerateNewIndividuals(Population(:,:,:,i), Fitness(:,i), Bounds);
end
% Compute fitness of final generation
[MSE(:, NumberOfGenerations + 1), Fitness(:, NumberOfGenerations + 1)] = EvaluateFitness(U1, U2, Population(:,:,:, NumberOfGenerations + 1), Y);

% Change to different and larger dataset for plotting and best-MSE testing
[NewU1, NewU2] = meshgrid(MinU1:0.01:MaxU1, MinU2:0.01:MaxU2);
NewY = double(subs(f, {u1,u2}, {NewU1,NewU2}));

% Plot actual function
surf(NewU1, NewU2, NewY);
title('f(u1,u2)', FontSize=14);
xlabel('u1', FontSize=15, FontWeight='bold');
ylabel('u2', FontSize=15, FontWeight='bold');
zlabel('y', FontSize=15, FontWeight='bold', Rotation=0);
colorbar;

% Plot estimated function
[~, BestGeneration] = min(min(MSE));
[~, BestIndividual] = min(MSE(:, BestGeneration));
BestParameters(:,:) = Population(:, :, BestIndividual, BestGeneration);
EstY = 0;
for i=1:NumberOfGaussianFunctions
    EstY = EstY + BestParameters(i,6)*BestParameters(i,1) * ...
        exp(-((NewU1-BestParameters(i,2)).^2/(2*BestParameters(i,3)^2) + ...
        (NewU2-BestParameters(i,4)).^2/(2*BestParameters(i,5)^2)));
end
figure;
surf(NewU1, NewU2, EstY);
title('Estimated f(u1,u2)', FontSize=14);
xlabel('u1', FontSize=15, FontWeight='bold');
ylabel('u2', FontSize=15, FontWeight='bold');
zlabel('y', FontSize=15, FontWeight='bold', Rotation=0);
colorbar;

% Plot trimmed estimated function
TrimmedBestParameters = BestParameters(abs(BestParameters(:,1)) > 0.05, :);
TrimmedEstY = 0;
for i=1:size(TrimmedBestParameters, 1)
    TrimmedEstY = TrimmedEstY + TrimmedBestParameters(i,6)*TrimmedBestParameters(i,1) * ...
        exp(-((NewU1-TrimmedBestParameters(i,2)).^2/(2*TrimmedBestParameters(i,3)^2) + ...
        (NewU2-TrimmedBestParameters(i,4)).^2/(2*TrimmedBestParameters(i,5)^2)));
end
figure;
surf(NewU1, NewU2, TrimmedEstY);
title('Trimmed Estimated f(u1,u2)', FontSize=14);
xlabel('u1', FontSize=15, FontWeight='bold');
ylabel('u2', FontSize=15, FontWeight='bold');
zlabel('y', FontSize=15, FontWeight='bold', Rotation=0);
colorbar;

% Plot MSE over generations
figure;
plot(1:NumberOfGenerations+1, min(MSE));
xlim([0 round(1.0025*(NumberOfGenerations+1))]);
xlabel("Generation");
ylabel("MSE");
title("Generation vs Mean Squared Error");

% Show best parameters
ToDisplay = [(1:NumberOfGaussianFunctions).' BestParameters];
ToDisplay = array2table(ToDisplay, "VariableNames", ...
    ["Gaussian Function","Coefficient","C1","S1","C2","S2","Activation Variable"]);
Fig = figure;
Uit1 = uitable(Fig, "ColumnWidth", "auto", "Data", ToDisplay, "Position", [500 500 760 353]);
s = uistyle("HorizontalAlignment", "left");
addStyle(Uit1, s);

% Show trimmed best parameters, omitting Gaussians with Activation Variable 0
TrimmedToDisplay = TrimmedBestParameters(TrimmedBestParameters(:,6) == 1, :);
TrimmedToDisplay(:, end) = [];
TrimmedToDisplay = [(1:size(TrimmedToDisplay, 1)).' TrimmedToDisplay];
TrimmedToDisplay = array2table(TrimmedToDisplay, "VariableNames", ...
    ["Gaussian Function","Coefficient","C1","S1","C2","S2"]);
Uit2 = uitable(Fig, "ColumnWidth", "auto", "Data", TrimmedToDisplay, "Position", [1300 500 652 353]);
addStyle(Uit2, s);

% Check best generalized accuracy
[BestMSE, BestFitness] = EvaluateFitness(NewU1, NewU2, BestParameters(:,:), NewY);
fprintf("The best solution is Individual %d in Generation %d.\nMSE: %f\nFitness: %f\n\n", ...
    BestIndividual, BestGeneration, BestMSE, BestFitness);

% Check best trimmed generalized accuracy
[TrimmedBestMSE, TrimmedBestFitness] = EvaluateFitness(NewU1, NewU2, TrimmedBestParameters(:,:), NewY);
fprintf("And now the trimmed version.\nMSE: %f\nFitness: %f\n", ...
    TrimmedBestMSE, TrimmedBestFitness);
