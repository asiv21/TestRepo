function [pdf_Data, sigma] = Kernel_Estimator(Data,n,sigma)

c   = 0.2;

N_vars = size(Data,2);
N_samples = size(Data,1);

Data_min  = min(Data) ;
Data_max  = max(Data) ;
Data_cov  = cov(Data);

if nargin < 3
    sigma   = round(c*(N_samples^(-0.2))*det(Data_cov)*n);
end

if sigma == 0
    sigma = 2;
end

ki  = round((n-1)*(Data - repmat(Data_min,N_samples,1))./(repmat(Data_max,N_samples,1) - repmat(Data_min,N_samples,1))) + 1;

K = zeros([N_samples,n+(2*sigma)]);

a = sum((1/(sigma*sqrt(pi)))*exp(-((-sigma:sigma).^2)/(sigma^2)));

if N_vars == 1
    
    for jdx = 1:N_samples
        K(jdx,ki(jdx):ki(jdx)+ 2*sigma) = (1/(a*sigma*sqrt(pi)))*exp(-((-sigma:sigma).^2)/(sum(sigma.^2)/N_vars));
    end
    
    pdf_Data1 = (1/N_samples)*sum(K);
    pdf_Data = squeeze(pdf_Data1);
        
elseif N_vars == 2
    
    for jdx = 1:N_samples
        for idx = 0:2*sigma
            K(jdx,ki(jdx,1)+idx,ki(jdx,2):ki(jdx,2)+2*sigma) = (1/(a*sigma*sqrt(pi))^N_vars)*exp(-(((idx-sigma).^2) + ((-sigma:sigma).^2))/(sigma.^2));
        end
    end
    
    pdf_Data1 = (1/N_samples)*sum(K);
    pdf_Data = squeeze(pdf_Data1);
        
elseif N_vars == 3
    
    for jdx = 1:N_samples
        for idx = 0:2*sigma
            for mdx = 0:2*sigma
                K(jdx,ki(jdx,1)+idx,ki(jdx,2)+mdx, ki(jdx,3):ki(jdx,3)+ 2*sigma) = (1/(a*sigma*sqrt(pi))^N_vars)*exp(-(((idx-sigma).^2)+ ((mdx-sigma).^2) + ((-sigma:sigma).^2))/(sigma.^2));
            end
        end
    end
    
    pdf_Data1 = (1/N_samples)*sum(K);
    pdf_Data = squeeze(pdf_Data1);
        
elseif N_vars == 4
    
    for jdx = 1:N_samples
        for idx = 0:2*sigma
            for mdx = 0:2*sigma
                for ndx = 0:2*sigma
                    K(jdx,ki(jdx,1)+idx,ki(jdx,2)+mdx,ki(jdx,3)+ndx, ki(jdx,4):ki(jdx,4)+ 2*sigma) = (1/(a*sigma*sqrt(pi))^N_vars)*exp(-(((idx-sigma).^2)+ ((mdx-sigma).^2)+ ((ndx-sigma).^2)  + ((-sigma:sigma).^2))/(sigma.^2));
                end
            end
        end
    end
    
    pdf_Data1 = (1/N_samples)*sum(K);
    pdf_Data = squeeze(pdf_Data1);
        
elseif N_vars == 5
    
    for jdx = 1:N_samples
        for idx = 0:2*sigma
            for mdx = 0:2*sigma
                for ndx = 0:2*sigma
                    for ldx = 0:2*sigma
                        K(jdx,ki(jdx,1)+idx,ki(jdx,2)+mdx,ki(jdx,3)+ndx,ki(jdx,4)+ldx, ki(jdx,5):ki(jdx,5)+ 2*sigma) = (1/(a*sigma*sqrt(pi))^N_vars)*exp(-(((idx-sigma).^2)+ ((mdx-sigma).^2)+ ((ndx-sigma).^2) + ((ldx-sigma).^2) + ((-sigma:sigma).^2))/(sigma.^2));
                    end
                end
            end
        end
    end
    
    pdf_Data1 = (1/N_samples)*sum(K);
    pdf_Data = squeeze(pdf_Data1);
        
end

end








