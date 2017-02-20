function varargout = image_editor(varargin)
% IMAGE_EDITOR MATLAB code for image_editor.fig
%      IMAGE_EDITOR, by itself, creates a new IMAGE_EDITOR or raises the existing
%      singleton*.
%
%      H = IMAGE_EDITOR returns the handle to a new IMAGE_EDITOR or the handle to
%      the existing singleton*.
%
%      IMAGE_EDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_EDITOR.M with the given input arguments.
%
%      IMAGE_EDITOR('Property','Value',...) creates a new IMAGE_EDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_editor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_editor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_editor

% Last Modified by GUIDE v2.5 20-Feb-2017 09:00:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_editor_OpeningFcn, ...
                   'gui_OutputFcn',  @image_editor_OutputFcn, ...
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

% --- Executes just before image_editor is made visible.
function image_editor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_editor (see VARARGIN)

% Choose default command line output for image_editor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_editor wait for user response (see UIRESUME)
uiwait(handles.figure1);

set(handles.slider2,'value','your_value_here');



% --- Outputs from this function are returned to the command line.
function varargout = image_editor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

set(hObject, 'String', {})


% --- Executes on button press in upload_pushbutton.
function upload_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to upload_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

originalFileNames = get(handles.listbox1,'string');
temp = char(originalFileNames);
display(temp); % FOR DEBUGGING 

[newFileNames, pathName] = uigetfile({'*.dcm', 'Select the DICOM-file'}, 'MultiSelect', 'on');
newFileNames = char(newFileNames);
display(newFileNames); % FOR DEBUGGING

allFileNames = strvcat(temp,newFileNames);
display(allFileNames); % FOR DEBUGGING

set(handles.listbox1,'string',cellstr(allFileNames))

%------------------ ORIGINAL METHOD FOR UPLOADING: -----------------------
% replaces entire list offiles everytime you upload new files
%
%[fileNames, pathName] = uigetfile({'*.dcm', 'Select the DICOM-file'}, 'MultiSelect', 'on');
%fileNames = cellstr(fileNames);
%
% storing each image matrix in an index
%for i=1:length(fileNames)
%    fileNames{i} = fullfile(pathName, fileNames{i});
%    dcm = dicomread(fileNames{i});
%    imshow(dcm,'DisplayRange', []);
%end  
%set(handles.listbox1, 'String', fileNames);
%-------------------------------------------------------------------------


% --- Executes on button press in delete_pushbutton.
function delete_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to delete_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

originalFileNames = get(handles.listbox1,'string');
temp = char(originalFileNames);
display(temp); % FOR DEBUGGING

indexOfFile = get(handles.listbox1,'value');
display('The file that is going to be deleted is:'); % FOR DEBUGGING
display(indexOfFile); % FOR DEBUGGING

temp(indexOfFile,:) = [];
display(temp); % FOR DEBUGGING

set(handles.listbox1,'string',cellstr(temp))
set(handles.listbox1,'value', length(cellstr(temp)))

listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
indexOfFile = get(handles.listbox1, 'value');
selectedFile = listboxOfFiles{indexOfFile};

dcm = dicomread(selectedFile);
imshow(dcm,'DisplayRange', []);

%------------------ ORIGINAL METHOD FOR DELETING: -----------------------
% deleted selected file but didn't change the original hangle to the list
% of file names in listbox1
% 
%indexOfFile = get(handles.listbox1,'value');
% listOfFiles = get(handles.listbox1,'string');
% 
% display(length(listOfFiles)); % FOR DEBUGGING
% display(indexOfFile); % FOR DEBUGGING
% 
% listOfFiles(indexOfFile) = [];
% 
% set(handles.listbox1,'string',listOfFiles);
%-------------------------------------------------------------------------


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
indexOfFile = get(handles.listbox1, 'value');
selectedFile = listboxOfFiles{indexOfFile};

dcm = dicomread(selectedFile);
imshow(dcm,'DisplayRange', []);


% --- Executes on button press in about_pushbutton.
function about_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to about_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
indexOfFile = get(handles.listbox1, 'value');
selectedFile = listboxOfFiles{indexOfFile};

fileInfo = dicominfo(selectedFile);
Filename = getfield(fileInfo, 'Filename');
ProtocolName = getfield(fileInfo, 'ProtocolName');
FileModDate = getfield(fileInfo, 'FileModDate');

uiwait(msgbox({Filename; ProtocolName; FileModDate}, 'DICOM file information'));


% --- Executes on button press in rot90cw.
function rot90cw_Callback(hObject, eventdata, handles)
% hObject    handle to rot90cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rot90cw
gatherAndUpdate(handles)

% RETURNS SELECTED FILES ---------------------------------------------
%listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
%indexOfFile = get(handles.listbox1, 'value');
%selectedFile = listboxOfFiles{indexOfFile};

%rotatedFile = imrotate(dicomread(selectedFile),-90);
%imshow(rotatedFile,'DisplayRange', []);
%-------------------------------------------------------------------------


% --- Executes on button press in rot90ccw.
function rot90ccw_Callback(hObject, eventdata, handles)
% hObject    handle to rot90ccw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rot90ccw
gatherAndUpdate(handles)


% --- Executes on button press in rot180.
function rot180_Callback(hObject, eventdata, handles)
% hObject    handle to rot180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rot180
gatherAndUpdate(handles)


% --- Executes on button press in reset_pushbutton.
function reset_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to reset_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gatherAndUpdate(handles)


% --- Executes on button press in flipHor.
function flipHor_Callback(hObject, eventdata, handles)
% hObject    handle to flipHor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flipHor
gatherAndUpdate(handles)

% --- Executes on button press in flipVer.
function flipVer_Callback(hObject, eventdata, handles)
% hObject    handle to flipVer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flipVer
gatherAndUpdate(handles)



function gatherAndUpdate(handles)

gatheredData = gatherData(handles);
rotateFile(handles, gatheredData)

function gatheredData = gatherData(handles)

gatheredData.reset_pushbutton = get(handles.reset_pushbutton, 'value');
gatheredData.rot90ccw = get(handles.rot90ccw, 'value');
gatheredData.rot90cw = get(handles.rot90cw, 'value');
gatheredData.rot180 = get(handles.rot180, 'value');
gatheredData.flipHor = get(handles.flipHor, 'value');
gatheredData.flipVer = get(handles.flipVer, 'value');

function rotateFile(handles, gd)

listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
indexOfFile = get(handles.listbox1, 'value');
selectedFile = listboxOfFiles{indexOfFile};

if gd.reset_pushbutton
    set(handles.rot90ccw, 'value', get(handles.rot90ccw, 'min'))
    set(handles.rot90cw, 'value', get(handles.rot90cw, 'min'))
    set(handles.rot180, 'value', get(handles.rot180, 'min'))
    set(handles.flipHor, 'value', get(handles.flipHor, 'min'))
    set(handles.flipVer, 'value', get(handles.flipVer, 'min'))
    
    rotatedFile = dicomread(selectedFile);
    imshow(rotatedFile,'DisplayRange', []);
elseif gd.rot90ccw
    rotatedFile = imrotate(dicomread(selectedFile),90);
    imshow(rotatedFile,'DisplayRange', []);
elseif gd.rot90cw
    rotatedFile = imrotate(dicomread(selectedFile),-90);
    imshow(rotatedFile,'DisplayRange', []);
elseif gd.rot180
    rotatedFile = imrotate(dicomread(selectedFile),180);
    imshow(rotatedFile,'DisplayRange', []);
elseif gd.flipHor
    rotatedFile = flipdim(dicomread(selectedFile),2);
    imshow(rotatedFile,'DisplayRange', []);
elseif gd.flipVer
    rotatedFile = flipdim(dicomread(selectedFile),1);
    imshow(rotatedFile,'DisplayRange', []);
end


% --- Executes on slider movement.
function sliderBrightness_Callback(hObject, eventdata, handles)
% hObject    handle to sliderBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

listboxOfFiles = cellstr(get(handles.listbox1, 'string'));
indexOfFile = get(handles.listbox1, 'value');
selectedFile = listboxOfFiles{indexOfFile};

[a, map] = imread(selectedFile);
x = ind2rgb(a, map);
b = get(handles.sliderBrightness,'value');
j = imadjust(x,[],[],b);
    axes(handles.axes1);
    imshow(j);






































% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







% --- Executes during object creation, after setting all properties.
function sliderBrightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function dynamicFilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dynamicFilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% ************* display(handles.dynamicFilename, 'String', dcm);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in none.
function none_Callback(hObject, eventdata, handles)
% hObject    handle to none (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of none
