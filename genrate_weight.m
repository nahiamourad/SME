function [Ws,e_c]=genrate_weight(w,ns)
eps=0.00001;
m=length(w);
e_c=w./(1-max(w));
[~,j0]=max(w);

delta=zeros(ns,1);
for i=1:ns
delta(i)=(i-1)/(ns-1)-w(j0);
end

Ws=zeros(ns,m);
for i=1:ns-1
  Ws(i,:)=w-delta(i)*e_c;
end
Ws(ns,:)=eps*ones(1,m);

Ws(:,j0)=0 ;
Ws(:,j0)=1-sum(Ws,2);

Ws=[w;Ws];