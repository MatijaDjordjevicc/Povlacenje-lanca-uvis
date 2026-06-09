function lanac_grafik()

%dati parametri
F=50; %Konstantna sila (N)
T=10; %Težina po dužnom metru (N/m)
g=9.81; %Ubrzanje Zemljine teže (m/s^2)

%izrčunato
x_max = (3*F)/(2*T);
t_max = 3*sqrt(F/(T*g));

%%podšavanje prikaza
broj_oscilacija = 4;
n_tacaka = 500; 


t_ukupno = []; %% predstavlja celokupno vreme kretanja lanca
x_ukupno = []; %% predstavlja poziciju lanca u odnosu na trenutno vreme

koreni_izraz = sqrt((F*g)/T); %% izvlačimo radi efikasnosti i lepšeg zapisa

for k = 0:(broj_oscilacija-1)
    
    
    %% kretanje lanca uvis
    t_podizanja = linspace(2*k*t_max, (2*k+1)*t_max,n_tacaka);
    tau_podizanje = t_podizanja - 2*k*t_max; %% trenutci između intervala
    x_podizanje = tau_podizanje * koreni_izraz - (g*tau_podizanje.^2)/6;

    %% pad lanca
    t_pad = linspace((2*k+1)*t_max, 2*(k+1)*t_max,n_tacaka);
    tau_pad = 2*(k+1)*t_max - t_pad;
    x_pad = tau_pad * koreni_izraz - (g*tau_pad.^2)/6;

    t_ukupno = [t_ukupno, t_podizanja, t_pad];
    x_ukupno = [x_ukupno, x_podizanje, x_pad];
    
end

figure('Color','w');
plot(t_ukupno,x_ukupno, 'LineWidth',2.5,'Color',[0.1 0.5 0.8]);
grid on;
hold on;

xlabel('Vreme t [s]','FontSize',12,'FontWeight','bold','Color','black');
ylabel('Visina lanca x [m]','FontSize',12  ,'FontWeight','bold','Color','black');
title('Povlačenje lanca uvis','Color','black');
ylim([0,x_max*1.2]);
xlim([0,2*broj_oscilacija*t_max]);

%% uklanjanje brojeva sa X i Y ose da bi graf bio uopšten za korišćenje u radu
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


%%iscrtavanje isprekidane linije koja prolazi kroz maksimalne visine
yline(x_max,'--r', 'x_{max}','LineWidth',1.5,'FontSize',11,'LabelHorizontalAlignment','left');


%% iscrtavanje tačkica na grafu
for k = 0:broj_oscilacija
    t_tlo = 2*k*t_max;
    plot(t_tlo,0,'ro','MarkerFaceColor','r','MarkerSize',6);
    plot((2*k+1)*t_max,x_max,'ro','MarkerFaceColor','r','MarkerSize',6);%% tačkica na max visini
    if k > 0 && k < broj_oscilacija
        text(t_tlo,x_max * 0.08,['k =' num2str(k)],'HorizontalAlignment','center','FontSize',9,'Color','r');
    end
end

end

