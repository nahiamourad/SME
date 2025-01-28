function [CI]=lingu_Mat(C,I)
CI=cell(size(C));
n=size(I,1);
for i=1:n
    CI(C==i)={I(i,:)};
end