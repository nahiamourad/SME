clc
clear
%%Fermatean Fuzzy Numbers
FFNs=[1	0.85	0.2;
    2	0.7	    0.35;
    3	0.55	0.5;
    4	0.35	0.7;
    5	0.2	    0.85];

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Strategy
EDM=readmatrix("14.0Technologies FWZIC.xlsx",'Sheet','Sheet1','Range','B4:AE6');
Strategy=readmatrix("14.0Technologies FWZIC.xlsx",'Sheet','Sheet2','Range','B2:AE38');
[w_criteria,EDM_ling,EDM_C_FFNs,S_criteria]=FWZIC_C_SWARA(EDM,FFNs);
Strategy_weight=Strategy*w_criteria;
Strategy_rank=rankWithDuplicates(Strategy_weight)';

writematrix(cell2mat(EDM_ling),"14.0Technologies FWZIC.xlsx",'Sheet','Sheet1','Range','B24:BI26');
writematrix([cell2mat(EDM_C_FFNs),S_criteria,w_criteria],"14.0Technologies FWZIC.xlsx",'Sheet','Sheet1','Range','B31:F60');
writematrix([Strategy_weight,Strategy_rank],"14.0Technologies FWZIC.xlsx",'Sheet','Sheet2','Range','AG2:AH38');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Context Weight
C1=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B28:D30");
w1=FWZIC_C_SWARA(C1,FFNs);
C2=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B36:AB38");
w2=FWZIC_C_SWARA(C2,FFNs);
C3=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B44:CD46");
w3=FWZIC_C_SWARA(C3,FFNs);
C4=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B53:BI55");
w4=FWZIC_C_SWARA(C4,FFNs);

writematrix(w1',"Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B31:D31");
writematrix(w2',"Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B39:AB39");
writematrix(w3',"Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B47:CD47");
writematrix(w4',"Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B56:BI56");

W_final=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Criteria","Range","B69:DN69");
Context=readmatrix("Matrix TOE 18 Sep.xlsx","Sheet","Sheet1","Range","C4:DO40");
Context_weight=Context*W_final';
Context_rank=rankWithDuplicates(Context_weight)';
writematrix(Context_weight,"Matrix TOE 18 Sep.xlsx","Sheet","Sheet1","Range","DP4:DP40");
writematrix(Context_rank,"Matrix TOE 18 Sep.xlsx","Sheet","Sheet1","Range","DQ4:DQ40");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Sensitivity Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ns=9;
[w_criteria_stv,e_strategy]=genrate_weight(w_criteria',ns);
[Strategy_rank_stv,Strategy_weight_stv]=deal(zeros(size(Strategy,1),ns));
rho_Strategy=zeros(1,ns);
writematrix([w_criteria_stv;e_strategy],"14.0Technologies FWZIC.xlsx",'Sheet','sensitive','Range','B3:AE13');
for i =1:ns+1
    Strategy_weight_stv(:,i)=Strategy*w_criteria_stv(i,:)';
    Strategy_rank_stv(:,i)=rankWithDuplicates(Strategy_weight_stv(:,i))';
    rho_Strategy(i)=corr(Strategy_rank_stv(:,1),Strategy_rank_stv(:,i),'type','spearman');
end
writematrix([Strategy_rank_stv;rho_Strategy],"14.0Technologies FWZIC.xlsx",'Sheet','sensitive','Range','B18:K55');


[w_context_stv,e_context]=genrate_weight(W_final,ns);
writematrix([w_context_stv;e_context],"Matrix TOE 18 Sep.xlsx",'Sheet','sensitive','Range','B5:DN15');
[Context_weight_stv,Context_rank_stv]=deal(zeros(size(Context,1),ns));
rho_context=zeros(1,ns);
for i =1:ns+1
    Context_weight_stv(:,i)=Context*w_context_stv(i,:)';
    Context_rank_stv(:,i)=rankWithDuplicates(Context_weight_stv(:,i))';
    rho_context(i)=corr(Context_rank_stv(:,1),Context_rank_stv(:,i),'type','Spearman');

end
writematrix([Context_rank_stv;rho_context],"Matrix TOE 18 Sep.xlsx",'Sheet','sensitive','Range','B19:K56');
