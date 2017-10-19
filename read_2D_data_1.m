%% This script tries to read and plot data of the 1D case
clear
%%  first consider the name of the directory
err_bnd=1e-6;
N=32;
dir_name=['laplace_N_',num2str(N)];
ind=0;

%% plot x
name_string='R1_x';
size_sufx='size';
data_type='dat';

x=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);

name_string='R2_T_i';
size_sufx='size';
data_type='dat';

T_i=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);


name_string='R2_T_out';
size_sufx='size';
data_type='dat';
T_f=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);


name_string='R1_itr_dif';
size_sufx='size';
data_type='dat';
itr_dif=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);
%%
[X1,X2]=meshgrid(x,x);

%% flipud the data from reading
T_i=flipud(T_i);
T_f=flipud(T_f);
%% Evaludate the exact solution

f_exa= @(X,Y) (sinh(pi*X).*sin(pi*Y)+sinh(pi*Y).*sin(pi*X))/sinh(pi);
T_exa=f_exa(X1,X2);
T_err=T_f-T_exa;

%% evaluate the norm of the error matrix.
T_err_norm=abs(T_err(2:end-1,2:end-1));
err_norm_1=sum(sum(T_err_norm))/(N^2);
err_norm_2=sqrt(sum(sum(T_err_norm.^2))/(N^2));
err_norm_inf=max(max(T_err_norm));

%% plot 2D T
figure;
subplot(2,1,1)
pcolor(X1,X2,T_i);
title('initial T')
axis tight equal; shading interp
colorbar

subplot(2,1,2)
pcolor(X1,X2,T_f);
title('final T')
axis tight equal; shading interp
colorbar

%% plot the T exact
figure;
pcolor(X1,X2,T_exa);
title(['exact T when N=' num2str(N)]);
axis tight equal; shading interp
colorbar
AX=gca;
set(AX,'fontsize',15)
xlab=xlabel('$x$'); set(xlab,'interpreter','latex'); set(xlab,'fontsize',40)
ylab=ylabel('$y$'); set(ylab,'interpreter','latex'); set(ylab,'fontsize',40)
%% plot the T error
figure;
pcolor(X1,X2,T_err);
title(['error T,error of 1-norm= ',num2str(err_norm_1),',2-norm= ',num2str(err_norm_2),',inf-norm= ',num2str(err_norm_inf)]);
axis tight equal; shading interp
colorbar
AX=gca;
set(AX,'fontsize',15)
xlab=xlabel('$x$'); set(xlab,'interpreter','latex'); set(xlab,'fontsize',40)
ylab=ylabel('$y$'); set(ylab,'interpreter','latex'); set(ylab,'fontsize',40)
%% define contour level
v=0:0.05:1;
title_string=['when N= ',num2str(N),', err\_bound= ',num2str(err_bnd),',itr= ',num2str(length(itr_dif))];
%% plot 2D contour T
figure;
subplot(2,1,1)
[C1,h1] =contour(X1,X2,T_i,v);
set(h1,'fill','on')
set(h1,'showtext','off')
title(['contour of initial T, ',title_string]);
axis tight equal; shading interp
colorbar
% xlabel('x')
% ylabel('y')
xlab=xlabel('$x$'); set(xlab,'interpreter','latex'); set(xlab,'fontsize',40)
ylab=ylabel('$y$'); set(ylab,'interpreter','latex'); set(ylab,'fontsize',40)
subplot(2,1,2)
[C2,h2] =contour(X1,X2,T_f,v);
set(h2,'fill','on')
set(h2,'showtext','on')
set(h2,'textlist',[0:0.2:1])
title(['contour of final T, ',title_string])
axis tight equal; shading interp
colorbar
xlab=xlabel('$x$'); set(xlab,'interpreter','latex'); set(xlab,'fontsize',40)
ylab=ylabel('$y$'); set(ylab,'interpreter','latex'); set(ylab,'fontsize',40)
%% read tracking data 
figure
AX=gca;
hh=findobj(AX,'Type','line');
semilogy(itr_dif,'r','linewidth',4);
xlabel('iterations')
ylabel('norm');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title(['norm track',title_string]);
% legend('fk','ea','all')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
set(AX,'fontsize',20)
% set(AX,'ylim',[0,1.2])
% set(AX,'xlim',[0,30])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])

htitle=get(AX,'Title');
set(htitle,'fontsize',30)
set(AX,'linewidth',4)

hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',50)

%% plot err VS spacing (8)
N_arr=[4 8 16 32];
h=1./(N_arr+1);
h_p4=h.^4;
err_1=[0.012286 0.0033389 0.00083385 0.00012202];
err_2=[0.012989 0.0036961 0.00095864 0.00014747];
err_inf=[0.019903 0.0061672  0.0017186 0.00028502];

N_arr_extd=[4 8 16 32 64 128];

err_1_extd=[0.012286 0.0033389 0.00083385 0.00012202 3.031204192882831e-04 0.001374138441266];
err_2_extd=[0.012989 0.0036961 0.00095864 0.00014747 3.717303632399200e-04 0.001683076135626];
err_inf_extd=[0.019903 0.0061672  0.0017186 0.00028502 7.445431738780095e-04 0.003342801627658];
%% plot

figure
subplot(3,1,1)
AX=gca;
hh=findobj(AX,'Type','line');
plot(err_1,'r--o','linewidth',2,'markersize',10);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
plot(err_2,'b--^','linewidth',2,'markersize',10);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
plot(err_inf,'g--v','linewidth',2,'markersize',10);
% xlabel('N')
ylabel('norm of error');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('norm of error VS different meshes');
legend('norm-1','norm-2','norm-inf')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',20)
% set(AX,'ylim',[0,1.2])
set(AX,'xlim',[0.5,4.5])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',[1 2 3 4],'xticklabel',{'N=4';'N=8';'N=16';'N=32'})
htitle=get(AX,'Title');
set(htitle,'fontsize',20)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',50)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',30)
%% plot err/h^2 (9)
rat_1=h.^2./err_1;
rat_2=h.^2./err_2;
rat_inf=h.^2./err_inf;

%% plot
subplot(3,1,2)
AX=gca;
hh=findobj(AX,'Type','line');
plot(rat_1,'r--o','linewidth',2,'markersize',10);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
plot(rat_2,'b--^','linewidth',2,'markersize',10);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
plot(rat_inf,'g--v','linewidth',2,'markersize',10);
% xlabel('N')
ylabel('error/h^2');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('ratio of error/h^2 VS different meshes');
legend('norm-1','norm-2','norm-inf')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',20)
set(AX,'ylim',[1,8])
set(AX,'xlim',[0.5,4.5])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',[1 2 3 4],'xticklabel',{'N=4';'N=8';'N=16';'N=32'})
htitle=get(AX,'Title');
set(htitle,'fontsize',20)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',30)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',30)
%% plot log error VS log(h) (10)


subplot(3,1,3)
AX=gca;
hh=findobj(AX,'Type','line');
loglog(flip(h),flip(err_1),'r--o','linewidth',2,'markersize',10);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
loglog(flip(h),flip(err_2),'b--^','linewidth',2,'markersize',10);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
loglog(flip(h),flip(err_inf),'g--v','linewidth',2,'markersize',10);
xlabel('log(h)')
ylabel('log(error)');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('log error VS different spacing');
legend('norm-1','norm-2','norm-inf')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',20)
set(AX,'ylim',[1e-4,10^(-1.4)])
set(AX,'xlim',[10^(-1.7),10^(-0.6)])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',flip(h),'xticklabel',{'N=32';'N=16';'N=8';'N=4'})
htitle=get(AX,'Title');
set(htitle,'fontsize',20)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',30)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
hlegend=findobj(gcf,'Type','text');
set(hlegend,'fontsize',10)

%% plot separately

figure
AX=gca;
hh=findobj(AX,'Type','line');
plot(err_1,'r--o','linewidth',4,'markersize',15);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
plot(err_2,'b--^','linewidth',4,'markersize',15);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
plot(err_inf,'g--v','linewidth',4,'markersize',15);
% xlabel('N')
ylabel('norm of error');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('norm of error VS different meshes');
legend('norm-1','norm-2','norm-inf')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',30)
% set(AX,'ylim',[0,1.2])
set(AX,'xlim',[0.5,4.5])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',[1 2 3 4],'xticklabel',{'N=4';'N=8';'N=16';'N=32'})
htitle=get(AX,'Title');
set(htitle,'fontsize',30)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',50)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',40)
%% plot err/h^2 (9)
rat_1=h.^2./err_1;
rat_2=h.^2./err_2;
rat_inf=h.^2./err_inf;

%% plot
figure;
AX=gca;
hh=findobj(AX,'Type','line');
plot(rat_1,'r--o','linewidth',4,'markersize',15);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
plot(rat_2,'b--^','linewidth',4,'markersize',15);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
plot(rat_inf,'g--v','linewidth',4,'markersize',15);
% xlabel('N')
ylabel('error/h^2');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('ratio of error/h^2 VS different meshes');
legend('norm-1','norm-2','norm-inf','location','north')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',30)
set(AX,'ylim',[1,8])
set(AX,'xlim',[0.5,4.5])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',[1 2 3 4],'xticklabel',{'N=4';'N=8';'N=16';'N=32'})
htitle=get(AX,'Title');
set(htitle,'fontsize',20)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',30)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',40)
%% plot log error VS log(h) (10)


figure;
AX=gca;
hh=findobj(AX,'Type','line');
loglog(flip(h),flip(err_1),'r--o','linewidth',4,'markersize',15);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
loglog(flip(h),flip(err_2),'b--^','linewidth',4,'markersize',15);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
loglog(flip(h),flip(err_inf),'g--v','linewidth',4,'markersize',15);
xlabel('log(h)')
ylabel('log(error)');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('log error VS different spacing');
legend('norm-1','norm-2','norm-inf','location','north')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',30)
set(AX,'ylim',[1e-4,10^(-1.4)])
set(AX,'xlim',[10^(-1.7),10^(-0.6)])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',flip(h),'xticklabel',{'N=32';'N=16';'N=8';'N=4'})
htitle=get(AX,'Title');
set(htitle,'fontsize',20)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',30)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
hlegend=findobj(gcf,'Type','text');
set(hlegend,'fontsize',40)

%% plot err_extd VS N

figure
AX=gca;
hh=findobj(AX,'Type','line');
plot(err_1_extd,'r--o','linewidth',4,'markersize',15);
hold on;
% axes(AX); hold on; findpeaks(norm_ea,t);
plot(err_2_extd,'b--^','linewidth',4,'markersize',15);
hold on;
% plot(locs,pks,'mo','markersize',10)
% hold on;
plot(err_inf_extd,'g--v','linewidth',4,'markersize',15);
% xlabel('N')
ylabel('norm of error');
% tt=text(locs-5,pks+0.15,text1);
% tt.FontSize=10
title('norm of error VS different meshes');
legend('norm-1','norm-2','norm-inf')
set(get(AX,'Xlabel'),'fontsize',30)
set(get(AX,'Ylabel'),'fontsize',30)
grid on;
set(AX,'fontsize',30)
% set(AX,'ylim',[0,1.2])
set(AX,'xlim',[0.5,6.5])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
set(AX,'xtick',[1 2 3 4 5 6],'xticklabel',{'N=4';'N=8';'N=16';'N=32';'N=64';'N=128'})
htitle=get(AX,'Title');
set(htitle,'fontsize',30)
set(AX,'linewidth',4)
set(get(AX,'Xlabel'),'fontsize',50)
hlegend=findobj(gcf,'Type','axes','Tag','legend');
set(hlegend,'fontsize',40)

%% fit log(h) VS log(err)=ax+b

p=polyfit(log(h),log(err_1),1);
a_1=p(1);
b_1=p(2);

p=polyfit(log(h),log(err_2),1);
a_2=p(1);
b_2=p(2);

p=polyfit(log(h),log(err_inf),1);
a_inf=p(1);
b_inf=p(2);
% plot(t,y,'o');
% hold on;
% plot(f,t_pick,y_pick);


%% compute the truncation error plot
T_trun_err=zeros(N+2,N+2);
T_trun_err(1,:)=T_f(1,:);
T_trun_err(end,:)=T_f(end,:);
T_trun_err(:,1)=T_f(:,1);
T_trun_err(:,end)=T_f(:,end);
for i=2:N+1
    for j=2:N+1
        T_trun_err(i,j)=(T_f(i-1,j)+T_f(i+1,j)+T_f(i,j-1)+T_f(i,j+1))/4;
    end
end

T_trun_err=T_f-T_trun_err;


%% plot truncation error
%% plot the T exact
figure;
pcolor(X1,X2,T_trun_err);
title(['truncation error of T when N=' num2str(N)]);
axis tight equal; shading interp
colorbar
AX=gca;
set(AX,'fontsize',15)
xlab=xlabel('$x$'); set(xlab,'interpreter','latex'); set(xlab,'fontsize',40)
ylab=ylabel('$y$'); set(ylab,'interpreter','latex'); set(ylab,'fontsize',40)


%%

% %% plot difference norm track
% name_string='R1_norm_all';
% size_sufx='size';
% data_type='dat';
% 
% norm_all=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);
% 
% name_string='R1_norm_ea';
% size_sufx='size';
% data_type='dat';
% 
% norm_ea=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);
% 
% name_string='R1_norm_fk';
% size_sufx='size';
% data_type='dat';
% 
% norm_fk=load_bin_main(dir_name,name_string,data_type,size_sufx,ind);
% 
% %% use normalzation line to specify the locs
% [pks,locs] = findpeaks(norm_ea,t);
% text1=['(',num2str(locs,3),',',num2str(pks,3),')'];
% %% plot norm
% subplot(3,3,8)
% AX=gca;
% hh=findobj(AX,'Type','line');
% plot(t,norm_fk,'r','linewidth',4);
% hold on;
% % axes(AX); hold on; findpeaks(norm_ea,t);
% plot(t,norm_ea,'b','linewidth',4);
% hold on;
% % plot(locs,pks,'mo','markersize',10)
% % hold on;
% plot(t,norm_all,'g','linewidth',4);
% xlabel('t')
% ylabel('norm');
% % tt=text(locs-5,pks+0.15,text1);
% % tt.FontSize=10
% title('normalization track');
% legend('fk','ea','all')
% set(get(AX,'Xlabel'),'fontsize',30)
% set(get(AX,'Ylabel'),'fontsize',30)
% set(AX,'fontsize',15)
% set(AX,'ylim',[0,1.2])
% set(AX,'xlim',[0,30])
% set(AX,'xtick',[0:5:60])
% set(AX,'ytick',[0:0.2:1.4])
% 
% htitle=get(AX,'Title');
% set(htitle,'fontsize',20)
% set(AX,'linewidth',4)
% 
% hlegend=findobj(gcf,'Type','axes','Tag','legend');
% set(hlegend,'fontsize',50)
% 
% 



