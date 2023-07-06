clear all
close all 
rng('default') 

Nf = 3;
Nu = [5 3 2];
for f = 1:Nf
    u = 1;
    for i = 1:Nf
        if i == f
            u = kron(1:Nu(i),u);
        else
            u = kron(ones(1,Nu(i)),u);
        end
    end
    MDP.U(:,f)  = u;
end