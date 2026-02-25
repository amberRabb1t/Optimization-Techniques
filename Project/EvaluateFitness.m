function [MSE, FitnessValue] = EvaluateFitness(Input1, Input2, Population, Target)
    PopulationSize = size(Population, 3);
    MSE = zeros(1, PopulationSize);
    FitnessValue = zeros(1, PopulationSize);
    for i=1:PopulationSize
        Result = 0;
        for j=1:size(Population, 1)
            Result = Result + Population(j,6,i)*Population(j,1,i) * ...
                exp(-((Input1-Population(j,2,i)).^2/(2*Population(j,3,i)^2) + ...
                (Input2-Population(j,4,i)).^2/(2*Population(j,5,i)^2)));
        end
        SE = (Target - Result).^2;
        MSE(i) = sum(SE(:)) / numel(SE);
        FitnessValue(i) = 1 / (MSE(i)^2.642 + 10^(-13));
    end
end
