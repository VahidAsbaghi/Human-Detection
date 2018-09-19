function GUI_IR()
%% Grafical User Interface----
%
%
%% ************************************************************************
close all;
clear all;
clc;

%Controls Colors Define
panel_color=[0.4 0.5 0.35];
entryField_color=[1 1 1];
button_color=[0.7 0.7 0.4];

%% Handles and Controls Define
hFigure=figure(...   %main figure descreption
    'Units','Pixels',...
    'Position',[100 100 600 600],...
    'Toolbar','none',...
    'MenuBar','none',...
    'NumberTitle','off',...
    'Color',[.5 .5 .5],...
    'Name','Iris Recognition');

hPanel=uipanel(...    %main panel describe
    'Parent', hFigure,...
    'Units','Pixels',...
    'Position',[0 0 600 600],...
    'BackgroundColor',panel_color);
hPanel1=uipanel(...    %first panel on up-left direction of figure
    'Parent', hPanel,...
    'Units','Pixels',...
    'Position',[0 400 300 200],...
    'BackgroundColor',panel_color);

%handles in first panel on up-left position of GUI 
hhead1l=uicontrol(...  
    'Style','Text',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[5 180 200 15],...
    'String','Test Single Image and Show Results',...
    'BackgroundColor',panel_color);
hPNl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[5 130 70 25],...
    'String','Person Number 1~108',...
    'BackgroundColor',panel_color);
hPNE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[80 130 50 25],...
    'String','1',...
    'BackgroundColor',entryField_color);
hImNl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[150 130 70 25],...
    'String','Image Number 1~3',...
    'BackgroundColor',panel_color);
hImNE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[225 130 50 25],...
    'String','1',...
    'BackgroundColor',entryField_color);
hClNl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[5 90 70 25],...
    'String','Class Result',...
    'BackgroundColor',panel_color);
hClNE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[80 90 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hTl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[150 90 70 25],...
    'String','Time',...
    'BackgroundColor',panel_color);
hTE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel1,...
    'Units','Pixel',...
    'Position',[225 90 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hButton1=uicontrol(...
    'Style','pushbutton',...
    'Parent',hPanel1,...
    'Units','Pixels',...
    'Position',[10 40 110 30],...
    'String','Test Single',...
    'BackgroundColor',button_color,...
    'Callback',@hButton1_callback);
%-------------------------------------------------------------------------
%second part of GUI on up-right position
hPanel2=uipanel(...  %main panel of this part define
    'Parent', hPanel,...
    'Units','Pixels',...
    'Position',[300 400 300 200],...
    'BackgroundColor',[0.5 0.5 0.5]);

%handles and text of this part define
hhead2l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[10 180 200 15],...
    'String','Plot a Gabor Filter',...
    'BackgroundColor',panel_color);
htetal=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[5 130 70 25],...
    'String','Teta value',...
    'BackgroundColor',panel_color);
htetaE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[80 130 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hu0l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[150 130 70 25],...
    'String','u0 value',...
    'BackgroundColor',panel_color);
hu0E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[225 130 50 25],...
    'String','0.4',...
    'BackgroundColor',entryField_color);
hv0l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[5 90 70 25],...
    'String','v0 value',...
    'BackgroundColor',panel_color);
hv0E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[80 90 50 25],...
    'String','0.01',...
    'BackgroundColor',entryField_color);
hsigxl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[150 90 70 25],...
    'String','Sigmax value',...
    'BackgroundColor',panel_color);
hsigxE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[225 90 50 25],...
    'String','0.1',...
    'BackgroundColor',entryField_color);
hsigyl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[5 50 70 25],...
    'String','Sigmay value',...
    'BackgroundColor',panel_color);
hsigyE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[80 50 50 25],...
    'String','10',...
    'BackgroundColor',entryField_color);
hx0l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[150 50 70 25],...
    'String','x0 value',...
    'BackgroundColor',panel_color);
hx0E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[225 50 50 25],...
    'String','1',...
    'BackgroundColor',entryField_color);
hy0l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[5 10 70 25],...
    'String','y0 value',...
    'BackgroundColor',panel_color);
hy0E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel2,...
    'Units','Pixel',...
    'Position',[80 10 50 25],...
    'String','1',...
    'BackgroundColor',entryField_color);
hButton2=uicontrol(...
    'Style','pushbutton',...
    'Parent',hPanel2,...
    'Units','Pixels',...
    'Position',[150 10 100 30],...
    'String','Gabor 3D Plot',...
    'BackgroundColor',button_color,...
    'Callback',@hButton2_callback);
%--------------------------------------------------------------------------
%third part of GUI definition in down-left position of main GUI
hPanel3=uipanel(...
    'Parent', hPanel,...
    'Units','Pixels',...
    'Position',[0 200 300 200],...
    'BackgroundColor',[0.5 0.5 0.5]);
hhead3l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[10 180 250 15],...
    'String','Test Algorithm by Selected Test Image Numbers',...
    'BackgroundColor',panel_color);
htrNsl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[5 140 150 15],...
    'String','Train Eye Numbers 1~7',...
    'BackgroundColor',panel_color);
htrNs1E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[10 110 30 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
htrNs2E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[45 110 30 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
htrNs3E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[80 110 30 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
htrNs4E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[115 110 30 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hErrRl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[5 50 70 15],...
    'String','Error Rate',...
    'BackgroundColor',panel_color);
hErrRE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[80 50 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hNoTsIml=uicontrol(...
    'Style','Text',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[5 20 150 15],...
    'String','Number of All Test Images',...
    'BackgroundColor',panel_color);
hNoTsImE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel3,...
    'Units','Pixel',...
    'Position',[160 20 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hButton3=uicontrol(...
    'Style','pushbutton',...
    'Parent',hPanel3,...
    'Units','Pixels',...
    'Position',[180 70 100 30],...
    'String','Run Test',...
    'BackgroundColor',button_color,...
    'Callback',@hButton3_callback);
%-------------------------------------------------------------------------
%forth part of GUI on down-right position
hPanel4=uipanel(...
    'Parent', hPanel,...
    'Units','Pixels',...
    'Position',[300 200 300 200],...
    'BackgroundColor',panel_color);
hhead4l=uicontrol(...
    'Style','Text',...
    'Parent',hPanel4,...
    'Units','Pixel',...
    'Position',[10 180 250 15],...
    'String','Make New Feature Vectors',...
    'BackgroundColor',panel_color);
hNoPerl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel4,...
    'Units','Pixel',...
    'Position',[10 140 200 15],...
    'String','Number of Persons 1~108',...
    'BackgroundColor',panel_color);
hNoPerE=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel4,...
    'Units','Pixel',...
    'Position',[40 110 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hNoPerl=uicontrol(...
    'Style','Text',...
    'Parent',hPanel4,...
    'Units','Pixel',...
    'Position',[95 110 10 15],...
    'String','to',...
    'BackgroundColor',panel_color);
hNoPer1E=uicontrol(...
    'Style','Edit',...
    'Parent',hPanel4,...
    'Units','Pixel',...
    'Position',[115 110 50 25],...
    'String','0',...
    'BackgroundColor',entryField_color);
hButton4=uicontrol(...
    'Style','pushbutton',...
    'Parent',hPanel4,...
    'Units','Pixels',...
    'Position',[170 60 110 30],...
    'String','Make Features',...
    'BackgroundColor',button_color,...
    'Callback',@hButton4_callback);



%%
%handles define for use 
handles=[hFigure,hPanel,hPNE,hImNE,hClNE,hTE,htetaE,hu0E,hv0E,hsigxE,hsigyE...
    hButton1,hx0E,hy0E,hButton2,htrNs1E,htrNs2E,htrNs3E,htrNs4E,hErrRE...
    hNoTsImE,hButton3,hNoPerE,hNoPer1E,hButton4];

set(handles,...
    'Units','Normalized'); %normalized position units: from (0,0) to (1,1)

%% Callbacks for Buttons

% Callback for button 'Test Single'
    function hButton1_callback(hObject,eventdata)
        tic();
        p_num=(get(hPNE,'String'));
        l_p=length(p_num);
        if l_p<2
            p_num=['00' p_num];
        elseif l_p<3
            p_num=['0' p_num];
        end
        Im_num=(get(hImNE,'String'));
        url=['CA/CA1/' p_num '/1/' p_num '_1_' Im_num '.bmp']; 
        Res=test_single_image(url);
        time=toc();
        
        set(hClNE,'String',num2str(Res));
        set(hTE,'String',num2str(time));
    end

%callback for button 'Gabor 3D Plot'
    function hButton2_callback(hObject,eventdata)
       
        teta=str2double(get(htetaE,'String'))*2*pi;
        u0=str2double(get(hu0E,'String'));
        v0=str2double(get(hv0E,'String'));
        sigmay=str2double(get(hsigyE,'String'));
        sigmax=str2double(get(hsigxE,'String'));
        x0=str2double(get(hx0E,'String'));
        y0=str2double(get(hy0E,'String'));
        lx=256;
        ly=256;
        sigmau=(1/2*pi)*sigmax;
        sigmav=(1/2*pi)*sigmay;
        up=repmat((1:lx)/lx,ly,1).*repmat(cos(teta(1)),ly,lx)+repmat((1:ly)'/ly,1,lx).*repmat(sin(teta(1)),ly,lx);
        vp=-repmat((1:lx)/lx,ly,1).*repmat(sin(teta(1)),ly,lx)+repmat((1:ly)'/ly,1,lx).*repmat(cos(teta(1)),ly,lx);
        G=exp(-0.5*((up(:,1:lx)-u0).^2/(sigmau^2)+((vp(:,1:lx)-v0).^2/(sigmav^2))))+cos(-2*pi*(x0*(up(:,1:lx)-u0)+y0*(vp(:,1:lx)-v0)));
        figure;
        mesh(G);
        
    end
 
%callback for button 'Run Test'
    function hButton3_callback(hObject,eventdata)
        
        tr_num1=str2double(get(htrNs1E,'String'));
        tr_num2=str2double(get(htrNs2E,'String'));
        tr_num3=str2double(get(htrNs3E,'String'));
        tr_num4=str2double(get(htrNs4E,'String'));
        tr_num=[tr_num1,tr_num2,tr_num3,tr_num4];
        [er_rate,ly]=new_dist(tr_num);
        
        
        set(hErrRE,'String',num2str(er_rate));
        set(hNoTsImE,'String',num2str(ly));
    end

%callback for button 'Make Features'
    function hButton4_callback(hObject,eventdata)
        NN1=str2double(get(hNoPer1E,'String'));
        NN=str2double(get(hNoPerE,'String'));
        main(NN,NN1,1);
        
    end
%**************************************************************************
%***************************** END Function********************************
end
%**************************************************************************
%**************************************************************************