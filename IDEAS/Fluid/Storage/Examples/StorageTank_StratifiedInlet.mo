within IDEAS.Fluid.Storage.Examples;
model StorageTank_StratifiedInlet
  "Example of a perfectly stratified inlet in a storage tank"
  extends Modelica.Icons.Example;

  package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater annotation (
      __Dymola_choicesAllMatching=true);
  constant SI.MassFlowRate m_flow_nominal=0.05 "Nominal mass flow rate";

  Fluid.Storage.StorageTank storageTank(
    nbrNodes=5,
    heightTank=2,
    TInitial=340:-10:300,
    volumeTank=0.2,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{34,-6},{8,34}})));
  IDEAS.Fluid.Storage.BaseClasses.StratifiedInlet stratifiedInlet(
    nbrNodes=5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-58,14},{-38,34}})));

  Fluid.Movers.Pump pump(
    m=1,
    m_flow_nominal=m_flow_nominal,
    useInput=true,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-14,-2},{-34,-22}})));
  IDEAS.Fluid.FixedResistances.Pipe_HeatPort heatedPipe(
    m=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    TInitial=278.15)
    annotation (Placement(transformation(extent={{-58,-2},{-78,-22}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=1000)
    annotation (Placement(transformation(extent={{-96,-54},{-76,-34}})));
  Modelica.Blocks.Sources.Pulse pulse(period=400)
    annotation (Placement(transformation(extent={{-56,-68},{-36,-48}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium = Medium,
    nPorts=1,
    p=200000) annotation (Placement(transformation(extent={{42,-42},{22,-22}})));

equation
  connect(fixedHeatFlow.port, heatedPipe.heatPort) annotation (Line(
      points={{-76,-44},{-68,-44},{-68,-22}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pulse.y, pump.m_flowSet) annotation (Line(
      points={{-35,-58},{-24,-58},{-24,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(stratifiedInlet.port_b, storageTank.ports) annotation (Line(
      points={{-38.2,24},{-16,24},{-16,24.7692},{8,24.7692}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pump.port_a, storageTank.port_b) annotation (Line(
      points={{-14,-12},{-4,-12},{-4,-2.92308},{8,-2.92308}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(boundary.ports[1], storageTank.port_b) annotation (Line(
      points={{22,-32},{8,-32},{8,-2.92308}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatedPipe.port_a, pump.port_b) annotation (Line(
      points={{-58,-12},{-34,-12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatedPipe.port_b, stratifiedInlet.port_a) annotation (Line(
      points={{-78,-12},{-90,-12},{-90,24},{-58,24}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics),
    experiment(StopTime=10000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model demonstrates the stratified inlet: charging the tank will keep a perfect stratification, even if the inlet temperature varies.</p>
</html>", revisions="<html>
<ul>
<li>March 2014 by Filip Jorissen:<br/> 
Annex60 compatibility
</li>
</ul>
</html>"));
end StorageTank_StratifiedInlet;