function varargout = GUI_worm(varargin)
% GUI_WORM MATLAB code for GUI_worm.axes
%      GUI_WORM, by itself, creates a new GUI_WORM or raises the existing
%      singleton*.
%
%      H = GUI_WORM returns the handle to a new GUI_WORM or the handle to
%      the existing singleton*.
%
%      GUI_WORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_WORM.M with the given input arguments.
%
%      GUI_WORM('Property','Value',...) creates a new GUI_WORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_worm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_worm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_worm

% Last Modified by GUIDE v2.5 10-Jul-2014 20:05:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_worm_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_worm_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_worm is made visible.
function GUI_worm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_worm (see VARARGIN)

% Choose default command line output for GUI_worm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% hide menu bar (so far there is no menu bar for this GUI)
set(handles.menu, 'Visible','off');

% hide axis
set(handles.axes, 'Visible', 'off');

% add "global" variables (to share infor among callback functions)
stop.flag = 0;
set(handles.Stop,'UserData',stop);

color_p1.value = [1 0 0]; % red
set(handles.plus1,'UserData',color_p1);
color_m1.value = [0 0 1]; % blue
set(handles.minus1,'UserData',color_m1);
color_0.value = [1 1 1]; %white
set(handles.zero,'UserData',color_0);

color_head.value = [1 1 0]; %yellow
set(handles.head,'UserData',color_head);
color_tail.value = [0 1 0]; %green
set(handles.tail,'UserData',color_tail);

% UIWAIT makes GUI_worm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_worm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% No callback function


function leng_Callback(hObject, eventdata, handles)
leng = str2double(get(hObject,'String'));
if (leng<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function leng_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function kappa_Callback(hObject, eventdata, handles)
kappa = str2double(get(hObject,'String'));
if (kappa<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function kappa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tau_Callback(hObject, eventdata, handles)
tau = str2double(get(hObject,'String'));
if (tau<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function tau_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mu_Callback(hObject, eventdata, handles)
mu = str2double(get(hObject,'String'));
if (mu<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end%        str2double(get(hObject,'String')) returns contents of mu as a double



% --- Executes during object creation, after setting all properties.
function mu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nequi_Callback(hObject, eventdata, handles)
nequi = str2double(get(hObject,'String'));
if (nequi<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function nequi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nequi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nplot_Callback(hObject, eventdata, handles)
nplot = str2double(get(hObject,'String'));
if (nplot<0)
    % Disable the Plot button and change its string to say why
    set(handles.Start,'String','Wrong!!')
    set(handles.Start,'Enable','off')
    % Give the edit text box focus so user can correct the error
    uicontrol(hObject)
else 
    % Enable the Plot button with its original name
    set(handles.Start,'String','Start!')
    set(handles.Start,'Enable','on')
end


% --- Executes during object creation, after setting all properties.
function nplot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start.
function Stop_Callback(hObject, eventdata, handles)
stop.flag = 1;
set(handles.Stop,'UserData',stop);


% --- Executes on button press in Stop.
function Start_Callback(hObject, eventdata, handles)

% clear axis
cla reset;
if (exist('lat'))
    clear all;
end
% reset the stop flag and disable start buttom
stop = get(handles.Stop,'UserData');
stop.flag = 0;
set(handles.Stop,'UserData',stop);
set(handles.Start,'Enable','off');

% Get user input from GUI
% MC parameters
leng = str2double(get(handles.leng,'String'));
nequi = str2double(get(handles.nequi,'String'));
nplot = eval(get(handles.nplot,'String'));

% Model parameters
kappa = str2double(get(handles.kappa,'String'));
tau = str2double(get(handles.tau,'String'));
mu = eval(get(handles.mu,'String'));

% Create lattice arrays
lat = latticeVector(leng);
initLattice(lat);

% update the colors
c = get(handles.minus1,'UserData');
lat.colors(1,:) = c.value;
c = get(handles.zero,'UserData');
lat.colors(2,:) = c.value;
c = get(handles.plus1,'UserData');
lat.colors(3,:) = c.value;
c = get(handles.head,'UserData');
lat.colors(4,:) = c.value;
c = get(handles.tail,'UserData');
lat.colors(5,:) = c.value;

% Calculate monomer and dimer weights
initWeights(lat,tau,kappa,mu)

% equilibration (do not plot anything)
for im = 1:nequi
    set(handles.nworms,'String',['Worm ' num2str(im)]);
    stop = get(handles.Stop,'UserData');
    if (stop.flag) 
        set(handles.Start,'Enable','on');
        break;
    end
    worm(lat,0);
end

% Create figure
hold on;
set(handles.axes, 'Visible', 'off'); 
view(-16,8), axis vis3d;
axis square;
rotate3d on;
plotLattice(lat);

% worm that will be ploted 
for im = 1:nplot
    set(handles.nworms,'String',['Worm ' num2str(nequi+im)]);
    stop = get(handles.Stop,'UserData');
    if (stop.flag)  
        set(handles.Start,'Enable','on');
        break;
    end
    worm(lat,1);
    pause(0.5);
    refreshLattice(lat);
end

% finish adding plots to figure "axes"
hold off;


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function plus1_ButtonDownFcn(hObject, eventdata, handles)

color = get(handles.plus1,'UserData');
color.value = uisetcolor;
set(handles.plus1,'UserData',color);
set(handles.plus1,'ForegroundColor',color.value);

function minus1_ButtonDownFcn(hObject, eventdata, handles)

color = get(handles.minus1,'UserData');
color.value = uisetcolor;
set(handles.minus1,'UserData',color);
set(handles.minus1,'ForegroundColor',color.value);

function zero_ButtonDownFcn(hObject, eventdata, handles)

color = get(handles.zero,'UserData');
color.value = uisetcolor;
set(handles.zero,'UserData',color);
set(handles.zero,'ForegroundColor',color.value);


function head_ButtonDownFcn(hObject, eventdata, handles)

color = get(handles.head,'UserData');
color.value = uisetcolor;
set(handles.head,'UserData',color);
set(handles.head,'ForegroundColor',color.value);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over tail.
function tail_ButtonDownFcn(hObject, eventdata, handles)

color = get(handles.tail,'UserData');
color.value = uisetcolor;
set(handles.tail,'UserData',color);
set(handles.tail,'ForegroundColor',color.value);
