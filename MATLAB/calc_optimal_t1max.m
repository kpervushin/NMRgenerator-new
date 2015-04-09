function calc_optimal_t1max(R2eff, NI, fact, Jc)
% calc_optimal_t1max(10.0, 24 , 2.5)
%NI = 24;
%R2eff = 10.0;
%fact = 2.5;
k=1;
[res(k),snt(k),t1max(k)]=calc_sn_resolution('cs_evolution_0.04.txt', floor(11 + k^fact), 0.0005, R2eff, Jc);
divSnt(k) = 0;
divRes(k) = 0;
divResSnt(k) = 0;
SntRes(k)=snt(k)/res(k);

for k=2:NI
    [res(k),snt(k),t1max(k)]=calc_sn_resolution('cs_evolution_0.04.txt', floor(11 + k^fact), 0.0005, R2eff, Jc);
    divSnt(k) = (snt(k)-snt(k-1))/(t1max(k)-t1max(k-1));
    divRes(k) = (res(k)-res(k-1))/(t1max(k)-t1max(k-1));
    divResSnt(k) = (res(k)-res(k-1))/(snt(k)-snt(k-1));
    SntRes(k)=snt(k)/res(k);
end %for k=1:td
%plot(snt,res)
%plot(divResSnt,t1max)
plot(t1max,SntRes)

disp(['R2eff (s-1), ' num2str(R2eff) ', DeltaNu(min) (Hz), '  num2str(R2eff/3.14159)])
for k=1:NI
disp(['Snt, '  num2str(snt(k))  ', Res (Hz), '  num2str(res(k)) ', Snt/Res, '  num2str(SntRes(k))  ', t1max, '  num2str(t1max(k))])
end
end %function