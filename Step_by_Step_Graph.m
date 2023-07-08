clear all
close all 
rng('default') 

G_a = [
    0, 1, 0, 0, 0;
    1, 0, 1, 1, 0;
    0, 1, 0, 1, 0;
    0, 1, 1, 0, 1;
    0, 0, 0, 1, 0
];

D{1} = [1, 0, 0, 0, 0]';
D{2} = [0.2, 0.2, 0.2, 0.2, 0.2]';
I = eye(5);

for i = 1:5
    beta = zeros(5,1);
    beta(i) = 1;
    B{1}(:,:,i) = G_a  .*  beta + I - I  .*  G_a(i,:);
end

B{2}(:,:,1) = eye(5);

A{1}=zeros(3,5,5);
for lv = 1:5
    for la = 1:5
        if la == lv
            A{1}(:,la,lv) = [1 0 0]';
        elseif G_a(la, lv) == 1
            A{1}(:, la, lv) = [0, 0.5, 0.5]';
        else
            A{1}(:, la, lv) = [0, 0, 1]';
        end
    end
end

C{1}=[1 0 0]';

mdp.T = 4;                      
mdp.A = A;                     
mdp.B = B;        
mdp.C = C; 
mdp.D = D;                   
mdp.erp = 1;
mdp.Aname = {'VictimObservation'};
mdp.Bname = {'AgentLocation', 'VictimLocation'};

mdp_checked = spm_MDP_check(mdp);
MDP = spm_MDP_VB_X_tutorial(mdp_checked);
spm_figure('GetWin','Figure 1'); clf    % display behavior
spm_MDP_VB_LFP(MDP); 
spm_figure('GetWin','Figure 2'); clf    % display behavior
spm_MDP_VB_trial(MDP); 

%N = 4; % number of trials
%mdp_checked = spm_MDP_check(mdp);
%MDP = mdp_checked;
%[MDP(1:N)] = deal(MDP);
%MDP = spm_MDP_VB_X_tutorial(MDP);




