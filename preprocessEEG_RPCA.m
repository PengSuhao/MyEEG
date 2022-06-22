% -------------------------------------------------------------------------
function X = preprocessEEG_RPCA(X, fs, options)
% X = preprocessEEG_RPCA(X, options)
%
% Input:
%       X - EEG data in the format of SamplesxChannels
%       fs - sampling rate in Hz
%       options (optional) - struct with the following fields
%           HPcutoff       - high-pass filter cut-off frequequency in Hz
%           eogchannels    - indices of EOG channels
%           badchannels    - indices of bad channels to 0 out
%
% All the usual EEG preprocessing, except epoching and epoch rejection as
% there are not events to epoch with in natural stimuli. duh! Instead, bad
% data is set = 0 in the continuous stream, which makes sense when
% computing covariance matrices but maybe not for other purposes.
%
% Author: Lucas Parra, 2015, Ivan Iotzov, 2017


if nargin < 3

  options.HPcutoff = 0.5;
  options.eogchannels = [];
  options.badchannels = [];

end

if ~isfield(options, 'HPcutoff')
  options.HPcutoff = 0.5;
end

if ~isfield(options, 'eogchannels')
  options.eogchannels = [];
end

if ~isfield(options, 'badchannels')
  options.badchannels = [];
end

% generate high-pass filter
[b, a, k] = butter(5, options.HPcutoff / fs * 2, 'high');
sos = zp2sos(b, a, k);

% get size of data
[T, D] = size(X);

data = X(:,:);

% make sure there are no NaNs to start with
data(isnan(data)) = 0;

% remove starting offset to avoid filter transient
data = data - repmat(data(1, :), T, 1);

% high-pass filter the data
data = sosfilt(sos, data);

% regress out eye-movements
data = data - data(:, options.eogchannels) * (data(:, options.eogchannels) \ data);

% zero out bad channels
data(:, options.badchannels(:)) = 0;

% remove eog channels
data(:, options.eogchannels) = [];

% run RPCA on data
data = inexact_alm_rpca(data);

% remove 40ms before and after
h=[1; zeros(round(0.04 * fs) - 1, 1)];
data = filter(h, 1, flipud(filter(h, 1, flipud(data))));

% Mark NaNs as 0
data(isnan(data)) = 0;

X = data;

end
