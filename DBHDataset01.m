%% Import the data
clear all
close all

[~, ~, raw] = xlsread('/Users/Debora/Desktop/Peter/AdamTrialDBH.xlsx','AdamTrialDBH');
raw = raw(2:end,1:7);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,2);
raw = raw(:,[1,3,4,5,6,7]);

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
ID = data(:,1);
Name = cellVectors(:,1);
Rayonducercle = data(:,2);
Diameter = data(:,3);
Daimeterincm = data(:,4);
TMCircumference = data(:,5);
TMDiameter = data(:,6);

%% Clear temporary variables
clearvars data raw cellVectors;

%% DBH Analysis
% intialize generic variables
 xdata = TMDiameter;
 xString = 'Tape Measured DBH (cm)';
 ydata = Daimeterincm;
 yString = 'Zeb-Revo DBH (cm)';

 % define endpoints and equation for best fit line
 pPoly = polyfit(xdata, ydata, 1); % Linear fit of xdata vs ydata
 linePointsX = [min(xdata) max(xdata)]; % find left and right x values
 linePointsY = polyval(pPoly,[min(xdata),max(xdata)]); % find y values
 
 % RMSE
 RMSE = sqrt(mean((xdata-ydata).^2))
 
 % perfect line (R = 1.00)
 fit1= xdata
 fit2= xdata

 % generate graph with labels and correlation value in title
 tString = [xString,' and ',yString, ' correlation (corr: ',...
 num2str(corr(xdata, ydata)) ')'];
 tString = ['DBH correlation for Dataset 1']
 figure('Name', tString)
 hold on
 plot(xdata, ydata, 'k+') % Plot a scatter plot
 plot(fit1,fit2,'g','linestyle',':','LineWidth',1.5)
 plot (linePointsX,linePointsY,'-r','LineWidth',1.5) % Plot best fit line
 hold off
 
 legend({'Adam Trial (n = 38)','1:1 line',['Y',' = ',num2str(pPoly(1)),'*',...
 'x',' + ',num2str(pPoly(2)),' ; R^2 = ',num2str(corr(xdata, ydata))]},'FontSize',12)

MyBox = uicontrol('style','text');
set(MyBox,'String',['RMSE = ' num2str(RMSE)]) % text
 set(MyBox,'Position',[300,90,200,15]) % position and size of box
 set(MyBox,'FontSize',12) % size of text 
%text(47,25, ['RMSE = ' num2str(RMSE)])
 grid on

 xlabel(xString,'FontSize',15); % Label the x-axis
 ylabel(yString,'FontSize',15); % Label the y-axis
 title(tString,'FontSize',15);

 % add textbox to figure with best fit line equation
 %MyBox = uicontrol('style','text');
 %set(MyBox,'String',['Y',' = ',num2str(pPoly(1)),'*',...
 %'x',' + ',num2str(pPoly(2))]) % text
 %set(MyBox,'Position',[300,90,200,15]) % position and size of box
 %set(MyBox,'FontSize',9) % size of text 