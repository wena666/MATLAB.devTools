function confDevTools(varargin)
% Configure the devTools by defining the `gitConf` object
%
% INPUT:
%     repoName:       Name of the repository (default: 'cobratoolbox')
%     launcher:       String with a header to be displayed when starting
%     nickName:       Short name of the repository
%     printLevel:     Verbose level (default: 1)
%     remoteRepoURL:  URL of the repository
%
% Note:
%    Currently, only 2 projects are defined:
%      - cobratoolbox: https://www.github.com/opencobra/cobratoolbox
%      - COBRA.tutorials: https://www.github.com/opencobra/COBRA.tutorials
%
% .. Author:
%      - Laurent Heirendt, January 2018
%

    global gitConf
    global gitCmd

    % define default values
    defaultRepoName = 'cobratoolbox';
    defaultLauncher = '\n\n      _____   _____   _____   _____     _____     |\n     /  ___| /  _  \\ |  _  \\ |  _  \\   / ___ \\    |   COnstraint-Based Reconstruction and Analysis\n     | |     | | | | | |_| | | |_| |  | |___| |   |   The COBRA Toolbox - 2017\n     | |     | | | | |  _  { |  _  /  |  ___  |   |\n     | |___  | |_| | | |_| | | | \\ \\  | |   | |   |   Documentation:\n     \\_____| \\_____/ |_____/ |_|  \\_\\ |_|   |_|   |   http://opencobra.github.io/cobratoolbox\n                                                  | \n\n';
    defaultRemoteRepoURL = 'https://github.com/opencobra/cobratoolbox.git';
    defaultNickName = 'cobratoolbox';
    defaultPrintLevel = 1;

    % setup the parser
    parser = inputParser();
    parser.addParamValue('repoName', defaultRepoName, @(x) ischar(x) && ~isempty(x));
    parser.addParamValue('launcher', defaultLauncher, @ischar);
    parser.addParamValue('nickName', defaultNickName, @(x) ischar(x) && ~isempty(x));
    parser.addParamValue('printLevel', defaultPrintLevel, @(x) isnumeric(x));
    parser.addParamValue('remoteRepoURL', defaultRemoteRepoURL, @(x) ischar(x) && ~isempty(x));

    % parse the input arguments
    if ~isempty(varargin)
        parser.parse(varargin{:});
    else
        parser.parse();
    end

    % retrieve the variables
    repoName = parser.Results.repoName;

    % define the configuration of other projects here
    if strcmpi(repoName, 'COBRA.tutorials')
        launcher = '\n\n       ~~~ COBRA.tutorials ~~~\n\n';
        remoteRepoURL = 'https://github.com/opencobra/COBRA.tutorials.git';
        nickName = 'COBRA.tutorials';
        printLevel = parser.Results.printLevel;
    else
        launcher = parser.Results.launcher;
        remoteRepoURL = parser.Results.remoteRepoURL;
        nickName = parser.Results.nickName;
        printLevel = parser.Results.printLevel;
        if printLevel > 0
            fprintf([' -- Assuming the default configuration (', nickName, ' repository)\n']);
        end
    end

    % definition of parameters
    gitConf.leadForkDirName = 'fork-';
    gitConf.exampleBranch = 'add-constraints';

    % define the printLevel
    gitConf.printLevel = printLevel;
    gitConf.launcher = launcher;
    gitConf.remoteRepoURL = remoteRepoURL;
    gitConf.nickName = nickName;

    % define the URL of the devTools
    gitConf.devToolsURL_SSH = 'git@github.com:opencobra/MATLAB.devTools.git';
    gitConf.devToolsURL_HTTPS = 'https://github.com/opencobra/MATLAB.devTools.git';
    gitConf.devTools_name = 'MATLAB.devTools';

    % definition of commands
    gitCmd.lead = 'dev>  ';
    gitCmd.success = ' (Success) ';
    gitCmd.fail = ' (Error) ';
    gitCmd.trail = '\n';

    % print out a success message
    printMsg(mfilename, [' The devTools have been configured (', nickName, ').']);
end
