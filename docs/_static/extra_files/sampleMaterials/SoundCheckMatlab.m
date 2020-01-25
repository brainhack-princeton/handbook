% PURPOSE: TEST SOUND WITH EXAMPLE FUNCTIONAL SCAN
dbstop if error;
Screen('Preference', 'SkipSyncTests', 2);

%toml_file = '/Volumes/norman/amennen/github/brainiak/rt-cloud/projects/greenEyes/conf/greenEyes_organized.toml';
toml_file = '/Data1/code/rt-cloud/projects/greenEyes/conf/greenEyes_organized.toml';
addpath(genpath('matlab-toml'));
raw_text = fileread(toml_file);
cfg = toml.decode(raw_text);

if strcmp(cfg.machine, 'intel')
    fmri = 1;
else
    fmri = 0;
end
useButtonBox = cfg.display.useButtonBox;

if fmri == 1 % this is just if you're in the scanner room or not but it will always look for triggers
    repo_path ='/Data1/code/rt-cloud/projects/greenEyes/';
else
    repo_path = '/Volumes/norman/amennen/github/brainiak/rt-cloud/projects/greenEyes/';
end
display_path = [repo_path 'display'];

cd(display_path);
wavfilename = [display_path '/stimuli/test_audio.wav'];
%% check audio volume in the scanner
if fmri
    %AUDIO_DEVICENAME = 'HDA Creative: ALC898 Analog (hw:3,0)';
    AUDIO_DEVICENAME = 'HDA Creative: ALC898 Analog';
    AUDIO_devices=PsychPortAudio('GetDevices');
    for dev = 1:length(AUDIO_devices)
        devName = AUDIO_devices(dev).DeviceName;
        %if strcmp(devName,AUDIO_DEVICENAME)
        if length(devName) > length(AUDIO_DEVICENAME)
            if all(AUDIO_DEVICENAME==devName(1:length(AUDIO_DEVICENAME)))
                AUDIODEVICE = AUDIO_devices(dev).DeviceIndex;
            end
        end
    end
end

%%
[y, freq] = audioread(wavfilename);
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows
if ~fmri
    pahandle = PsychPortAudio('Open', [], [], [], freq, nrchannels);
else
    pahandle = PsychPortAudio('Open', AUDIODEVICE, [], [], freq, nrchannels);
end
PsychPortAudio('FillBuffer', pahandle, wavedata);

%% now open screen
textColor = 255;
textFont = 'Arial';
textSize = 35;
textSpacing = 25;
backColor = 127;

screenNumbers = Screen('Screens');
screenNum = screenNumbers(end);
[screenX screenY] = Screen('WindowSize',screenNum);
% put this back in!!!
windowSize.degrees = [51 30];
resolution = Screen('Resolution', screenNum);
if fmri
    screenX = 1280;
    screenY = 720;
end
mainWindow = Screen(screenNum,'OpenWindow',backColor,[0 0 screenX screenY]);
ifi = Screen('GetFlipInterval', mainWindow);
slack  = ifi/2;
% details of main window
centerX = screenX/2; centerY = screenY/2;
Screen(mainWindow,'TextFont',textFont);
Screen(mainWindow,'TextSize',textSize);

instruct = ['Key press volume control:\n\nINDEX for lower volume --> MIDDLE for higher volume\n\n PRESS PINKY TO SIGNAL OKAY VOLUME'];
DrawFormattedText(mainWindow,instruct,'center','center',textColor,70,[],[],1.2)
    %Screen('drawtext',mainWindow,basicInstruct{i},centerX-tempBounds(3)/2,screenY*(1/3)+1.5*textSpacing*(i-1),textColor);
    %clear tempBounds;
%end
Screen('Flip',mainWindow);
%%
DEVICE = -1;
if useButtonBox && fmri
    DEVICENAME = 'Current Designs, Inc. 932';
    [index devName] = GetKeyboardIndices;
    for device = 1:length(index)
        if strcmp(devName(device),DEVICENAME)
            DEVICE = index(device);
        end
    end
elseif ~useButtonBox && fmri 
    % let's set it to look for the Dell keyboard instead
    DEVICENAME = 'Dell KB216 Wired Keyboard';
    [index devName] = GetKeyboardIndices;
    for device = 1:length(index)
        if strcmp(devName(device),DEVICENAME)
            DEVICE = index(device);
        end
    end
end

KbName('UnifyKeyNames');
ONE = KbName('1!');
TWO = KbName('2@');
THREE = KbName('3#');
FOUR = KbName('4$');
%%
tStart = GetSecs;
tOn = PsychPortAudio('Start', pahandle, 0, tStart);
waitForKeyboard(FOUR,DEVICE);

tOff = PsychPortAudio('Stop', pahandle,0);
PsychPortAudio('Close', pahandle);
sca;


