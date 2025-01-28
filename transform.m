function T=transform(v,c,d)
min_v=min(v);
max_v=max(v);
f=@(t,a,b,c,d)((d-c)/(b-a))*(t-a)+c; %will map the interval [𝑎,𝑏] onto [c,d]
T=f(v,min_v,max_v,c,d);
end

