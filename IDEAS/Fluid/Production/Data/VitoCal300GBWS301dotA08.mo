within IDEAS.Fluid.Production.Data;
record VitoCal300GBWS301dotA08
  import IDEAS;
  extends IDEAS.Fluid.Production.BaseClasses.PartialNonModulatingRecord(
    useTin1=true,
    useTout2=true,
    QNomRef=8000,
    heat={
      {0,       268.15,   273.15,   275.15,   283.15,  288.15},
      {308.15,  6874.2,   7858.5,   8348.6,   10298.4, 11472.9},
      {318.15,  6553.4,   7417.5,   7896.6,   9786.,   10961.6},
      {328.15,     0.,    7128.5,   7557.6,   9257.6,  10296.},
      {333.15,     0.,       0.,    7198.,    8935.2,  10005.}},
    cop={{0,268.15,273.15,275.15,283.15,288.15},{308.15,4.02,4.65,4.94,6.13,
        6.87},{318.15,3.02,3.45,3.69,4.66,5.27},{328.15,0,2.65,2.82,3.52,3.96},
        {333.15,0,0,2.44,3.06,3.45}},
    power={{0, 268.15,273.15,275.15,283.15,288.15},
            {308.15, 1710, 1690, 1690, 1680, 1670},
            {318.15, 2170, 2150, 2140, 2100, 2080},
            {328.15, 0, 2690, 2680, 2630, 2600},
            {333.15, 0, 0, 2950, 2920, 2900}},
    m1=3.4,
    m2=3.5,
    m1_flow_nominal=2600/3600,
    m2_flow_nominal=1800/3600,
    dp1_nominal=10000,
    dp2_nominal=10000,
    TMin=273.15 - 5,
    TMax=273.15 + 60);

end VitoCal300GBWS301dotA08;
