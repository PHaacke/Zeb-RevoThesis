clear all
close all

%% Import the data
[~, ~, raw] = xlsread('/Users/Debora/Desktop/Peter/DunesDenseDBH.xlsx','AdamTrialDBH');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,2);
raw = raw(:,[1,3,4,5,6,7]);

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
ID1 = data(:,1);
Name1 = cellVectors(:,1);
Rayonducercle1 = data(:,2);
Diameter1 = data(:,3);
Daimeterincm1 = data(:,4);
TMCircumference1 = data(:,5);
TMDiameter1 = data(:,6);

%% Clear temporary variables
clearvars data raw cellVectors;

%% DBH Analysis
% intialize generic variables
 xdata = Daimeterincm1;
 xString = 'Tape Measured DBH (cm)';
 ydata = TMDiameter1;
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
 tString = ['DBH correlation for Dataset 5']
 figure('Name', tString)
 hold on
 plot(xdata, ydata, 'k*') % Plot a scatter plot
 plot(fit1,fit2,'g','linestyle',':','LineWidth',1.5)
 plot (linePointsX,linePointsY,'-r','LineWidth',1.5) % Plot best fit line
 hold off
 legend({'Dunes Dense (n = 25)','1:1 line',['Y',' = ',num2str(pPoly(1)),'*',...
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
