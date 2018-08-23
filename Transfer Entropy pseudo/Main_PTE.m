
%% Pseudo Transfer entropy and Joint distribution values
clc
clear

N = 2000; l = 5;
x = randn(N,1);
y = [5*randn(l-1,1); 5*x(l:end,1)+0.05*randn(N-l+1,1)];

% x = sin(2*pi*0.01*(1:N))';
% y = sin(2*pi*0.01*(1:N) - 2*pi*0.01*l)';

plot(x); hold all; plot(y)
%%
numSurr = 20;
sx = IAAFT(x,numSurr);
sy = IAAFT(y,numSurr);

%% Joint Entropy
h = 1;
nbins = 10;

p_x_yh = Kernel_Estimator([x(1:N-h),y(h+1:end)],nbins);
JE = p_x_yh.*log(p_x_yh);
JE(isnan(JE))=0;
JE(isinf(JE))=0;

JE_metric(h) = sum(sum(JE));


% JE surrogates
for k=1:numSurr
    p_x_y_surr = Kernel_Estimator([sx(1:N-h,k),sy(h+1:end,k)],nbins);
    JE_surr = p_x_y_surr.*log(p_x_y_surr);
    JE_surr(isnan(JE_surr)) = 0;
    JE_surr(isinf(JE_surr)) = 0;
    
    JE_metric_surr(k) = sum(sum(JE_surr));
end

JE_mu = mean(JE_metric_surr);
JE_std = std(JE_metric_surr);

%
S_je = (JE_metric - JE_mu)/(JE_std);

%% Pseudo TE
p_yh = sum(p_x_yh);
p_x = sum(p_x_yh,2);
TE = p_x_yh.*log((p_x_yh./p_x)./p_yh);
TE(isnan(TE))=0; TE(isinf(TE)) = 0;
TE_metric = sum(sum(TE));

% JE surrogates
for k=1:numSurr
    p_x_y_surr = Kernel_Estimator([sx(1:N-h,k),sy(h+1:end,k)],nbins);
    p_y_surr = sum(p_x_y_surr);
    p_x_surr = sum(p_x_y_surr,2);
    TE_surr = p_x_y_surr.*log((p_x_y_surr./p_x_surr)./p_y_surr);
    TE_surr(isnan(TE_surr)) = 0;
    TE_surr(isinf(TE_surr)) = 0;
    
    TE_metric_surr(k) = sum(sum(TE_surr));
end

TE_mu = mean(TE_metric_surr);
TE_std = std(TE_metric_surr);

%
S_te = (TE_metric - TE_mu)/(TE_std);

%% Joint entropy for different values of h
subplot(2,1,1)
for h = 1:10
p_x_yh = Kernel_Estimator([x(1:N-h,1),y(h+1:end,1)],nbins);
JE = p_x_yh.*log(p_x_yh);
JE(isnan(JE))=0;
JE(isinf(JE))=0;

JE_metric_h(h) = sum(JE(:));
end

plot(1:h,JE_metric_h,'LineWidth',1.5)