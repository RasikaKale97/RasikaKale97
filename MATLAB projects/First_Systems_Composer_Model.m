% 10/20/2025
clc
clear

%% First System Composer Model Creation EXAMPLE: Microsoft Edge
% INFO %

%% Initialize the model and dictionary
modelName      = "mobileRobotAPI";
dictionaryName = "SensorInterfaces.sldd";

%% Create a new System Composer model

model = systemcomposer.createModel(modelName);
arch  = model.Architecture;

%% Create a data dictionary and add interfaces

dictionary = systemcomposer.createDictionary(dictionaryName);
interface  = dictionary.addInterface("GPSInterface");
element    = interface.addElement("SignalStrength");
valueType  = dictionary.addValueType("SignalStrengthType", Units="dB", Description="GPS Signal Strength");
element.setType(valueType);

%% Add a physical interface and link the dictionary to the model

physicalInterface = dictionary.addPhysicalInterface("PhysicalInterface");
physicalElement   = addElement(physicalInterface, "ElectricalElement", Type="electrical.electrical");
linkDictionary(model, "SensorInterfaces.sldd");

%% Save the dictionary and model
dictionary.save;
model.save;

%% Add components, ports, and connections

componentSensor = addComponent(arch, "Sensor");
sensorPorts     = addPort(componentSensor.Architecture, {'MotionData', 'SensorPower'}, {'in', 'physical'});
sensorPorts(2).setInterface(physicalInterface);

componentPlanning = addComponent(arch, "Planning");
planningPorts     = addPort(componentPlanning.Architecture, {'Command', 'SensorPower1', 'MotionCommand', 'ControlCommand'}, {'in', 'physical', 'out', 'out'});
planningPorts(2).setInterface(physicalInterface);

componentMotion = addComponent(arch, "Motion");
motionPorts     = addPort(componentMotion.Architecture, {'MotionCommand', 'MotionData'}, {'in', 'out'});

% Define additional components and their interfaces
componentController = addComponent(arch, "Controller");
controllerPorts = addPort(componentController.Architecture, {'ControlCommand', 'Status'}, {'in', 'out'});

%% Create an owned interface and assign a value type

ownedInterface = motionPorts(2).createInterface("DataInterface");
ownedElement   = ownedInterface.addElement("Rotation");
subInterface   = ownedElement.createOwnedType(Units="degrees");

%% Connect components

connect(arch, componentSensor, componentPlanning, Rule="interface");
connect(arch, componentMotion, componentSensor);
connect(arch, componentPlanning, componentMotion);

%% Save and arrange the model layout
model.save;
Simulink.BlockDiagram.arrangeSystem(modelName);