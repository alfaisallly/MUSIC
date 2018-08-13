clear all
close all
N= 100;

m=3; % array elemnt
t1=50;
t2=10;

%%% Steering Vector
d1=1;d2=2;d3=3;
a1 = [exp(d1*1i*pi*sind(t1)) exp(d2*1i*pi*sind(t1)) exp(d3*1i*pi*sind(t1))]';
a2 = [exp(d1*1i*pi*sind(t2)) exp(d2*1i*pi*sind(t2)) exp(d3*1i*pi*sind(t2))]';
A = [a1 a2 ];

sig_s= 1; sig_n=.1; %snr = 10*log10(sig_s/sig_n);

S =sig_s * randn(2,N);
%p=[1 .9; .9 1 ];
p=[1 0; 0 1 ];
s=sqrtm(p) * S;
n = sig_n .* (rand(m,N)+1i * rand(m,N));
%%%%%% recived signal
X = A * s + n;










%%% Music algorithm
R = X*X'/N ; % estimation of covarianc

[V,D] = eig(R);
[lambda,idx] = sort(diag(D)); % Vector of sorted eigenvalues
V = V(:,idx); % Sort eigenvalues accordingly
Vn = V(:,1); % Noise eigenvectors (ASSUMPTION: m IS KNOWN)

wSrch = (-100:100)';
aSrch = [exp(d1*1i.*pi*sind(wSrch)) exp(d2*1i.*pi*sind(wSrch)) exp(d3*1i.*pi*sind(wSrch)) ];

% MUSIC spectrum
Z=zeros(1,201);
for i = 1:201

Z(i)=norm(aSrch(i,:)*Vn,2);%bb * bb';
end


plot(wSrch,1./Z)

ylabel('Magnitude ');
xlabel(' Angle(Degree) ');
