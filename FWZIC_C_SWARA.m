function [w,EDM_ling,EDM_C_FFNs,Score]=FWZIC_C_SWARA(EDM,Fuzzy)
epsilon=10^-5;
%% Fuzzification of the EDM
EDM_ling=lingu_Mat(EDM,Fuzzy(:,2:3));

%%Construct Circular Fermatean Fuzzy Numbers
EDM_C_FFNs=Circular_FFNs(EDM_ling);

%%Calculate score than project on [0,1]
Score=score_CFFN(cell2mat(EDM_C_FFNs));
Score=transform(Score,epsilon,1);
results=swara(Score');
w=results(end,:);
w=w';%w is a column of weights
end