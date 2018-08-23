function txy = Transfer_Entropy_Calc(xdata,ydata)

%% Rearranging data

global N  Maxlag
% N       = 2000; % Length of data set required;

n   = 10;
h   = 1;
tau = 1;

% if nargin < 3
%     n       = 10;  % Normalization factor used to normalize data ([min max] to [1 n])  
%     [xycorr, lags] = crosscorr(xdata,ydata,Maxlag);
%     tau     = abs(lags(xycorr == max(xycorr(lags>=0)))); % Time frame in the past
%     h       = tau; % Prediction horizon (Time frame in the future)
% elseif nargin < 4
%     [xycorr, lags] = crosscorr(xdata,ydata,Maxlag);
%     tau     = abs(lags(xycorr == max(xycorr(lags>=0)))); % Time frame in the past
%     h       = tau; % Prediction horizon (Time frame in the future)
% elseif nargin < 5
%     [xycorr, lags]  = crosscorr(xdata,ydata,Maxlag);
%     h               = abs(lags(xycorr == max(xycorr(lags>=0)))); % Time frame in the past
% end

xi      = xdata(end-N-h+1:end-h);
yi      = ydata(end-N-h+1:end-h);
yi_dt   = ydata(end-N-h-tau+1:end-h-tau);
xi_h    = xdata(end-N+1:end);


%% Pdf and joint pdf estimation using kernals

[pdf_xxyy, sigma]   = Kernel_Estimator([xi_h,xi,yi,yi_dt],n);

[pdf_xyy, ~]        = Kernel_Estimator([xi,yi,yi_dt],n, sigma);

[pdf_xx, ~]         = Kernel_Estimator([xi_h,xi],n, sigma);

[pdf_x, ~]          = Kernel_Estimator(xi,n, sigma);

%% Conditional probability estimation
nbins       = n + 2*sigma;

pdf_xyy2(1,:,:,:)    = pdf_xyy;
cpdf_xxyy   = pdf_xxyy./repmat(pdf_xyy2,nbins,1,1,1);

cpdf_xx     = pdf_xx./repmat(pdf_x,nbins,1);

%% Transfer entropy calculation

Tr_matrix   =  pdf_xxyy.*log(cpdf_xxyy./cpdf_xx);

Tr_matrix(isnan(Tr_matrix) | isinf(Tr_matrix)) = 0;

txy         = sum(sum(sum(sum(Tr_matrix))));

end