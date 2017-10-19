function [a,b] = fit_exp(t,y,T)
%% This function fits the time unit for the first T units
%% Eventually, we want to arrive at the exponential decay y=b*e^-at(b is approximately 1 )
ind_arr=find(t<T);
t_pick=t(ind_arr)';
y_pick=y(ind_arr)';
y_log=log(y_pick);
p=polyfit(t_pick,y_log,1);
% plot(t,y,'o');
% hold on;
% plot(f,t_pick,y_pick);
b=exp(p(2));
a=-p(1);
dt=t_pick(2)-t_pick(1);
t_fit=t_pick(1):dt/10:t_pick(end);
y_fit=b*exp(-a*t_fit);
figure;
plot(t_pick,y_pick,'ro','markersize',7)
hold on;
plot(t_fit,y_fit,'b-','linewidth',4)
legend('ori','fit')
end

