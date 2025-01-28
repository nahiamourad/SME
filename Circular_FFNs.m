function [EDM_C_FFNs]=Circular_FFNs(EDM_ling)

[n, m]=size(EDM_ling);

EDM_ling_Mat=cell2mat(EDM_ling);
mu_nu=nthroot(mean(EDM_ling_Mat.^3),3);

me=repmat(mu_nu,n,1);
me=abs(me-EDM_ling_Mat).^3;
ii=2:2:2*m;
ss=[];
for i1=1:m
    ss=[ss sum(me(:,ii(i1)-1:ii(i1)),2)];
end
r=min(max(ss.^0.3),1);
mu_nu=reshape(mu_nu,2,[])';
A=[mu_nu,r'];
EDM_C_FFNs=mat2cell(A, ones(1, size(A, 1)), size(A, 2));
end