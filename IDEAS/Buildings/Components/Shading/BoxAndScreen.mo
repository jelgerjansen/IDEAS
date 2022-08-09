within IDEAS.Buildings.Components.Shading;
model BoxAndScreen "Box and screen shading"


  parameter Modelica.Units.SI.Length hWin(min=0) "Window height"
    annotation (Dialog(group="Window properties"));
  parameter Modelica.Units.SI.Length wWin(min=0) "Window width"
    annotation (Dialog(group="Window properties"));

  parameter Modelica.Units.SI.Length wLeft(min=0)
    "Left overhang width measured from the window corner"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length wRight(min=0)
    "Right overhang width measured from the window corner"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length ovDep(min=0)
    "Overhang depth perpendicular to the wall plane"
    annotation (Dialog(group="Overhang properties"));
  parameter Modelica.Units.SI.Length ovGap(min=0)
    "Distance between window upper edge and overhang lower edge"
    annotation (Dialog(group="Overhang properties"));

  parameter Modelica.Units.SI.Length hFin(min=0)
    "Height of side fin above window"
    annotation (Dialog(group="Side fin properties"));
  parameter Modelica.Units.SI.Length finDep(min=0)
    "Side fin depth perpendicular to the wall plane"
    annotation (Dialog(group="Side fin properties"));
  parameter Modelica.Units.SI.Length finGap(min=0)
    "Vertical distance between side fin and window"
    annotation (Dialog(group="Side fin properties"));

  parameter Real shaCorr=0.24 "Shortwave transmittance of shortwave radiation";

  extends IDEAS.Buildings.Components.Shading.Interfaces.DoubleShading(
      redeclare IDEAS.Buildings.Components.Shading.Screen stateShading1(
        azi=azi,
        shaCorr=shaCorr,
        haveBoundaryPorts=false),
      redeclare IDEAS.Buildings.Components.Shading.Box stateShading2(
        azi=azi,
        hWin=hWin,
        wWin=wWin,
        wLeft=wLeft,
        wRight=wRight,
        ovDep=ovDep,
        ovGap=ovGap,
        hFin=hFin,
        finDep=finDep,
        finGap=finGap));

initial equation

    assert(ovDep > 0, "The depth of the overhang must be larger than zero, if this is not the case: just use Shading.Screen.");
    assert(finDep > 0, "The depth of the side fins must be larger than zero, if this is not the case: just use Shading.OverhangAndScreen.");

equation
  connect(stateShading2.port_frame, port_frame) annotation(
    Line(points = {{4, 0}, {4, 160}, {100, 160}}, color = {191, 0, 0}));
  connect(stateShading2.port_glazing, port_glazing) annotation(
    Line(points = {{4, -4}, {6, -4}, {6, 120}, {100, 120}}, color = {191, 0, 0}));
  connect(stateShading2.TDryBul, TDryBul) annotation(
    Line(points = {{4, -12}, {40, -12}, {40, -10}}, color = {0, 0, 127}));
  connect(Te, stateShading2.Te) annotation (Line(points={{-60,130},{-6,130},{-6,
          -2},{-1.5,-2}}, color={0,0,127}));
  connect(hForcedConExt, stateShading2.hForcedConExt) annotation (Line(points={
          {-60,110},{-8,110},{-8,-3.33333},{-1.5,-3.33333}}, color={0,0,127}));
  connect(TEnv, stateShading2.TEnv) annotation (Line(points={{-60,90},{-10,90},
          {-10,-4.66667},{-1.5,-4.66667}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 200}})),  Documentation(info="<html>
<p>This model describes the transient behaviour of solar irradiance on a window below a non-fixed horizontal or vertical overhang combined with a controllable screen.</p>
</html>", revisions="<html>
<ul>
<li>
July 18, 2022 by Filip Jorissen:<br/>
Refactored for #1270 for including thermal effect of screens.
</li>
<li>
July 2015, by Filip Jorissenr:<br/>
Now extending from IDEAS.Buildings.Components.Interfaces.DoubleShading.
</li>
<li>
December 2014, by Filip Jorissenr:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 200}}, preserveAspectRatio = false)));
end BoxAndScreen;
