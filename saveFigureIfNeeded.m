function saveFigureIfNeeded(shouldSave, caseno, fileName, figHandle, width, height)
    % Input validation
    if ~islogical(shouldSave)
        error('shouldSave must be a boolean');
    end
    if ~isnumeric(caseno) || caseno < 0 || mod(caseno, 1) ~= 0
        error('caseno must be a non-negative integer');
    end
    if ~ishandle(figHandle) || ~strcmp(get(figHandle, 'Type'), 'figure')
        error('figHandle must be a valid figure handle');
    end

    % Set default values for width and height if not provided
    if nargin < 5
        width = 600; % Default width
    end
    if nargin < 6
        height = 800; % Default height
    end
    
    % Proceed only if shouldSave is true
    if shouldSave
        % Create the directory if it doesn't exist
        folderName = sprintf('Case %d', caseno);
        if ~exist(folderName, 'dir')
            mkdir(folderName);
        end
        
        % Define the full file path
        fullPath = fullfile(folderName, fileName);
        
        % Set the figure size
        set(figHandle, 'PaperPositionMode', 'auto');
        set(figHandle, 'Units', 'pixels');
        set(figHandle, 'Position', [100, 100, width, height]); % Position includes [left, bottom, width, height]
        
        % Save the figure
        print(figHandle, fullPath, '-dpng', '-r0');
        fprintf('Figure saved to %s with size [%d, %d]\n', fullPath, width, height);
    else
        fprintf('Figure not saved.\n');
    end
end
