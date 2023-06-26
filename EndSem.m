ss = stateSpaceSE2;
sv = validatorOccupancyMap(ss);
load exampleMaps
map = binaryOccupancyMap(25,25,75);

%x = [4.5; 3.0; 15.0];
%y = [3.0; 12.0; 15.0];

%Help taken from Matlab Documentation

object1 = [4.5, 3.0];
object2 = [3.0, 12.0];
object3 = [15.0, 15.0];

setOccupancy(map, object3, ones(1,1))

%setOccupancy(map, [x y], ones(3,1))
inflate(map, 1.5)
setOccupancy(map, object2, ones(1,1))
setOccupancy(map, object1, ones(1,1))
inflate(map, 2)
figure
show(map)
sv.Map = map;
sv.ValidationDistance = 0.01;
ss.StateBounds = [map.XWorldLimits;map.YWorldLimits; [-pi pi]];
planner = plannerRRT(ss,sv);
planner.MaxConnectionDistance = 0.3;
start = [1.0,1.0,0];
goal = [20.0,20.0,0];
rng(100,'twister'); % for repeatable result
[pthObj,solnInfo] = planner.plan(start,goal);
map.show; hold on;
plot(solnInfo.TreeData(:,1),solnInfo.TreeData(:,2),'.-'); % tree expansion
plot(pthObj.States(:,1), pthObj.States(:,2),'r-','LineWidth',2) % draw path