%% EXAMPLE: Building and utlizing dictionaries
% 11/08/2025       |      RASIKA R. KALE

%% Create a Dictionary from scratch

% Create a dictionary using containers.Map
ExampleDictionary = containers.Map({'key1', 'key2', 'key3'}, {"Simulation Test", "Equivalence Test", "System Test"});

% Access a value from the dictionary using a key
value = ExampleDictionary('key2');

% Add a new key-value pair to the dictionary
ExampleDictionary('key4') = "Tests";

% Remove a key-value pair from the dictionary
remove(ExampleDictionary, 'key1');

% Check if a key exists in the dictionary
keyExists = isKey(ExampleDictionary, 'key3');

% Retrieve all keys from the dictionary
allKeys = keys(ExampleDictionary);

% Retrieve all values from the dictionary
allValues = values(ExampleDictionary);

% Display the contents of the dictionary
disp(ExampleDictionary);

% Update the value of an existing key
ExampleDictionary('key2') = "Untestable";

% Iterate through all keys and display their corresponding values
for i = 1:length(allKeys)
    fprintf('Key: %s, Value: %d\n', allKeys{i}, allValues{i});
end

% Clear the dictionary
ExampleDictionary = containers.Map();

% Recreate the dictionary with new key-value pairs
ExampleDictionary = containers.Map({'newKey1', 'newKey2'}, {'Points', 20});

% Access and display the value of the newly added key
newValue = ExampleDictionary('newKey2');
fprintf('New Key: newKey2, Value: %d\n', newValue);

% Check if the new key exists in the dictionary
newKeyExists = isKey(ExampleDictionary, 'newKey1');
fprintf('New Key: newKey1 exists: %d\n', newKeyExists);

% Display the total number of key-value pairs in the dictionary
numPairs = length(keys(ExampleDictionary));
fprintf('Total key-value pairs in the dictionary: %d\n', numPairs);

% Display the contents of the updated dictionary
disp(ExampleDictionary);

% Iterate through all values and display their corresponding keys
for j = 1:length(allValues)
    fprintf('Value: %d, Key: %s\n', allValues{j}, allKeys{j});
end

% Clear the dictionary again for demonstration
ExampleDictionary = containers.Map();

%% Build custom dictionary by importing structures from other .m files

% Import structures from other .m files to build a custom dictionary
customData = load('customData.mat'); % Assuming customData.mat contains a structure
customKeys = fieldnames(customData);
customValues = struct2cell(customData);

% Create a new dictionary from the imported custom data
customDictionary = containers.Map(customKeys, customValues);

% Display the contents of the custom dictionary
disp(customDictionary);

% Access a specific value from the custom dictionary
specificValue = customDictionary(customKeys{1});
fprintf('Specific Key: %s, Value: %d\n', customKeys{1}, specificValue);

% Clear the custom dictionary for further use
customDictionary = containers.Map();

% Add a new key-value pair to the custom dictionary
customDictionary('newCustomKey') = 100;

% Display the total number of key-value pairs in the custom dictionary
numCustomPairs = length(keys(customDictionary));
fprintf('Total key-value pairs in the custom dictionary: %d\n', numCustomPairs);

% Iterate through all keys in the custom dictionary and display their corresponding values
for k = 1:length(customKeys)
    fprintf('Custom Key: %s, Value: %d\n', customKeys{k}, customValues{k});
end

% Clear the custom dictionary again for demonstration
customDictionary = containers.Map();

% Clear the ExampleDictionary for a fresh start
ExampleDictionary = containers.Map();
