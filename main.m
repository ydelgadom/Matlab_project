% clean all variables and start timer
clear all
close all
tic

% Model parameters
leng = 6;

mu=0;
kappa=0.01;
tau=0.25;

% MC simulation parameters
plot0 = 50;
plot1 = 20;

% Create lattice arrays
lat = latticeVector(leng);
initLattice(lat);

% Calculate monomer and dimer weights
initWeights(lat,tau,kappa,mu);

% equilibration (do not plot anything)
for im = 1:plot0
    worm(lat,0);
end

% Create figure
fig = figure('Name','Worm Update','NumberTitle','off');
hold on;
% Set the size of the window
scrsz = get(0,'ScreenSize');
%left bottom width height
set(fig,'Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
title (['\tau = ',num2str(tau),'; \mu = ',num2str(mu),...
    '; \kappa = ',num2str(kappa)]);
view(-16,8), axis vis3d;
axis square;
rotate3d on;
axis off;
plotLattice(lat);

% worm that will be ploted 
for im = 1:plot1
    worm(lat,1);
    pause(0.5);
    refreshLattice(lat);
end

% finish adding plots to figure "fig"
hold off;

% print time
toc