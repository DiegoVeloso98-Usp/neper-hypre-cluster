[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
  volumetric_locking_correction = 'true'
[]

[Mesh/file]
  type = 'FileMeshGenerator'
  file = '@MESH@'
[]

[Functions/tdisp]
  type = 'ParsedFunction'
  expression = '0.1*t'
[]

[AuxVariables/gcum]
  order = 'CONSTANT'
  family = 'MONOMIAL'
[]

[AuxKernels/gcum]
  type = 'MaterialStdVectorAux'
  variable = 'gcum'
  property = 'state_var'
  index = '0'
  execute_on = 'timestep_end'
[]

[Modules/TensorMechanics/Master/all]
  add_variables = 'true'
  strain = 'FINITE'
  generate_output = 'stress_xx stress_yy stress_zz strain_xx strain_yy strain_zz'
  incremental = 'true'
[]

[BCs/symmy]
  type = 'DirichletBC'
  variable = 'disp_y'
  boundary = 'y0'
  value = '0'
[]

[BCs/symmx]
  type = 'DirichletBC'
  variable = 'disp_x'
  boundary = 'x0'
  value = '0'
[]

[BCs/symmz]
  type = 'DirichletBC'
  variable = 'disp_z'
  boundary = 'z0'
  value = '0'
[]

[BCs/tdisp]
  type = 'FunctionDirichletBC'
  variable = 'disp_z'
  boundary = 'z1'
  function = 'tdisp'
[]

[UserObjects/uexternaldb]
  type = 'AbaqusUExternalDB'
  plugin = '@UMAT@'
  execute_on = 'INITIAL TIMESTEP_END TIMESTEP_BEGIN FINAL'
[]

[Preconditioning/smp]
  type = 'SMP'
  full = 'true'
[]

[Executioner]
  type = 'Transient'
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -pc_hypre_type -pc_hypre_boomeramg_strong_threshold -ksp_type -ksp_gmres_restart -ksp_min_it'
  petsc_options_value = 'hypre boomeramg 0.7 gmres 100 1'
  l_tol = '1e-6'
  nl_abs_tol = '5e-7'
  nl_rel_tol = '1e-5'
  nl_forced_its = '1'
  nl_max_its = '10'
  l_max_its = '500'
  start_time = '0.0'
  end_time = '4.9999999999999996e-06'
  dt = '1e-06'
  num_steps = '5'
  abort_on_solve_fail = 'true'
  l_abs_tol = '1e-12'
  reuse_preconditioner = 'true'
  reuse_preconditioner_max_linear_its = '25'
[]

[Executioner/Quadrature]
  type = 'GAUSS'
  element_order = 'SECOND'
  side_order = 'SECOND'
[]

[Executioner/Predictor]
  type = 'SimplePredictor'
  scale = '1'
[]

[Postprocessors/avg_sigma_11]
  type = 'ElementAverageValue'
  variable = 'stress_xx'
[]

[Postprocessors/avg_sigma_22]
  type = 'ElementAverageValue'
  variable = 'stress_yy'
[]

[Postprocessors/avg_sigma_33]
  type = 'ElementAverageValue'
  variable = 'stress_zz'
[]

[Postprocessors/avg_strain_11]
  type = 'ElementAverageValue'
  variable = 'strain_xx'
[]

[Postprocessors/avg_strain_22]
  type = 'ElementAverageValue'
  variable = 'strain_yy'
[]

[Postprocessors/avg_strain_33]
  type = 'ElementAverageValue'
  variable = 'strain_zz'
[]

[Postprocessors/avg_gcum]
  type = 'ElementAverageValue'
  variable = 'gcum'
[]

[Outputs]
  exodus = 'false'
  checkpoint = 'false'
  file_base = '@OUTPUT@'
[]

[Mesh]
  parallel_type = 'distributed'
[]

[Materials/grain_1]
  type = 'AbaqusUMATStress'
  block = 'poly1_HEX8'
  constant_properties = '37.197179036538 115.553777058622 -76.639503389226 1 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_2]
  type = 'AbaqusUMATStress'
  block = 'poly2_HEX8'
  constant_properties = '105.52100317588 43.461191108865 -251.980488627937 2 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_3]
  type = 'AbaqusUMATStress'
  block = 'poly3_HEX8'
  constant_properties = '-91.873632333697 75.154301577012 19.202892350086 3 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_4]
  type = 'AbaqusUMATStress'
  block = 'poly4_HEX8'
  constant_properties = '110.885186539808 84.073133220677 -237.738652042668 4 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_5]
  type = 'AbaqusUMATStress'
  block = 'poly5_HEX8'
  constant_properties = '150.227122784117 142.115997586879 8.467801996821 5 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_6]
  type = 'AbaqusUMATStress'
  block = 'poly6_HEX8'
  constant_properties = '-4.310082553476 126.162896300634 38.073836395378 6 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_7]
  type = 'AbaqusUMATStress'
  block = 'poly7_HEX8'
  constant_properties = '-63.61606194904 132.675705275979 139.550221878572 7 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_8]
  type = 'AbaqusUMATStress'
  block = 'poly8_HEX8'
  constant_properties = '211.666342670872 117.507594909097 -125.560248681631 8 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_9]
  type = 'AbaqusUMATStress'
  block = 'poly9_HEX8'
  constant_properties = '-195.617085362894 127.537894342233 148.168078849199 9 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_10]
  type = 'AbaqusUMATStress'
  block = 'poly10_HEX8'
  constant_properties = '-16.242756178715 115.387981414455 95.316267968295 10 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_11]
  type = 'AbaqusUMATStress'
  block = 'poly11_HEX8'
  constant_properties = '-110.286275428726 74.669464803416 -1.746436178938 11 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_12]
  type = 'AbaqusUMATStress'
  block = 'poly12_HEX8'
  constant_properties = '-104.874964300991 167.360714255481 -62.789186575514 12 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_13]
  type = 'AbaqusUMATStress'
  block = 'poly13_HEX8'
  constant_properties = '-78.770259173872 139.830976841021 147.566322878836 13 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_14]
  type = 'AbaqusUMATStress'
  block = 'poly14_HEX8'
  constant_properties = '142.034279969382 78.73327493262 -60.486412045422 14 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_15]
  type = 'AbaqusUMATStress'
  block = 'poly15_HEX8'
  constant_properties = '130.930755600466 145.423477321999 -106.234099096816 15 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_16]
  type = 'AbaqusUMATStress'
  block = 'poly16_HEX8'
  constant_properties = '-104.041851527832 63.444489882242 84.286221219548 16 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_17]
  type = 'AbaqusUMATStress'
  block = 'poly17_HEX8'
  constant_properties = '-85.230087695883 74.126749410139 109.555814476139 17 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_18]
  type = 'AbaqusUMATStress'
  block = 'poly18_HEX8'
  constant_properties = '237.597535829459 127.021924926324 -62.225422909624 18 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_19]
  type = 'AbaqusUMATStress'
  block = 'poly19_HEX8'
  constant_properties = '259.452045243929 31.748819459948 -85.746164595311 19 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_20]
  type = 'AbaqusUMATStress'
  block = 'poly20_HEX8'
  constant_properties = '-125.20369524576 161.878923399457 233.532927449807 20 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_21]
  type = 'AbaqusUMATStress'
  block = 'poly21_HEX8'
  constant_properties = '6.153958154918 129.850560359435 130.934708572857 21 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_22]
  type = 'AbaqusUMATStress'
  block = 'poly22_HEX8'
  constant_properties = '18.583168671528 165.72609600698 17.347205524865 22 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_23]
  type = 'AbaqusUMATStress'
  block = 'poly23_HEX8'
  constant_properties = '88.838686454334 121.038704573951 -58.427922803471 23 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_24]
  type = 'AbaqusUMATStress'
  block = 'poly24_HEX8'
  constant_properties = '136.763997766175 51.517252237174 -120.135780864013 24 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_25]
  type = 'AbaqusUMATStress'
  block = 'poly25_HEX8'
  constant_properties = '173.643523437751 87.176552581913 3.824533314241 25 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_26]
  type = 'AbaqusUMATStress'
  block = 'poly26_HEX8'
  constant_properties = '-151.595023427093 79.074182713865 18.779879249392 26 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_27]
  type = 'AbaqusUMATStress'
  block = 'poly27_HEX8'
  constant_properties = '-172.202793971116 44.136908305674 130.537219469601 27 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_28]
  type = 'AbaqusUMATStress'
  block = 'poly28_HEX8'
  constant_properties = '-182.395957020164 47.324535447585 161.245037747036 28 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_29]
  type = 'AbaqusUMATStress'
  block = 'poly29_HEX8'
  constant_properties = '52.490653891656 65.920579184347 -108.526283241102 29 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_30]
  type = 'AbaqusUMATStress'
  block = 'poly30_HEX8'
  constant_properties = '100.486565716784 105.000209543628 -127.186454496997 30 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_31]
  type = 'AbaqusUMATStress'
  block = 'poly31_HEX8'
  constant_properties = '67.862835629765 106.320326252891 21.326611661402 31 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_32]
  type = 'AbaqusUMATStress'
  block = 'poly32_HEX8'
  constant_properties = '68.563093158213 98.286935934825 24.681910268952 32 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_33]
  type = 'AbaqusUMATStress'
  block = 'poly33_HEX8'
  constant_properties = '-18.131064959092 68.26575767295 -91.385729830963 33 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_34]
  type = 'AbaqusUMATStress'
  block = 'poly34_HEX8'
  constant_properties = '-6.447216407698 59.292928227344 132.102501062004 34 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_35]
  type = 'AbaqusUMATStress'
  block = 'poly35_HEX8'
  constant_properties = '-110.270924740271 130.026068041224 136.475146016721 35 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_36]
  type = 'AbaqusUMATStress'
  block = 'poly36_HEX8'
  constant_properties = '213.73544636049 106.073286806936 -80.15384259094 36 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_37]
  type = 'AbaqusUMATStress'
  block = 'poly37_HEX8'
  constant_properties = '-17.851421576481 141.017843951092 139.178865891836 37 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_38]
  type = 'AbaqusUMATStress'
  block = 'poly38_HEX8'
  constant_properties = '3.707866203424 93.865932981002 50.070544103214 38 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_39]
  type = 'AbaqusUMATStress'
  block = 'poly39_HEX8'
  constant_properties = '-56.843427145779 36.861667449993 -97.189925368485 39 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_40]
  type = 'AbaqusUMATStress'
  block = 'poly40_HEX8'
  constant_properties = '-136.882421607397 131.068464762119 56.830720373386 40 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_41]
  type = 'AbaqusUMATStress'
  block = 'poly41_HEX8'
  constant_properties = '-69.07373809211 81.249563185934 -80.823105407159 41 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_42]
  type = 'AbaqusUMATStress'
  block = 'poly42_HEX8'
  constant_properties = '13.496188460196 147.04763011527 96.475370600833 42 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_43]
  type = 'AbaqusUMATStress'
  block = 'poly43_HEX8'
  constant_properties = '225.585752311506 104.58716534111 -66.402825456788 43 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_44]
  type = 'AbaqusUMATStress'
  block = 'poly44_HEX8'
  constant_properties = '79.913490003411 74.573722118708 2.13501986351 44 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_45]
  type = 'AbaqusUMATStress'
  block = 'poly45_HEX8'
  constant_properties = '-254.275925281447 62.21977615913 86.935297281545 45 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_46]
  type = 'AbaqusUMATStress'
  block = 'poly46_HEX8'
  constant_properties = '-223.590679075632 26.980953546511 102.966223265794 46 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_47]
  type = 'AbaqusUMATStress'
  block = 'poly47_HEX8'
  constant_properties = '168.979709975694 92.001927920849 -161.389594254178 47 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_48]
  type = 'AbaqusUMATStress'
  block = 'poly48_HEX8'
  constant_properties = '23.943117609578 173.617846884467 -170.24589829606 48 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_49]
  type = 'AbaqusUMATStress'
  block = 'poly49_HEX8'
  constant_properties = '-86.992106525718 36.564136097835 -83.756983758863 49 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_50]
  type = 'AbaqusUMATStress'
  block = 'poly50_HEX8'
  constant_properties = '-114.935706070458 78.478453908936 -45.729357960235 50 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_51]
  type = 'AbaqusUMATStress'
  block = 'poly51_HEX8'
  constant_properties = '26.060086227136 140.743102920078 -3.862879130987 51 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_52]
  type = 'AbaqusUMATStress'
  block = 'poly52_HEX8'
  constant_properties = '84.366402287163 142.292053477303 53.456539662082 52 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_53]
  type = 'AbaqusUMATStress'
  block = 'poly53_HEX8'
  constant_properties = '-22.205766044418 102.491371186137 14.121902030665 53 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_54]
  type = 'AbaqusUMATStress'
  block = 'poly54_HEX8'
  constant_properties = '-49.125259662937 120.364324392427 -28.062623946029 54 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_55]
  type = 'AbaqusUMATStress'
  block = 'poly55_HEX8'
  constant_properties = '153.946002242983 24.991353943851 13.667146356025 55 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_56]
  type = 'AbaqusUMATStress'
  block = 'poly56_HEX8'
  constant_properties = '129.959361938395 86.943105701312 -211.56657053184 56 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_57]
  type = 'AbaqusUMATStress'
  block = 'poly57_HEX8'
  constant_properties = '-72.601466321672 101.96189824698 -86.02412427895 57 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_58]
  type = 'AbaqusUMATStress'
  block = 'poly58_HEX8'
  constant_properties = '-40.795965261086 110.077299041126 98.951711076473 58 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_59]
  type = 'AbaqusUMATStress'
  block = 'poly59_HEX8'
  constant_properties = '-73.42093408164 64.537704475154 185.316364440403 59 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_60]
  type = 'AbaqusUMATStress'
  block = 'poly60_HEX8'
  constant_properties = '126.17992325226 157.205470635521 -72.497851309834 60 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_61]
  type = 'AbaqusUMATStress'
  block = 'poly61_HEX8'
  constant_properties = '144.005134922731 94.587195397001 -84.517493714015 61 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_62]
  type = 'AbaqusUMATStress'
  block = 'poly62_HEX8'
  constant_properties = '161.381300702759 96.867075803028 -45.237882475076 62 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_63]
  type = 'AbaqusUMATStress'
  block = 'poly63_HEX8'
  constant_properties = '185.766844333025 43.949684830276 -94.313549443928 63 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_64]
  type = 'AbaqusUMATStress'
  block = 'poly64_HEX8'
  constant_properties = '12.079508282613 48.067200563926 155.209788277325 64 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_65]
  type = 'AbaqusUMATStress'
  block = 'poly65_HEX8'
  constant_properties = '-158.432804371904 96.174438281111 80.210027517628 65 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_66]
  type = 'AbaqusUMATStress'
  block = 'poly66_HEX8'
  constant_properties = '-185.646911328295 20.893559794992 95.331704398061 66 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_67]
  type = 'AbaqusUMATStress'
  block = 'poly67_HEX8'
  constant_properties = '-118.13776897835 115.199081049771 36.953411223196 67 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_68]
  type = 'AbaqusUMATStress'
  block = 'poly68_HEX8'
  constant_properties = '17.210499415814 159.86006377693 67.998943061886 68 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_69]
  type = 'AbaqusUMATStress'
  block = 'poly69_HEX8'
  constant_properties = '-244.511061248353 77.678962219002 91.707590203839 69 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_70]
  type = 'AbaqusUMATStress'
  block = 'poly70_HEX8'
  constant_properties = '-207.205022867414 133.251468793958 129.561315747481 70 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_71]
  type = 'AbaqusUMATStress'
  block = 'poly71_HEX8'
  constant_properties = '118.290818165632 95.323245575241 -101.89873522944 71 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_72]
  type = 'AbaqusUMATStress'
  block = 'poly72_HEX8'
  constant_properties = '27.659539465812 122.372383020873 -38.355613463247 72 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_73]
  type = 'AbaqusUMATStress'
  block = 'poly73_HEX8'
  constant_properties = '65.00715140659 147.967527686659 48.331061166062 73 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_74]
  type = 'AbaqusUMATStress'
  block = 'poly74_HEX8'
  constant_properties = '9.449200275365 46.065641001009 56.923580157637 74 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_75]
  type = 'AbaqusUMATStress'
  block = 'poly75_HEX8'
  constant_properties = '-21.396918105984 110.698528426323 45.481882800896 75 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_76]
  type = 'AbaqusUMATStress'
  block = 'poly76_HEX8'
  constant_properties = '163.259847013156 101.221904948752 -107.906318452055 76 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_77]
  type = 'AbaqusUMATStress'
  block = 'poly77_HEX8'
  constant_properties = '-9.367955278173 135.974956882807 -70.246693186083 77 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_78]
  type = 'AbaqusUMATStress'
  block = 'poly78_HEX8'
  constant_properties = '-36.458844644956 30.183633463739 97.980102077034 78 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_79]
  type = 'AbaqusUMATStress'
  block = 'poly79_HEX8'
  constant_properties = '170.992545456145 105.203725723464 -75.816867822045 79 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_80]
  type = 'AbaqusUMATStress'
  block = 'poly80_HEX8'
  constant_properties = '-40.819106019389 83.166985911855 82.099749890127 80 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_81]
  type = 'AbaqusUMATStress'
  block = 'poly81_HEX8'
  constant_properties = '181.630339717864 103.168469270461 -69.73753612972 81 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_82]
  type = 'AbaqusUMATStress'
  block = 'poly82_HEX8'
  constant_properties = '-65.64439113378 74.334382408028 136.368690656568 82 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_83]
  type = 'AbaqusUMATStress'
  block = 'poly83_HEX8'
  constant_properties = '121.519972155812 67.771649953113 -194.383696590718 83 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_84]
  type = 'AbaqusUMATStress'
  block = 'poly84_HEX8'
  constant_properties = '-61.488927598455 148.163706102874 -93.770899822975 84 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_85]
  type = 'AbaqusUMATStress'
  block = 'poly85_HEX8'
  constant_properties = '-214.975054079762 168.513453753108 56.641056271437 85 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_86]
  type = 'AbaqusUMATStress'
  block = 'poly86_HEX8'
  constant_properties = '42.144588482056 33.415216107226 -71.648310932211 86 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_87]
  type = 'AbaqusUMATStress'
  block = 'poly87_HEX8'
  constant_properties = '-158.506550486424 80.960180559817 90.983987110232 87 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_88]
  type = 'AbaqusUMATStress'
  block = 'poly88_HEX8'
  constant_properties = '113.656233350535 98.413085710021 -9.705591903325 88 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_89]
  type = 'AbaqusUMATStress'
  block = 'poly89_HEX8'
  constant_properties = '162.848863168413 95.197155099468 -13.609510902388 89 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_90]
  type = 'AbaqusUMATStress'
  block = 'poly90_HEX8'
  constant_properties = '116.67047878229 98.925680749032 -179.107874178073 90 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_91]
  type = 'AbaqusUMATStress'
  block = 'poly91_HEX8'
  constant_properties = '-6.564152409734 153.750991646791 -42.614347819595 91 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_92]
  type = 'AbaqusUMATStress'
  block = 'poly92_HEX8'
  constant_properties = '17.847128195305 53.345130564914 -68.391777505767 92 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_93]
  type = 'AbaqusUMATStress'
  block = 'poly93_HEX8'
  constant_properties = '160.820152255595 150.098732209563 -136.630254669349 93 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_94]
  type = 'AbaqusUMATStress'
  block = 'poly94_HEX8'
  constant_properties = '-14.075307597726 119.327449300339 -54.194003409647 94 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_95]
  type = 'AbaqusUMATStress'
  block = 'poly95_HEX8'
  constant_properties = '57.175689991291 72.639603913556 114.959249142638 95 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_96]
  type = 'AbaqusUMATStress'
  block = 'poly96_HEX8'
  constant_properties = '-206.661851677487 97.541333173531 52.199090013579 96 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_97]
  type = 'AbaqusUMATStress'
  block = 'poly97_HEX8'
  constant_properties = '10.710227929411 47.02981024978 -152.417112256808 97 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_98]
  type = 'AbaqusUMATStress'
  block = 'poly98_HEX8'
  constant_properties = '72.274846793641 122.973006702799 -86.97242968459 98 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_99]
  type = 'AbaqusUMATStress'
  block = 'poly99_HEX8'
  constant_properties = '41.035620465602 67.352112843322 133.064008301497 99 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_100]
  type = 'AbaqusUMATStress'
  block = 'poly100_HEX8'
  constant_properties = '134.824465816316 74.135919079102 -138.604658192084 100 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_101]
  type = 'AbaqusUMATStress'
  block = 'poly101_HEX8'
  constant_properties = '-2.466183934989 135.544152039397 61.963427112883 101 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_102]
  type = 'AbaqusUMATStress'
  block = 'poly102_HEX8'
  constant_properties = '25.152066228584 74.247419320636 -162.977250783051 102 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_103]
  type = 'AbaqusUMATStress'
  block = 'poly103_HEX8'
  constant_properties = '75.78775940293 107.632146935903 -230.484903409522 103 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_104]
  type = 'AbaqusUMATStress'
  block = 'poly104_HEX8'
  constant_properties = '-97.725646409822 100.205771656086 30.272203460928 104 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_105]
  type = 'AbaqusUMATStress'
  block = 'poly105_HEX8'
  constant_properties = '-89.855999069648 70.762333772786 267.244596080717 105 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_106]
  type = 'AbaqusUMATStress'
  block = 'poly106_HEX8'
  constant_properties = '139.608551850193 52.741704886882 -144.792402842077 106 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_107]
  type = 'AbaqusUMATStress'
  block = 'poly107_HEX8'
  constant_properties = '-25.890816352335 90.451580131709 118.014988144292 107 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_108]
  type = 'AbaqusUMATStress'
  block = 'poly108_HEX8'
  constant_properties = '28.011072697661 79.645032538274 109.439219361958 108 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_109]
  type = 'AbaqusUMATStress'
  block = 'poly109_HEX8'
  constant_properties = '-134.310883459351 133.183324093868 102.746176836864 109 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_110]
  type = 'AbaqusUMATStress'
  block = 'poly110_HEX8'
  constant_properties = '29.088559116675 87.412754365011 -12.43899334233 110 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_111]
  type = 'AbaqusUMATStress'
  block = 'poly111_HEX8'
  constant_properties = '-158.884283739002 58.516261932471 0.157842669821 111 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_112]
  type = 'AbaqusUMATStress'
  block = 'poly112_HEX8'
  constant_properties = '145.977648692062 113.219556589801 -1.62007805009 112 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_113]
  type = 'AbaqusUMATStress'
  block = 'poly113_HEX8'
  constant_properties = '105.201444256939 129.929401404152 -200.254114048485 113 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_114]
  type = 'AbaqusUMATStress'
  block = 'poly114_HEX8'
  constant_properties = '55.797263597015 126.738196659314 106.550961039336 114 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_115]
  type = 'AbaqusUMATStress'
  block = 'poly115_HEX8'
  constant_properties = '-158.848802825364 162.833406062603 156.538676105767 115 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_116]
  type = 'AbaqusUMATStress'
  block = 'poly116_HEX8'
  constant_properties = '-199.229210831221 94.195014548827 133.259422865956 116 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_117]
  type = 'AbaqusUMATStress'
  block = 'poly117_HEX8'
  constant_properties = '30.908908618871 86.537777744837 85.167231494131 117 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_118]
  type = 'AbaqusUMATStress'
  block = 'poly118_HEX8'
  constant_properties = '-3.649367557014 28.537812720295 -105.220265378917 118 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_119]
  type = 'AbaqusUMATStress'
  block = 'poly119_HEX8'
  constant_properties = '-0.252811868023 10.008103328316 179.434189654002 119 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_120]
  type = 'AbaqusUMATStress'
  block = 'poly120_HEX8'
  constant_properties = '12.282948440838 48.419875861807 -45.745484542002 120 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_121]
  type = 'AbaqusUMATStress'
  block = 'poly121_HEX8'
  constant_properties = '-163.005011622153 87.964450419975 68.115471239863 121 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_122]
  type = 'AbaqusUMATStress'
  block = 'poly122_HEX8'
  constant_properties = '-124.734876054348 109.50736828087 117.801172546282 122 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_123]
  type = 'AbaqusUMATStress'
  block = 'poly123_HEX8'
  constant_properties = '95.948409031866 161.952411488786 -178.238716363352 123 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_124]
  type = 'AbaqusUMATStress'
  block = 'poly124_HEX8'
  constant_properties = '77.744765487794 85.272456028568 -100.985297347521 124 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_125]
  type = 'AbaqusUMATStress'
  block = 'poly125_HEX8'
  constant_properties = '88.802743569207 72.930560446129 -209.93260528884 125 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_126]
  type = 'AbaqusUMATStress'
  block = 'poly126_HEX8'
  constant_properties = '189.218112072088 101.084680772576 -21.211589928341 126 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_127]
  type = 'AbaqusUMATStress'
  block = 'poly127_HEX8'
  constant_properties = '-104.833996805995 81.116149764225 -19.433296858112 127 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_128]
  type = 'AbaqusUMATStress'
  block = 'poly128_HEX8'
  constant_properties = '-40.631621261662 94.304533013306 215.142373224167 128 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_129]
  type = 'AbaqusUMATStress'
  block = 'poly129_HEX8'
  constant_properties = '-37.684081710665 21.749700517499 138.045827884578 129 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_130]
  type = 'AbaqusUMATStress'
  block = 'poly130_HEX8'
  constant_properties = '54.436780247574 57.169626966283 -72.987790379603 130 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_131]
  type = 'AbaqusUMATStress'
  block = 'poly131_HEX8'
  constant_properties = '-94.518579858026 134.454609532054 -84.919185893855 131 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_132]
  type = 'AbaqusUMATStress'
  block = 'poly132_HEX8'
  constant_properties = '91.403526219972 75.964751320027 30.959057836664 132 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_133]
  type = 'AbaqusUMATStress'
  block = 'poly133_HEX8'
  constant_properties = '185.316288448378 52.775162707953 -104.720024906878 133 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_134]
  type = 'AbaqusUMATStress'
  block = 'poly134_HEX8'
  constant_properties = '92.837777236179 94.848404000875 -142.568849363134 134 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_135]
  type = 'AbaqusUMATStress'
  block = 'poly135_HEX8'
  constant_properties = '-91.260947545025 44.874622037157 218.264634804069 135 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_136]
  type = 'AbaqusUMATStress'
  block = 'poly136_HEX8'
  constant_properties = '-173.888096890371 49.2891301653 41.921440911695 136 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_137]
  type = 'AbaqusUMATStress'
  block = 'poly137_HEX8'
  constant_properties = '119.865919777181 65.061086369805 -198.451601714357 137 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_138]
  type = 'AbaqusUMATStress'
  block = 'poly138_HEX8'
  constant_properties = '-0.528006837327 39.048297408817 49.747012340988 138 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_139]
  type = 'AbaqusUMATStress'
  block = 'poly139_HEX8'
  constant_properties = '179.4301435423 130.17371056948 -42.291398161258 139 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_140]
  type = 'AbaqusUMATStress'
  block = 'poly140_HEX8'
  constant_properties = '-25.324704700453 45.896887899626 -89.929620322271 140 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_141]
  type = 'AbaqusUMATStress'
  block = 'poly141_HEX8'
  constant_properties = '-89.226997847347 89.746198852384 3.623739720484 141 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_142]
  type = 'AbaqusUMATStress'
  block = 'poly142_HEX8'
  constant_properties = '93.856808657873 106.673719249131 -239.253775417705 142 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_143]
  type = 'AbaqusUMATStress'
  block = 'poly143_HEX8'
  constant_properties = '-143.567443568917 86.604156957343 127.966533776325 143 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_144]
  type = 'AbaqusUMATStress'
  block = 'poly144_HEX8'
  constant_properties = '25.056389883109 34.802610118412 -133.83995310196 144 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_145]
  type = 'AbaqusUMATStress'
  block = 'poly145_HEX8'
  constant_properties = '22.468439140522 75.247572430177 85.820432798074 145 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_146]
  type = 'AbaqusUMATStress'
  block = 'poly146_HEX8'
  constant_properties = '-81.088356875246 89.257398660281 169.007221944122 146 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_147]
  type = 'AbaqusUMATStress'
  block = 'poly147_HEX8'
  constant_properties = '110.149432017933 130.369397926198 -90.960018349806 147 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_148]
  type = 'AbaqusUMATStress'
  block = 'poly148_HEX8'
  constant_properties = '95.219823651671 72.504513951183 19.865036333445 148 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_149]
  type = 'AbaqusUMATStress'
  block = 'poly149_HEX8'
  constant_properties = '135.151882885332 103.402729290586 -63.102226255133 149 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_150]
  type = 'AbaqusUMATStress'
  block = 'poly150_HEX8'
  constant_properties = '-97.936422071925 64.468045869696 -13.079738211626 150 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_151]
  type = 'AbaqusUMATStress'
  block = 'poly151_HEX8'
  constant_properties = '-36.065558203909 66.177820888851 -63.766327636109 151 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_152]
  type = 'AbaqusUMATStress'
  block = 'poly152_HEX8'
  constant_properties = '33.054880416544 115.970929891284 -106.85969687298 152 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_153]
  type = 'AbaqusUMATStress'
  block = 'poly153_HEX8'
  constant_properties = '-110.863496544288 42.109681207768 -54.143954499993 153 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_154]
  type = 'AbaqusUMATStress'
  block = 'poly154_HEX8'
  constant_properties = '-129.531339290622 110.514141324774 91.525357185267 154 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_155]
  type = 'AbaqusUMATStress'
  block = 'poly155_HEX8'
  constant_properties = '-93.495551421278 4.951153823102 42.089698140965 155 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_156]
  type = 'AbaqusUMATStress'
  block = 'poly156_HEX8'
  constant_properties = '101.438221927453 16.798472634273 -151.398415271626 156 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_157]
  type = 'AbaqusUMATStress'
  block = 'poly157_HEX8'
  constant_properties = '94.92502693991 95.757635479048 -136.220044969124 157 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_158]
  type = 'AbaqusUMATStress'
  block = 'poly158_HEX8'
  constant_properties = '32.390760554484 141.888523499753 -46.148201020377 158 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_159]
  type = 'AbaqusUMATStress'
  block = 'poly159_HEX8'
  constant_properties = '130.542631648682 133.847881981894 -34.342966340544 159 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_160]
  type = 'AbaqusUMATStress'
  block = 'poly160_HEX8'
  constant_properties = '95.835391403868 73.543714055424 23.512798182604 160 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_161]
  type = 'AbaqusUMATStress'
  block = 'poly161_HEX8'
  constant_properties = '58.017470780056 122.194370275778 51.177609648994 161 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_162]
  type = 'AbaqusUMATStress'
  block = 'poly162_HEX8'
  constant_properties = '-184.765125652818 70.290416779502 104.845539411978 162 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_163]
  type = 'AbaqusUMATStress'
  block = 'poly163_HEX8'
  constant_properties = '82.736595218435 37.110306512025 67.035052426903 163 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_164]
  type = 'AbaqusUMATStress'
  block = 'poly164_HEX8'
  constant_properties = '44.16583090699 36.812336836891 84.40118023198 164 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_165]
  type = 'AbaqusUMATStress'
  block = 'poly165_HEX8'
  constant_properties = '-69.628833829007 119.444831378864 191.499403217273 165 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_166]
  type = 'AbaqusUMATStress'
  block = 'poly166_HEX8'
  constant_properties = '-257.210394223798 44.275632656657 100.280637044542 166 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_167]
  type = 'AbaqusUMATStress'
  block = 'poly167_HEX8'
  constant_properties = '-74.00737775429 114.560698409155 193.145645463084 167 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_168]
  type = 'AbaqusUMATStress'
  block = 'poly168_HEX8'
  constant_properties = '-17.418953524699 151.285400070897 73.591927534771 168 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_169]
  type = 'AbaqusUMATStress'
  block = 'poly169_HEX8'
  constant_properties = '-223.945573020631 26.574868907706 124.595678920901 169 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_170]
  type = 'AbaqusUMATStress'
  block = 'poly170_HEX8'
  constant_properties = '-171.113971569403 59.465805911066 128.594169578519 170 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_171]
  type = 'AbaqusUMATStress'
  block = 'poly171_HEX8'
  constant_properties = '-131.579283680706 123.845811099261 -42.03284226347 171 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_172]
  type = 'AbaqusUMATStress'
  block = 'poly172_HEX8'
  constant_properties = '-28.473916340028 147.702410102986 167.328459793983 172 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_173]
  type = 'AbaqusUMATStress'
  block = 'poly173_HEX8'
  constant_properties = '115.407539883757 81.209493836404 -31.714018621851 173 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_174]
  type = 'AbaqusUMATStress'
  block = 'poly174_HEX8'
  constant_properties = '-22.812788409346 92.115503021046 198.346245083074 174 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_175]
  type = 'AbaqusUMATStress'
  block = 'poly175_HEX8'
  constant_properties = '-43.356779114411 106.88803431039 -98.628642278995 175 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_176]
  type = 'AbaqusUMATStress'
  block = 'poly176_HEX8'
  constant_properties = '70.597889893386 56.959702706233 -173.958621526357 176 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_177]
  type = 'AbaqusUMATStress'
  block = 'poly177_HEX8'
  constant_properties = '52.32077778037 143.392934198831 77.339999510054 177 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_178]
  type = 'AbaqusUMATStress'
  block = 'poly178_HEX8'
  constant_properties = '-66.464445412854 83.21484943185 -48.897100686802 178 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_179]
  type = 'AbaqusUMATStress'
  block = 'poly179_HEX8'
  constant_properties = '38.964940328262 44.689755262699 64.396555596033 179 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_180]
  type = 'AbaqusUMATStress'
  block = 'poly180_HEX8'
  constant_properties = '-65.532748710219 165.448106178154 199.372813210894 180 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_181]
  type = 'AbaqusUMATStress'
  block = 'poly181_HEX8'
  constant_properties = '30.64990883345 141.436932951185 -4.509828319844 181 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_182]
  type = 'AbaqusUMATStress'
  block = 'poly182_HEX8'
  constant_properties = '16.938564056904 139.002846549567 38.411725810142 182 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_183]
  type = 'AbaqusUMATStress'
  block = 'poly183_HEX8'
  constant_properties = '8.475648502947 75.725524612185 -122.615396840397 183 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_184]
  type = 'AbaqusUMATStress'
  block = 'poly184_HEX8'
  constant_properties = '-89.418201525764 79.089304942151 24.790926837146 184 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_185]
  type = 'AbaqusUMATStress'
  block = 'poly185_HEX8'
  constant_properties = '197.925554664254 118.564619434571 -79.559580181487 185 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_186]
  type = 'AbaqusUMATStress'
  block = 'poly186_HEX8'
  constant_properties = '155.845064301225 108.939584992326 -188.712477170191 186 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_187]
  type = 'AbaqusUMATStress'
  block = 'poly187_HEX8'
  constant_properties = '103.160883241186 107.882790991148 -207.402156822096 187 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_188]
  type = 'AbaqusUMATStress'
  block = 'poly188_HEX8'
  constant_properties = '6.992056672989 74.860200123221 -18.977456595841 188 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_189]
  type = 'AbaqusUMATStress'
  block = 'poly189_HEX8'
  constant_properties = '129.735681990774 45.925085729036 -109.087778364811 189 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_190]
  type = 'AbaqusUMATStress'
  block = 'poly190_HEX8'
  constant_properties = '-27.262027670997 98.271242224463 -90.776412438845 190 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_191]
  type = 'AbaqusUMATStress'
  block = 'poly191_HEX8'
  constant_properties = '-92.0121328915 55.318129616619 -74.334876117357 191 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_192]
  type = 'AbaqusUMATStress'
  block = 'poly192_HEX8'
  constant_properties = '13.730287950599 58.808868213395 -190.399173274959 192 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_193]
  type = 'AbaqusUMATStress'
  block = 'poly193_HEX8'
  constant_properties = '123.90092364799 92.224343200175 -160.159748475584 193 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_194]
  type = 'AbaqusUMATStress'
  block = 'poly194_HEX8'
  constant_properties = '24.880451519778 106.529858269177 49.852977297526 194 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_195]
  type = 'AbaqusUMATStress'
  block = 'poly195_HEX8'
  constant_properties = '-249.115232258976 26.590569060633 78.634873965455 195 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_196]
  type = 'AbaqusUMATStress'
  block = 'poly196_HEX8'
  constant_properties = '-85.879106133612 77.696175830829 158.152884851108 196 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_197]
  type = 'AbaqusUMATStress'
  block = 'poly197_HEX8'
  constant_properties = '-49.485333560983 53.552825249216 -3.553382181525 197 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_198]
  type = 'AbaqusUMATStress'
  block = 'poly198_HEX8'
  constant_properties = '-13.146776995505 115.714761488385 41.864750777744 198 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_199]
  type = 'AbaqusUMATStress'
  block = 'poly199_HEX8'
  constant_properties = '-59.543164682219 88.65239185298 57.125979556956 199 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_200]
  type = 'AbaqusUMATStress'
  block = 'poly200_HEX8'
  constant_properties = '-35.686896674772 90.364944315332 194.050451691805 200 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_201]
  type = 'AbaqusUMATStress'
  block = 'poly201_HEX8'
  constant_properties = '29.818603187595 94.688304943509 42.605903956925 201 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_202]
  type = 'AbaqusUMATStress'
  block = 'poly202_HEX8'
  constant_properties = '-67.638570601961 92.085674682467 159.369315974453 202 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_203]
  type = 'AbaqusUMATStress'
  block = 'poly203_HEX8'
  constant_properties = '44.819733607724 151.426041958648 -168.458024285976 203 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_204]
  type = 'AbaqusUMATStress'
  block = 'poly204_HEX8'
  constant_properties = '-56.259616797998 100.308372071822 58.130440706033 204 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_205]
  type = 'AbaqusUMATStress'
  block = 'poly205_HEX8'
  constant_properties = '-196.99772950098 114.281911800865 149.174658090945 205 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_206]
  type = 'AbaqusUMATStress'
  block = 'poly206_HEX8'
  constant_properties = '84.931583464819 111.995868929733 68.847006123961 206 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_207]
  type = 'AbaqusUMATStress'
  block = 'poly207_HEX8'
  constant_properties = '-106.556006207691 99.540964588401 55.490850594926 207 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_208]
  type = 'AbaqusUMATStress'
  block = 'poly208_HEX8'
  constant_properties = '2.446946691751 109.17251572883 46.705690273117 208 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_209]
  type = 'AbaqusUMATStress'
  block = 'poly209_HEX8'
  constant_properties = '86.854760975814 151.972441683711 -155.091920574984 209 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_210]
  type = 'AbaqusUMATStress'
  block = 'poly210_HEX8'
  constant_properties = '-149.667154520404 134.073252442233 -29.227168746421 210 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_211]
  type = 'AbaqusUMATStress'
  block = 'poly211_HEX8'
  constant_properties = '-141.074028271082 62.93262098439 85.821507330105 211 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_212]
  type = 'AbaqusUMATStress'
  block = 'poly212_HEX8'
  constant_properties = '21.578970091337 22.00527198943 -169.712359379744 212 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_213]
  type = 'AbaqusUMATStress'
  block = 'poly213_HEX8'
  constant_properties = '132.514330075934 98.202647278011 -164.015871161897 213 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_214]
  type = 'AbaqusUMATStress'
  block = 'poly214_HEX8'
  constant_properties = '111.667744800274 71.403604247399 -1.624172902838 214 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_215]
  type = 'AbaqusUMATStress'
  block = 'poly215_HEX8'
  constant_properties = '128.488144467355 157.460820813284 -230.542144174214 215 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_216]
  type = 'AbaqusUMATStress'
  block = 'poly216_HEX8'
  constant_properties = '140.640151612788 136.585940210003 25.58782091186 216 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_217]
  type = 'AbaqusUMATStress'
  block = 'poly217_HEX8'
  constant_properties = '148.259084016873 38.166392867205 -133.163076665664 217 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_218]
  type = 'AbaqusUMATStress'
  block = 'poly218_HEX8'
  constant_properties = '74.204981622611 78.515219704156 5.707983918974 218 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_219]
  type = 'AbaqusUMATStress'
  block = 'poly219_HEX8'
  constant_properties = '60.106967206498 78.791594026156 -207.709454856446 219 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_220]
  type = 'AbaqusUMATStress'
  block = 'poly220_HEX8'
  constant_properties = '161.681540096249 157.056527309425 -159.642954592942 220 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_221]
  type = 'AbaqusUMATStress'
  block = 'poly221_HEX8'
  constant_properties = '116.141986296195 97.387076649986 -102.788018287155 221 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_222]
  type = 'AbaqusUMATStress'
  block = 'poly222_HEX8'
  constant_properties = '-13.048516327459 141.980420244597 -157.565146015743 222 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_223]
  type = 'AbaqusUMATStress'
  block = 'poly223_HEX8'
  constant_properties = '-83.594545012473 78.025793578407 251.196730324452 223 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_224]
  type = 'AbaqusUMATStress'
  block = 'poly224_HEX8'
  constant_properties = '-57.916044881468 153.531166941668 218.379786018584 224 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_225]
  type = 'AbaqusUMATStress'
  block = 'poly225_HEX8'
  constant_properties = '-67.971596140948 13.188318787757 13.075681926517 225 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_226]
  type = 'AbaqusUMATStress'
  block = 'poly226_HEX8'
  constant_properties = '-62.951234077234 166.707247733655 140.336211738911 226 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_227]
  type = 'AbaqusUMATStress'
  block = 'poly227_HEX8'
  constant_properties = '-261.507625150446 80.631066035202 92.151537268458 227 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_228]
  type = 'AbaqusUMATStress'
  block = 'poly228_HEX8'
  constant_properties = '110.202609714067 38.135964260572 -125.723742880038 228 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_229]
  type = 'AbaqusUMATStress'
  block = 'poly229_HEX8'
  constant_properties = '85.84156296974 46.222680256239 -63.872323976203 229 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_230]
  type = 'AbaqusUMATStress'
  block = 'poly230_HEX8'
  constant_properties = '-44.836568598366 127.400243196133 -94.086354174461 230 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_231]
  type = 'AbaqusUMATStress'
  block = 'poly231_HEX8'
  constant_properties = '-134.636921718883 58.608859163466 83.485479819087 231 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_232]
  type = 'AbaqusUMATStress'
  block = 'poly232_HEX8'
  constant_properties = '212.348932294628 100.902139293144 -81.47866150677 232 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_233]
  type = 'AbaqusUMATStress'
  block = 'poly233_HEX8'
  constant_properties = '-53.711502353293 87.83235436356 -43.435379587682 233 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_234]
  type = 'AbaqusUMATStress'
  block = 'poly234_HEX8'
  constant_properties = '-39.666906413108 76.462094206752 143.938453575753 234 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_235]
  type = 'AbaqusUMATStress'
  block = 'poly235_HEX8'
  constant_properties = '152.809600377244 20.327875678747 -130.414725986378 235 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_236]
  type = 'AbaqusUMATStress'
  block = 'poly236_HEX8'
  constant_properties = '98.644574984849 137.343676755766 -5.224718556169 236 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_237]
  type = 'AbaqusUMATStress'
  block = 'poly237_HEX8'
  constant_properties = '4.803618372299 167.49640573659 128.273156875568 237 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_238]
  type = 'AbaqusUMATStress'
  block = 'poly238_HEX8'
  constant_properties = '97.136926776762 75.932404506284 -50.544631336162 238 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_239]
  type = 'AbaqusUMATStress'
  block = 'poly239_HEX8'
  constant_properties = '120.904223905936 127.453405302734 -34.360035669248 239 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_240]
  type = 'AbaqusUMATStress'
  block = 'poly240_HEX8'
  constant_properties = '-85.723342323173 50.734996278075 -71.807888622596 240 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_241]
  type = 'AbaqusUMATStress'
  block = 'poly241_HEX8'
  constant_properties = '77.25110186401 104.622358955029 -252.479269141564 241 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_242]
  type = 'AbaqusUMATStress'
  block = 'poly242_HEX8'
  constant_properties = '-103.831156224371 27.70174791972 102.056672575814 242 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_243]
  type = 'AbaqusUMATStress'
  block = 'poly243_HEX8'
  constant_properties = '97.715285763302 89.136920436708 -66.983699769272 243 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_244]
  type = 'AbaqusUMATStress'
  block = 'poly244_HEX8'
  constant_properties = '141.289933458716 42.115402814702 17.834356209793 244 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_245]
  type = 'AbaqusUMATStress'
  block = 'poly245_HEX8'
  constant_properties = '119.154387923852 107.549959592109 -151.41093379782 245 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_246]
  type = 'AbaqusUMATStress'
  block = 'poly246_HEX8'
  constant_properties = '36.054847621593 88.796384379162 55.715900403954 246 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_247]
  type = 'AbaqusUMATStress'
  block = 'poly247_HEX8'
  constant_properties = '-19.268198577118 14.921107356303 197.498507807743 247 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_248]
  type = 'AbaqusUMATStress'
  block = 'poly248_HEX8'
  constant_properties = '110.600697322549 106.744168060299 -39.320633165276 248 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_249]
  type = 'AbaqusUMATStress'
  block = 'poly249_HEX8'
  constant_properties = '43.603343091659 116.454526142551 -139.138065451174 249 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_250]
  type = 'AbaqusUMATStress'
  block = 'poly250_HEX8'
  constant_properties = '-150.901446149391 136.025779620801 67.539219417966 250 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_251]
  type = 'AbaqusUMATStress'
  block = 'poly251_HEX8'
  constant_properties = '87.010917761922 37.566363260251 -15.633886444501 251 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_252]
  type = 'AbaqusUMATStress'
  block = 'poly252_HEX8'
  constant_properties = '30.301119854203 26.316829637197 98.579991153615 252 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_253]
  type = 'AbaqusUMATStress'
  block = 'poly253_HEX8'
  constant_properties = '-84.167433694993 26.089015142169 134.896974903031 253 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_254]
  type = 'AbaqusUMATStress'
  block = 'poly254_HEX8'
  constant_properties = '232.087048852836 21.477823705897 -122.263351950364 254 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_255]
  type = 'AbaqusUMATStress'
  block = 'poly255_HEX8'
  constant_properties = '-109.921757654968 130.911074706704 -66.603881382068 255 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_256]
  type = 'AbaqusUMATStress'
  block = 'poly256_HEX8'
  constant_properties = '178.633176485603 149.888133373443 -4.029287762255 256 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_257]
  type = 'AbaqusUMATStress'
  block = 'poly257_HEX8'
  constant_properties = '23.37576162694 138.906609549625 -78.568370802122 257 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_258]
  type = 'AbaqusUMATStress'
  block = 'poly258_HEX8'
  constant_properties = '68.571101474337 159.437160012701 -9.577619628873 258 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_259]
  type = 'AbaqusUMATStress'
  block = 'poly259_HEX8'
  constant_properties = '97.379424015929 63.102521489687 -246.343634364548 259 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_260]
  type = 'AbaqusUMATStress'
  block = 'poly260_HEX8'
  constant_properties = '-28.766750041018 35.145995717148 99.728197129305 260 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_261]
  type = 'AbaqusUMATStress'
  block = 'poly261_HEX8'
  constant_properties = '-180.859021050688 66.713821689184 29.532875234014 261 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_262]
  type = 'AbaqusUMATStress'
  block = 'poly262_HEX8'
  constant_properties = '-241.652270026264 113.663070361251 71.115025061102 262 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_263]
  type = 'AbaqusUMATStress'
  block = 'poly263_HEX8'
  constant_properties = '120.827588731023 98.292848505771 -135.059207444088 263 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_264]
  type = 'AbaqusUMATStress'
  block = 'poly264_HEX8'
  constant_properties = '-67.32402220304 19.217796149401 2.745333739758 264 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_265]
  type = 'AbaqusUMATStress'
  block = 'poly265_HEX8'
  constant_properties = '-239.821360752302 120.01133348834 107.098092363611 265 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_266]
  type = 'AbaqusUMATStress'
  block = 'poly266_HEX8'
  constant_properties = '176.157010999126 96.471164674228 -123.298867804588 266 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_267]
  type = 'AbaqusUMATStress'
  block = 'poly267_HEX8'
  constant_properties = '133.386558623281 106.49334926159 43.030003361034 267 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_268]
  type = 'AbaqusUMATStress'
  block = 'poly268_HEX8'
  constant_properties = '82.594275187247 131.997709844814 -189.233333933314 268 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_269]
  type = 'AbaqusUMATStress'
  block = 'poly269_HEX8'
  constant_properties = '86.956002831919 23.150180620642 -155.422187950132 269 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_270]
  type = 'AbaqusUMATStress'
  block = 'poly270_HEX8'
  constant_properties = '3.511456182802 104.868502000555 165.927794735865 270 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_271]
  type = 'AbaqusUMATStress'
  block = 'poly271_HEX8'
  constant_properties = '152.181858828073 152.361091853834 -110.35004622146 271 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_272]
  type = 'AbaqusUMATStress'
  block = 'poly272_HEX8'
  constant_properties = '-12.782865544559 73.569325163974 -109.354358447192 272 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_273]
  type = 'AbaqusUMATStress'
  block = 'poly273_HEX8'
  constant_properties = '-36.230083641021 44.24734845061 28.358326998565 273 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_274]
  type = 'AbaqusUMATStress'
  block = 'poly274_HEX8'
  constant_properties = '63.053722141608 88.621056829392 47.465997907496 274 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_275]
  type = 'AbaqusUMATStress'
  block = 'poly275_HEX8'
  constant_properties = '-83.345854710523 91.564987926687 -3.010544272863 275 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_276]
  type = 'AbaqusUMATStress'
  block = 'poly276_HEX8'
  constant_properties = '98.9935404843 56.129064450245 -131.766726864606 276 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_277]
  type = 'AbaqusUMATStress'
  block = 'poly277_HEX8'
  constant_properties = '151.576754152013 114.698840262921 -69.989922482105 277 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_278]
  type = 'AbaqusUMATStress'
  block = 'poly278_HEX8'
  constant_properties = '81.764128125922 94.874864356685 -168.932322333029 278 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_279]
  type = 'AbaqusUMATStress'
  block = 'poly279_HEX8'
  constant_properties = '223.927228543331 133.007239590598 -96.105790874481 279 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_280]
  type = 'AbaqusUMATStress'
  block = 'poly280_HEX8'
  constant_properties = '-69.168464600419 80.43737095178 51.276781633295 280 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_281]
  type = 'AbaqusUMATStress'
  block = 'poly281_HEX8'
  constant_properties = '97.069429126548 122.669946672581 -229.091118297464 281 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_282]
  type = 'AbaqusUMATStress'
  block = 'poly282_HEX8'
  constant_properties = '-48.047191366528 81.397130996966 3.465033670843 282 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_283]
  type = 'AbaqusUMATStress'
  block = 'poly283_HEX8'
  constant_properties = '98.455725438548 118.391672287474 -210.691060000409 283 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_284]
  type = 'AbaqusUMATStress'
  block = 'poly284_HEX8'
  constant_properties = '204.481987014211 161.604232955638 -64.664167022919 284 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_285]
  type = 'AbaqusUMATStress'
  block = 'poly285_HEX8'
  constant_properties = '13.915348142084 61.104968174283 160.679039815749 285 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_286]
  type = 'AbaqusUMATStress'
  block = 'poly286_HEX8'
  constant_properties = '-146.523015685023 74.345709410174 197.344163778955 286 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_287]
  type = 'AbaqusUMATStress'
  block = 'poly287_HEX8'
  constant_properties = '-141.898014457058 119.975679584495 24.9728146738 287 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_288]
  type = 'AbaqusUMATStress'
  block = 'poly288_HEX8'
  constant_properties = '-2.529106100331 67.268023326522 -31.476457793956 288 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_289]
  type = 'AbaqusUMATStress'
  block = 'poly289_HEX8'
  constant_properties = '-20.4621622047 94.756140565868 165.791014368065 289 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_290]
  type = 'AbaqusUMATStress'
  block = 'poly290_HEX8'
  constant_properties = '-217.753899821826 25.2233192858 88.684445281622 290 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_291]
  type = 'AbaqusUMATStress'
  block = 'poly291_HEX8'
  constant_properties = '-116.514472340193 4.384120330507 111.213712698386 291 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_292]
  type = 'AbaqusUMATStress'
  block = 'poly292_HEX8'
  constant_properties = '66.66389208309 164.810851858584 15.211104596715 292 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_293]
  type = 'AbaqusUMATStress'
  block = 'poly293_HEX8'
  constant_properties = '143.905135845489 122.884737636818 -63.546410191016 293 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_294]
  type = 'AbaqusUMATStress'
  block = 'poly294_HEX8'
  constant_properties = '187.694180548628 105.871723320094 -79.535341405748 294 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_295]
  type = 'AbaqusUMATStress'
  block = 'poly295_HEX8'
  constant_properties = '-190.858599716247 88.815955475075 91.147383543668 295 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_296]
  type = 'AbaqusUMATStress'
  block = 'poly296_HEX8'
  constant_properties = '-40.324464156969 90.871638455651 10.046263252243 296 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_297]
  type = 'AbaqusUMATStress'
  block = 'poly297_HEX8'
  constant_properties = '134.907018130976 142.356748929715 -116.952787845323 297 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_298]
  type = 'AbaqusUMATStress'
  block = 'poly298_HEX8'
  constant_properties = '6.004887742013 137.499332514037 -115.187090112487 298 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_299]
  type = 'AbaqusUMATStress'
  block = 'poly299_HEX8'
  constant_properties = '56.512773271664 135.289201585925 -93.911677787898 299 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_300]
  type = 'AbaqusUMATStress'
  block = 'poly300_HEX8'
  constant_properties = '69.408078953739 62.441154107285 -156.925722670616 300 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_301]
  type = 'AbaqusUMATStress'
  block = 'poly301_HEX8'
  constant_properties = '-139.739754307955 87.631764624661 123.791455356068 301 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_302]
  type = 'AbaqusUMATStress'
  block = 'poly302_HEX8'
  constant_properties = '-92.37063613279 90.357628217565 141.416244764091 302 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_303]
  type = 'AbaqusUMATStress'
  block = 'poly303_HEX8'
  constant_properties = '-165.343085313756 164.004017028804 19.321700884712 303 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_304]
  type = 'AbaqusUMATStress'
  block = 'poly304_HEX8'
  constant_properties = '48.306885858757 132.855002488738 -200.208583074509 304 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_305]
  type = 'AbaqusUMATStress'
  block = 'poly305_HEX8'
  constant_properties = '125.525434704039 83.716760307253 -157.251288604405 305 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_306]
  type = 'AbaqusUMATStress'
  block = 'poly306_HEX8'
  constant_properties = '-3.732912054945 94.163293026387 8.502219841595 306 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_307]
  type = 'AbaqusUMATStress'
  block = 'poly307_HEX8'
  constant_properties = '-83.829026730127 91.822955935697 251.638936004871 307 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_308]
  type = 'AbaqusUMATStress'
  block = 'poly308_HEX8'
  constant_properties = '-15.132140938112 104.658565776094 11.441502442795 308 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_309]
  type = 'AbaqusUMATStress'
  block = 'poly309_HEX8'
  constant_properties = '180.233681189569 101.898600858038 -22.303944563499 309 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_310]
  type = 'AbaqusUMATStress'
  block = 'poly310_HEX8'
  constant_properties = '166.798857073423 91.07403743436 -51.267805369361 310 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_311]
  type = 'AbaqusUMATStress'
  block = 'poly311_HEX8'
  constant_properties = '-46.493623910202 78.202530949517 202.868674298725 311 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_312]
  type = 'AbaqusUMATStress'
  block = 'poly312_HEX8'
  constant_properties = '-58.921726438267 78.198357292251 128.226410676499 312 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_313]
  type = 'AbaqusUMATStress'
  block = 'poly313_HEX8'
  constant_properties = '-14.931030045773 30.819503551643 -67.79911864315 313 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_314]
  type = 'AbaqusUMATStress'
  block = 'poly314_HEX8'
  constant_properties = '153.549572852806 37.505149001597 -90.42356748257 314 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_315]
  type = 'AbaqusUMATStress'
  block = 'poly315_HEX8'
  constant_properties = '72.484490768945 99.104434863916 -162.349007869384 315 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_316]
  type = 'AbaqusUMATStress'
  block = 'poly316_HEX8'
  constant_properties = '57.619932951462 88.324274598078 96.172431557825 316 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_317]
  type = 'AbaqusUMATStress'
  block = 'poly317_HEX8'
  constant_properties = '-235.325451960929 157.843475912365 55.763417323142 317 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_318]
  type = 'AbaqusUMATStress'
  block = 'poly318_HEX8'
  constant_properties = '18.151493665198 36.974669086176 -172.085259685094 318 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_319]
  type = 'AbaqusUMATStress'
  block = 'poly319_HEX8'
  constant_properties = '-28.95765878621 112.347854137571 -58.137731602848 319 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_320]
  type = 'AbaqusUMATStress'
  block = 'poly320_HEX8'
  constant_properties = '153.433728488861 93.170742173826 -166.933107320245 320 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_321]
  type = 'AbaqusUMATStress'
  block = 'poly321_HEX8'
  constant_properties = '-72.759764944768 56.192896699568 186.647958212581 321 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_322]
  type = 'AbaqusUMATStress'
  block = 'poly322_HEX8'
  constant_properties = '69.602880712525 107.374386962593 -67.579249115599 322 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_323]
  type = 'AbaqusUMATStress'
  block = 'poly323_HEX8'
  constant_properties = '-101.869725911021 98.193295112449 52.974647781164 323 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_324]
  type = 'AbaqusUMATStress'
  block = 'poly324_HEX8'
  constant_properties = '252.948888915618 41.072701493592 -87.281779670409 324 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_325]
  type = 'AbaqusUMATStress'
  block = 'poly325_HEX8'
  constant_properties = '-75.980266660963 80.3167729839 72.088928813753 325 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_326]
  type = 'AbaqusUMATStress'
  block = 'poly326_HEX8'
  constant_properties = '-243.53756811526 91.357899532833 103.091133049519 326 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_327]
  type = 'AbaqusUMATStress'
  block = 'poly327_HEX8'
  constant_properties = '12.343594096114 124.341230613052 -128.660848305537 327 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_328]
  type = 'AbaqusUMATStress'
  block = 'poly328_HEX8'
  constant_properties = '143.54016391318 155.7410378307 -179.870043934129 328 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_329]
  type = 'AbaqusUMATStress'
  block = 'poly329_HEX8'
  constant_properties = '187.887352831373 68.21148824325 -127.681433564081 329 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_330]
  type = 'AbaqusUMATStress'
  block = 'poly330_HEX8'
  constant_properties = '102.31864974592 36.586502352195 40.626467736508 330 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_331]
  type = 'AbaqusUMATStress'
  block = 'poly331_HEX8'
  constant_properties = '-162.185263054824 152.138447035229 22.161865493341 331 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_332]
  type = 'AbaqusUMATStress'
  block = 'poly332_HEX8'
  constant_properties = '-39.254772381207 64.940412378338 48.438018155707 332 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_333]
  type = 'AbaqusUMATStress'
  block = 'poly333_HEX8'
  constant_properties = '127.383163811053 125.921543179863 -114.855160578842 333 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_334]
  type = 'AbaqusUMATStress'
  block = 'poly334_HEX8'
  constant_properties = '-118.073618963657 18.463339733934 44.233494878785 334 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_335]
  type = 'AbaqusUMATStress'
  block = 'poly335_HEX8'
  constant_properties = '151.289733820497 23.362109056283 -105.69309339593 335 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_336]
  type = 'AbaqusUMATStress'
  block = 'poly336_HEX8'
  constant_properties = '-236.494574976606 124.875787781244 71.408160380619 336 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_337]
  type = 'AbaqusUMATStress'
  block = 'poly337_HEX8'
  constant_properties = '159.39399860601 77.726134575241 -86.448330869708 337 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_338]
  type = 'AbaqusUMATStress'
  block = 'poly338_HEX8'
  constant_properties = '-99.526650039093 89.069071702117 196.895517560242 338 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_339]
  type = 'AbaqusUMATStress'
  block = 'poly339_HEX8'
  constant_properties = '191.204358583588 27.965610107412 -58.868715861835 339 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_340]
  type = 'AbaqusUMATStress'
  block = 'poly340_HEX8'
  constant_properties = '-6.940173516328 51.463477566221 88.142875287839 340 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_341]
  type = 'AbaqusUMATStress'
  block = 'poly341_HEX8'
  constant_properties = '18.73164556057 50.444994764002 -105.255608496753 341 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_342]
  type = 'AbaqusUMATStress'
  block = 'poly342_HEX8'
  constant_properties = '134.274140054407 38.666968639392 1.881798174417 342 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_343]
  type = 'AbaqusUMATStress'
  block = 'poly343_HEX8'
  constant_properties = '94.149889182759 63.636230684813 -229.194271816117 343 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_344]
  type = 'AbaqusUMATStress'
  block = 'poly344_HEX8'
  constant_properties = '189.48167306607 130.216591702323 -105.105738066894 344 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_345]
  type = 'AbaqusUMATStress'
  block = 'poly345_HEX8'
  constant_properties = '144.267659807343 163.113749424463 27.493561781203 345 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_346]
  type = 'AbaqusUMATStress'
  block = 'poly346_HEX8'
  constant_properties = '-93.680512052238 16.04959455974 261.989959029996 346 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_347]
  type = 'AbaqusUMATStress'
  block = 'poly347_HEX8'
  constant_properties = '-140.903759499268 91.093875820924 137.744436215331 347 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_348]
  type = 'AbaqusUMATStress'
  block = 'poly348_HEX8'
  constant_properties = '123.99860933921 165.177217393797 -98.174475383137 348 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_349]
  type = 'AbaqusUMATStress'
  block = 'poly349_HEX8'
  constant_properties = '-2.346240273806 104.764948811176 177.831707901259 349 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_350]
  type = 'AbaqusUMATStress'
  block = 'poly350_HEX8'
  constant_properties = '28.601918308877 91.699554061923 104.275096142827 350 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_351]
  type = 'AbaqusUMATStress'
  block = 'poly351_HEX8'
  constant_properties = '-58.028946142651 123.119698371776 47.518753599738 351 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_352]
  type = 'AbaqusUMATStress'
  block = 'poly352_HEX8'
  constant_properties = '-51.531641546895 169.620344103579 -46.243552496888 352 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_353]
  type = 'AbaqusUMATStress'
  block = 'poly353_HEX8'
  constant_properties = '-136.263937447378 115.269586844754 223.402595674137 353 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_354]
  type = 'AbaqusUMATStress'
  block = 'poly354_HEX8'
  constant_properties = '-96.776686125099 71.445786885427 242.687165650617 354 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_355]
  type = 'AbaqusUMATStress'
  block = 'poly355_HEX8'
  constant_properties = '-94.129085455937 28.877523234771 118.552770584453 355 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_356]
  type = 'AbaqusUMATStress'
  block = 'poly356_HEX8'
  constant_properties = '-42.942753479703 48.467897097329 -129.559931751044 356 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_357]
  type = 'AbaqusUMATStress'
  block = 'poly357_HEX8'
  constant_properties = '-130.873764770098 109.675360411377 54.169418316474 357 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_358]
  type = 'AbaqusUMATStress'
  block = 'poly358_HEX8'
  constant_properties = '-70.65183712925 101.201438929995 -45.617711211949 358 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_359]
  type = 'AbaqusUMATStress'
  block = 'poly359_HEX8'
  constant_properties = '-148.520480024543 102.525035568303 -9.985923953323 359 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_360]
  type = 'AbaqusUMATStress'
  block = 'poly360_HEX8'
  constant_properties = '-73.520448922393 30.714644957048 143.184420985309 360 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_361]
  type = 'AbaqusUMATStress'
  block = 'poly361_HEX8'
  constant_properties = '141.536530919516 40.752670983436 10.673629746384 361 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_362]
  type = 'AbaqusUMATStress'
  block = 'poly362_HEX8'
  constant_properties = '-234.534695415619 134.315379879891 54.665360113604 362 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_363]
  type = 'AbaqusUMATStress'
  block = 'poly363_HEX8'
  constant_properties = '140.330263010557 77.00218426486 -184.591372637545 363 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_364]
  type = 'AbaqusUMATStress'
  block = 'poly364_HEX8'
  constant_properties = '-99.538675490434 78.180447939133 59.712975606268 364 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_365]
  type = 'AbaqusUMATStress'
  block = 'poly365_HEX8'
  constant_properties = '-1.509405201983 135.902203356004 49.128844343235 365 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_366]
  type = 'AbaqusUMATStress'
  block = 'poly366_HEX8'
  constant_properties = '-35.384460193853 49.305440698546 159.31743518269 366 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_367]
  type = 'AbaqusUMATStress'
  block = 'poly367_HEX8'
  constant_properties = '-97.758565019988 118.85270267691 182.942254909899 367 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_368]
  type = 'AbaqusUMATStress'
  block = 'poly368_HEX8'
  constant_properties = '75.636956281358 125.05471155246 19.775266122535 368 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_369]
  type = 'AbaqusUMATStress'
  block = 'poly369_HEX8'
  constant_properties = '59.408934789795 124.323154969802 42.012786061202 369 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_370]
  type = 'AbaqusUMATStress'
  block = 'poly370_HEX8'
  constant_properties = '-239.052392165854 31.285746084626 74.967057833345 370 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_371]
  type = 'AbaqusUMATStress'
  block = 'poly371_HEX8'
  constant_properties = '-120.89971760095 56.068393816324 233.060117089758 371 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_372]
  type = 'AbaqusUMATStress'
  block = 'poly372_HEX8'
  constant_properties = '71.551249848686 105.126357354188 -72.645386358109 372 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_373]
  type = 'AbaqusUMATStress'
  block = 'poly373_HEX8'
  constant_properties = '3.471538888367 104.336202461726 -140.468080068392 373 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_374]
  type = 'AbaqusUMATStress'
  block = 'poly374_HEX8'
  constant_properties = '20.139456661875 92.37277359875 89.816445486575 374 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_375]
  type = 'AbaqusUMATStress'
  block = 'poly375_HEX8'
  constant_properties = '71.95402046446 95.390079975881 -11.791554442613 375 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_376]
  type = 'AbaqusUMATStress'
  block = 'poly376_HEX8'
  constant_properties = '-23.335361620685 66.859602563476 153.615876923672 376 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_377]
  type = 'AbaqusUMATStress'
  block = 'poly377_HEX8'
  constant_properties = '139.401354450492 141.126037239399 -20.247392685895 377 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_378]
  type = 'AbaqusUMATStress'
  block = 'poly378_HEX8'
  constant_properties = '-136.31828478001 68.224811147244 -30.113516871334 378 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_379]
  type = 'AbaqusUMATStress'
  block = 'poly379_HEX8'
  constant_properties = '-28.843732008549 101.137434882343 126.178221297901 379 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_380]
  type = 'AbaqusUMATStress'
  block = 'poly380_HEX8'
  constant_properties = '87.087416908397 14.387315547806 36.608109073957 380 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_381]
  type = 'AbaqusUMATStress'
  block = 'poly381_HEX8'
  constant_properties = '225.631493183713 131.186689468467 -64.4463412344 381 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_382]
  type = 'AbaqusUMATStress'
  block = 'poly382_HEX8'
  constant_properties = '131.222830059487 35.610142192026 -115.434541272213 382 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_383]
  type = 'AbaqusUMATStress'
  block = 'poly383_HEX8'
  constant_properties = '-145.351447807685 104.537698819382 211.103136742031 383 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_384]
  type = 'AbaqusUMATStress'
  block = 'poly384_HEX8'
  constant_properties = '37.140629144278 104.064625290944 -83.533246296592 384 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_385]
  type = 'AbaqusUMATStress'
  block = 'poly385_HEX8'
  constant_properties = '34.648213451179 88.791900823784 -167.773794028885 385 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_386]
  type = 'AbaqusUMATStress'
  block = 'poly386_HEX8'
  constant_properties = '59.198369647343 129.059232196228 -202.356617562725 386 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_387]
  type = 'AbaqusUMATStress'
  block = 'poly387_HEX8'
  constant_properties = '-87.983680006837 70.911041280613 128.563155661929 387 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_388]
  type = 'AbaqusUMATStress'
  block = 'poly388_HEX8'
  constant_properties = '-4.043922381133 101.257886935474 72.418825405584 388 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_389]
  type = 'AbaqusUMATStress'
  block = 'poly389_HEX8'
  constant_properties = '157.254562393277 106.725199433108 -87.650924749838 389 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_390]
  type = 'AbaqusUMATStress'
  block = 'poly390_HEX8'
  constant_properties = '210.549738715365 41.799890028703 -75.421653415575 390 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_391]
  type = 'AbaqusUMATStress'
  block = 'poly391_HEX8'
  constant_properties = '-99.049927478002 90.019352751373 -61.478032507233 391 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_392]
  type = 'AbaqusUMATStress'
  block = 'poly392_HEX8'
  constant_properties = '111.649588953852 107.222919275384 -36.750229497881 392 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_393]
  type = 'AbaqusUMATStress'
  block = 'poly393_HEX8'
  constant_properties = '-19.510925233207 51.04410563544 -67.444309264623 393 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_394]
  type = 'AbaqusUMATStress'
  block = 'poly394_HEX8'
  constant_properties = '-201.412953071057 66.40404375547 24.091240138111 394 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_395]
  type = 'AbaqusUMATStress'
  block = 'poly395_HEX8'
  constant_properties = '200.330441952134 55.698907746151 -73.581431031323 395 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_396]
  type = 'AbaqusUMATStress'
  block = 'poly396_HEX8'
  constant_properties = '54.972205968299 78.094598832009 -142.16147502971 396 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_397]
  type = 'AbaqusUMATStress'
  block = 'poly397_HEX8'
  constant_properties = '-146.792175467824 44.769668051597 126.820152928719 397 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_398]
  type = 'AbaqusUMATStress'
  block = 'poly398_HEX8'
  constant_properties = '-38.006773813243 118.814039846098 183.873580388553 398 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_399]
  type = 'AbaqusUMATStress'
  block = 'poly399_HEX8'
  constant_properties = '184.017260891316 55.674076588958 -63.433099190594 399 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_400]
  type = 'AbaqusUMATStress'
  block = 'poly400_HEX8'
  constant_properties = '-137.717553859283 109.81908636625 24.212101589114 400 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_401]
  type = 'AbaqusUMATStress'
  block = 'poly401_HEX8'
  constant_properties = '81.215712468957 49.35757172465 -29.606083845512 401 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_402]
  type = 'AbaqusUMATStress'
  block = 'poly402_HEX8'
  constant_properties = '78.961457839298 58.332943276682 -46.158592675284 402 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_403]
  type = 'AbaqusUMATStress'
  block = 'poly403_HEX8'
  constant_properties = '-104.875493534725 72.065997734632 43.353309073239 403 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_404]
  type = 'AbaqusUMATStress'
  block = 'poly404_HEX8'
  constant_properties = '-46.214290810865 55.351416185066 221.863184976035 404 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_405]
  type = 'AbaqusUMATStress'
  block = 'poly405_HEX8'
  constant_properties = '141.422448706242 151.889467376889 -177.707289088212 405 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_406]
  type = 'AbaqusUMATStress'
  block = 'poly406_HEX8'
  constant_properties = '-220.092098018401 60.831505980434 101.771362871538 406 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_407]
  type = 'AbaqusUMATStress'
  block = 'poly407_HEX8'
  constant_properties = '-24.77916392856 28.373761187773 -88.953566110847 407 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_408]
  type = 'AbaqusUMATStress'
  block = 'poly408_HEX8'
  constant_properties = '-77.11036441431 157.721420295325 194.759800709031 408 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_409]
  type = 'AbaqusUMATStress'
  block = 'poly409_HEX8'
  constant_properties = '47.657875987979 132.316741902698 -111.107086909844 409 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_410]
  type = 'AbaqusUMATStress'
  block = 'poly410_HEX8'
  constant_properties = '195.982463109626 103.064444952823 -124.730154940162 410 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_411]
  type = 'AbaqusUMATStress'
  block = 'poly411_HEX8'
  constant_properties = '-140.197483832843 128.442119283745 71.77478278479 411 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_412]
  type = 'AbaqusUMATStress'
  block = 'poly412_HEX8'
  constant_properties = '32.394700423165 132.03304650168 -86.767372236173 412 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_413]
  type = 'AbaqusUMATStress'
  block = 'poly413_HEX8'
  constant_properties = '31.294638292532 93.32482648217 -111.466398571689 413 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_414]
  type = 'AbaqusUMATStress'
  block = 'poly414_HEX8'
  constant_properties = '-27.70902787462 118.778707241095 31.501455291398 414 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_415]
  type = 'AbaqusUMATStress'
  block = 'poly415_HEX8'
  constant_properties = '-134.497705996821 122.206629484473 45.821669116096 415 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_416]
  type = 'AbaqusUMATStress'
  block = 'poly416_HEX8'
  constant_properties = '189.880483572064 85.261275887716 -63.378082103333 416 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_417]
  type = 'AbaqusUMATStress'
  block = 'poly417_HEX8'
  constant_properties = '-33.393364271225 37.950022393721 14.415800368087 417 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_418]
  type = 'AbaqusUMATStress'
  block = 'poly418_HEX8'
  constant_properties = '110.298197192232 129.174493868896 37.892693983014 418 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_419]
  type = 'AbaqusUMATStress'
  block = 'poly419_HEX8'
  constant_properties = '-127.272900437507 96.374833469577 163.685027867145 419 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_420]
  type = 'AbaqusUMATStress'
  block = 'poly420_HEX8'
  constant_properties = '-56.931870387629 139.768921130514 149.991371051194 420 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_421]
  type = 'AbaqusUMATStress'
  block = 'poly421_HEX8'
  constant_properties = '-90.218880937681 56.657520640593 -48.070855469394 421 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_422]
  type = 'AbaqusUMATStress'
  block = 'poly422_HEX8'
  constant_properties = '-6.850959527075 72.863331935356 139.623096534642 422 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_423]
  type = 'AbaqusUMATStress'
  block = 'poly423_HEX8'
  constant_properties = '21.381090183351 79.475424654024 -15.100756031074 423 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_424]
  type = 'AbaqusUMATStress'
  block = 'poly424_HEX8'
  constant_properties = '-76.691260216531 17.591258497754 -33.996519174039 424 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_425]
  type = 'AbaqusUMATStress'
  block = 'poly425_HEX8'
  constant_properties = '3.937193460764 81.116209748486 -150.361282937443 425 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_426]
  type = 'AbaqusUMATStress'
  block = 'poly426_HEX8'
  constant_properties = '206.816628506011 95.136078082757 -139.746698832469 426 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_427]
  type = 'AbaqusUMATStress'
  block = 'poly427_HEX8'
  constant_properties = '183.614715608104 12.768797251662 -71.437224925691 427 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_428]
  type = 'AbaqusUMATStress'
  block = 'poly428_HEX8'
  constant_properties = '158.654101371499 20.919485686174 -127.677579043598 428 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_429]
  type = 'AbaqusUMATStress'
  block = 'poly429_HEX8'
  constant_properties = '25.537808766485 113.453712620934 -176.339319214432 429 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_430]
  type = 'AbaqusUMATStress'
  block = 'poly430_HEX8'
  constant_properties = '114.618918428855 106.309834364328 -132.485255981156 430 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_431]
  type = 'AbaqusUMATStress'
  block = 'poly431_HEX8'
  constant_properties = '-74.875159421111 89.047327553177 205.735173156133 431 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_432]
  type = 'AbaqusUMATStress'
  block = 'poly432_HEX8'
  constant_properties = '-132.432652749737 109.162688574376 20.395344756051 432 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_433]
  type = 'AbaqusUMATStress'
  block = 'poly433_HEX8'
  constant_properties = '16.408113638745 124.413495739386 -48.452804655366 433 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_434]
  type = 'AbaqusUMATStress'
  block = 'poly434_HEX8'
  constant_properties = '-113.32875028822 44.383594502895 37.414702664345 434 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_435]
  type = 'AbaqusUMATStress'
  block = 'poly435_HEX8'
  constant_properties = '137.627649956632 145.726932711936 12.82652746686 435 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_436]
  type = 'AbaqusUMATStress'
  block = 'poly436_HEX8'
  constant_properties = '-190.206051063782 121.44083096683 61.082327823835 436 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_437]
  type = 'AbaqusUMATStress'
  block = 'poly437_HEX8'
  constant_properties = '-60.345916632726 123.469157922933 101.003480292756 437 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_438]
  type = 'AbaqusUMATStress'
  block = 'poly438_HEX8'
  constant_properties = '227.703360418989 36.370583224155 -98.706361774833 438 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_439]
  type = 'AbaqusUMATStress'
  block = 'poly439_HEX8'
  constant_properties = '-89.272726250268 54.925644709066 106.662851058489 439 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_440]
  type = 'AbaqusUMATStress'
  block = 'poly440_HEX8'
  constant_properties = '42.52358615396 107.819745868614 12.461746391909 440 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_441]
  type = 'AbaqusUMATStress'
  block = 'poly441_HEX8'
  constant_properties = '-126.608917541319 161.57023882248 92.209273973228 441 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_442]
  type = 'AbaqusUMATStress'
  block = 'poly442_HEX8'
  constant_properties = '14.838487939988 112.29586798813 -13.992393128172 442 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_443]
  type = 'AbaqusUMATStress'
  block = 'poly443_HEX8'
  constant_properties = '-34.816836212782 152.631066749849 -90.881355121356 443 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_444]
  type = 'AbaqusUMATStress'
  block = 'poly444_HEX8'
  constant_properties = '43.492625860696 108.761263391749 -12.634846672537 444 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_445]
  type = 'AbaqusUMATStress'
  block = 'poly445_HEX8'
  constant_properties = '3.638658638395 82.683402269174 112.454560727121 445 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_446]
  type = 'AbaqusUMATStress'
  block = 'poly446_HEX8'
  constant_properties = '147.725218519861 45.285484053249 -146.919060238739 446 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_447]
  type = 'AbaqusUMATStress'
  block = 'poly447_HEX8'
  constant_properties = '-141.749564703589 138.423173196675 162.26453109657 447 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_448]
  type = 'AbaqusUMATStress'
  block = 'poly448_HEX8'
  constant_properties = '-45.059816293424 61.647788797592 61.886437284948 448 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_449]
  type = 'AbaqusUMATStress'
  block = 'poly449_HEX8'
  constant_properties = '-7.527784739607 108.759387029232 -155.011183757079 449 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_450]
  type = 'AbaqusUMATStress'
  block = 'poly450_HEX8'
  constant_properties = '-107.961841826501 61.298649470717 174.880282987674 450 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_451]
  type = 'AbaqusUMATStress'
  block = 'poly451_HEX8'
  constant_properties = '-86.690158079129 71.377080048595 -60.625457047673 451 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_452]
  type = 'AbaqusUMATStress'
  block = 'poly452_HEX8'
  constant_properties = '40.553912741242 96.091648568408 -195.066416198565 452 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_453]
  type = 'AbaqusUMATStress'
  block = 'poly453_HEX8'
  constant_properties = '198.72011138182 147.373876548434 -28.04346604144 453 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_454]
  type = 'AbaqusUMATStress'
  block = 'poly454_HEX8'
  constant_properties = '-74.839691035839 58.908729280819 -53.593719561283 454 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_455]
  type = 'AbaqusUMATStress'
  block = 'poly455_HEX8'
  constant_properties = '-11.716963376598 163.623144156937 91.391167624255 455 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_456]
  type = 'AbaqusUMATStress'
  block = 'poly456_HEX8'
  constant_properties = '-184.405996691209 124.806765199914 90.746982521269 456 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_457]
  type = 'AbaqusUMATStress'
  block = 'poly457_HEX8'
  constant_properties = '-10.825312946111 56.226065829284 93.164562212217 457 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_458]
  type = 'AbaqusUMATStress'
  block = 'poly458_HEX8'
  constant_properties = '44.715431446363 86.513850046096 38.235402249778 458 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_459]
  type = 'AbaqusUMATStress'
  block = 'poly459_HEX8'
  constant_properties = '-81.178564198209 106.754574288681 66.089336918758 459 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_460]
  type = 'AbaqusUMATStress'
  block = 'poly460_HEX8'
  constant_properties = '-20.128677521094 83.53954874454 -122.686829600536 460 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_461]
  type = 'AbaqusUMATStress'
  block = 'poly461_HEX8'
  constant_properties = '38.189998298238 111.424329517148 -209.430627992096 461 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_462]
  type = 'AbaqusUMATStress'
  block = 'poly462_HEX8'
  constant_properties = '137.49142419138 59.809370693351 -13.088229242862 462 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_463]
  type = 'AbaqusUMATStress'
  block = 'poly463_HEX8'
  constant_properties = '16.202384577894 146.773209387326 -167.088639694879 463 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_464]
  type = 'AbaqusUMATStress'
  block = 'poly464_HEX8'
  constant_properties = '-108.588716152166 35.336431585442 90.33556368314 464 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_465]
  type = 'AbaqusUMATStress'
  block = 'poly465_HEX8'
  constant_properties = '-84.332994003343 83.412374733298 -41.074479836262 465 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_466]
  type = 'AbaqusUMATStress'
  block = 'poly466_HEX8'
  constant_properties = '216.628083807577 114.178160267492 -93.688737712482 466 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_467]
  type = 'AbaqusUMATStress'
  block = 'poly467_HEX8'
  constant_properties = '-205.836603873933 106.052246558789 109.178432275253 467 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_468]
  type = 'AbaqusUMATStress'
  block = 'poly468_HEX8'
  constant_properties = '82.649727766831 47.787599749529 88.676768792998 468 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_469]
  type = 'AbaqusUMATStress'
  block = 'poly469_HEX8'
  constant_properties = '-225.895620374452 62.201052476848 91.886121766698 469 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_470]
  type = 'AbaqusUMATStress'
  block = 'poly470_HEX8'
  constant_properties = '183.918294820063 120.26229061002 -107.183964443939 470 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_471]
  type = 'AbaqusUMATStress'
  block = 'poly471_HEX8'
  constant_properties = '-137.976794317515 108.457502560637 4.439544561276 471 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_472]
  type = 'AbaqusUMATStress'
  block = 'poly472_HEX8'
  constant_properties = '38.46370547214 14.008366568884 57.923146065728 472 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_473]
  type = 'AbaqusUMATStress'
  block = 'poly473_HEX8'
  constant_properties = '15.073349216003 20.365016121026 31.05390901022 473 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_474]
  type = 'AbaqusUMATStress'
  block = 'poly474_HEX8'
  constant_properties = '69.364032300429 95.964266878549 -24.332700533164 474 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_475]
  type = 'AbaqusUMATStress'
  block = 'poly475_HEX8'
  constant_properties = '-8.74056957245 93.123939484195 54.395764489288 475 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_476]
  type = 'AbaqusUMATStress'
  block = 'poly476_HEX8'
  constant_properties = '108.248436080886 105.32534901961 -169.388871722307 476 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_477]
  type = 'AbaqusUMATStress'
  block = 'poly477_HEX8'
  constant_properties = '-131.599012369857 115.828051269062 65.592697298862 477 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_478]
  type = 'AbaqusUMATStress'
  block = 'poly478_HEX8'
  constant_properties = '-121.496103791302 74.535765718165 59.978659500677 478 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_479]
  type = 'AbaqusUMATStress'
  block = 'poly479_HEX8'
  constant_properties = '-88.833884675091 56.668862176945 6.006362120229 479 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_480]
  type = 'AbaqusUMATStress'
  block = 'poly480_HEX8'
  constant_properties = '54.086017184041 134.097524381908 -138.462312404877 480 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_481]
  type = 'AbaqusUMATStress'
  block = 'poly481_HEX8'
  constant_properties = '-225.302525424267 68.431986515771 61.38063088552 481 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_482]
  type = 'AbaqusUMATStress'
  block = 'poly482_HEX8'
  constant_properties = '-70.20496561181 80.9943684597 33.458077680417 482 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_483]
  type = 'AbaqusUMATStress'
  block = 'poly483_HEX8'
  constant_properties = '183.480129759187 106.257046229064 -70.226381272848 483 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_484]
  type = 'AbaqusUMATStress'
  block = 'poly484_HEX8'
  constant_properties = '11.637746089308 118.053886422293 127.324742414597 484 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_485]
  type = 'AbaqusUMATStress'
  block = 'poly485_HEX8'
  constant_properties = '-28.566852875118 91.38944224852 205.279293622625 485 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_486]
  type = 'AbaqusUMATStress'
  block = 'poly486_HEX8'
  constant_properties = '156.333725492029 50.77379046345 -106.018705457367 486 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_487]
  type = 'AbaqusUMATStress'
  block = 'poly487_HEX8'
  constant_properties = '11.396040990074 53.656657441616 43.608062633541 487 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_488]
  type = 'AbaqusUMATStress'
  block = 'poly488_HEX8'
  constant_properties = '241.800781458517 94.643931771764 -78.107717447679 488 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_489]
  type = 'AbaqusUMATStress'
  block = 'poly489_HEX8'
  constant_properties = '173.278889339162 57.200529907333 -111.919238460046 489 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_490]
  type = 'AbaqusUMATStress'
  block = 'poly490_HEX8'
  constant_properties = '111.050451279964 42.248574646698 -222.389913331589 490 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_491]
  type = 'AbaqusUMATStress'
  block = 'poly491_HEX8'
  constant_properties = '105.814940722095 106.77940343851 -12.788966762889 491 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_492]
  type = 'AbaqusUMATStress'
  block = 'poly492_HEX8'
  constant_properties = '-32.593480288098 163.300444136487 0.83640277256 492 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_493]
  type = 'AbaqusUMATStress'
  block = 'poly493_HEX8'
  constant_properties = '-8.783447543922 30.399154004239 183.95706683555 493 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_494]
  type = 'AbaqusUMATStress'
  block = 'poly494_HEX8'
  constant_properties = '-149.493773703974 67.629365923188 -12.567222587345 494 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_495]
  type = 'AbaqusUMATStress'
  block = 'poly495_HEX8'
  constant_properties = '-108.730324437806 23.74537853848 73.269452917075 495 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_496]
  type = 'AbaqusUMATStress'
  block = 'poly496_HEX8'
  constant_properties = '246.380079849236 21.171015835 -73.293814880856 496 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_497]
  type = 'AbaqusUMATStress'
  block = 'poly497_HEX8'
  constant_properties = '-129.910668634966 57.575820661057 -19.689737297422 497 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_498]
  type = 'AbaqusUMATStress'
  block = 'poly498_HEX8'
  constant_properties = '-1.410958708445 92.871685896773 -56.537191543284 498 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_499]
  type = 'AbaqusUMATStress'
  block = 'poly499_HEX8'
  constant_properties = '-74.457460484093 94.633950222418 -77.41000265396 499 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_500]
  type = 'AbaqusUMATStress'
  block = 'poly500_HEX8'
  constant_properties = '-100.858158345195 140.097716411645 12.440648713783 500 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_501]
  type = 'AbaqusUMATStress'
  block = 'poly501_HEX8'
  constant_properties = '78.185967264109 123.758574216054 -140.130672303441 501 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_502]
  type = 'AbaqusUMATStress'
  block = 'poly502_HEX8'
  constant_properties = '51.330667897426 66.433053761337 -182.284925915214 502 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_503]
  type = 'AbaqusUMATStress'
  block = 'poly503_HEX8'
  constant_properties = '-92.887339580927 105.81301053973 -36.78269634582 503 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_504]
  type = 'AbaqusUMATStress'
  block = 'poly504_HEX8'
  constant_properties = '-132.927085029344 109.45082927591 203.162787619321 504 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_505]
  type = 'AbaqusUMATStress'
  block = 'poly505_HEX8'
  constant_properties = '-30.003014297518 5.165349061147 101.837566726733 505 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_506]
  type = 'AbaqusUMATStress'
  block = 'poly506_HEX8'
  constant_properties = '196.787420598143 25.074595046944 -110.486665991958 506 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_507]
  type = 'AbaqusUMATStress'
  block = 'poly507_HEX8'
  constant_properties = '-50.997476718285 158.248320748772 199.135924372366 507 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_508]
  type = 'AbaqusUMATStress'
  block = 'poly508_HEX8'
  constant_properties = '-105.140104553987 120.417617046784 -56.640728605351 508 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_509]
  type = 'AbaqusUMATStress'
  block = 'poly509_HEX8'
  constant_properties = '-129.17800232268 118.871172247895 51.008938829264 509 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_510]
  type = 'AbaqusUMATStress'
  block = 'poly510_HEX8'
  constant_properties = '-113.354596932625 88.848496271798 186.06207754101 510 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_511]
  type = 'AbaqusUMATStress'
  block = 'poly511_HEX8'
  constant_properties = '-0.093590011772 109.011873594626 109.906918636799 511 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_512]
  type = 'AbaqusUMATStress'
  block = 'poly512_HEX8'
  constant_properties = '-230.883660314174 96.812131465889 63.57086281729 512 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_513]
  type = 'AbaqusUMATStress'
  block = 'poly513_HEX8'
  constant_properties = '-86.866695423726 118.374941916662 -84.748628822264 513 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_514]
  type = 'AbaqusUMATStress'
  block = 'poly514_HEX8'
  constant_properties = '106.732126517234 94.386922837691 0.960918648642 514 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_515]
  type = 'AbaqusUMATStress'
  block = 'poly515_HEX8'
  constant_properties = '69.125815105957 41.163053790226 -109.091758565497 515 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_516]
  type = 'AbaqusUMATStress'
  block = 'poly516_HEX8'
  constant_properties = '121.735951451338 147.234841505409 36.666647929639 516 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_517]
  type = 'AbaqusUMATStress'
  block = 'poly517_HEX8'
  constant_properties = '-65.373163381959 12.179744269948 10.073063345535 517 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_518]
  type = 'AbaqusUMATStress'
  block = 'poly518_HEX8'
  constant_properties = '-192.630942399647 42.774968960093 19.569970338894 518 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_519]
  type = 'AbaqusUMATStress'
  block = 'poly519_HEX8'
  constant_properties = '-26.642053504558 123.026600901008 25.342911400837 519 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_520]
  type = 'AbaqusUMATStress'
  block = 'poly520_HEX8'
  constant_properties = '110.772942207397 173.693254914782 -38.467630587468 520 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_521]
  type = 'AbaqusUMATStress'
  block = 'poly521_HEX8'
  constant_properties = '-51.205353909936 108.272560737644 172.49980693071 521 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_522]
  type = 'AbaqusUMATStress'
  block = 'poly522_HEX8'
  constant_properties = '28.19145461982 25.317737028688 -69.761501931996 522 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_523]
  type = 'AbaqusUMATStress'
  block = 'poly523_HEX8'
  constant_properties = '-125.458821484728 115.506892905895 -2.410687105802 523 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_524]
  type = 'AbaqusUMATStress'
  block = 'poly524_HEX8'
  constant_properties = '-77.281188331255 96.433829576369 -6.50659895184 524 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_525]
  type = 'AbaqusUMATStress'
  block = 'poly525_HEX8'
  constant_properties = '27.994787552802 40.077297338333 84.316764191405 525 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_526]
  type = 'AbaqusUMATStress'
  block = 'poly526_HEX8'
  constant_properties = '64.423345068807 146.07129656239 -195.955182541774 526 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_527]
  type = 'AbaqusUMATStress'
  block = 'poly527_HEX8'
  constant_properties = '70.580288662736 68.506769603816 -106.805034919698 527 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_528]
  type = 'AbaqusUMATStress'
  block = 'poly528_HEX8'
  constant_properties = '101.448639851576 54.045428949089 -258.267956631189 528 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_529]
  type = 'AbaqusUMATStress'
  block = 'poly529_HEX8'
  constant_properties = '-90.559870375687 68.635948863952 18.786281151374 529 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_530]
  type = 'AbaqusUMATStress'
  block = 'poly530_HEX8'
  constant_properties = '116.04111374242 81.878743095418 -135.255833215229 530 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_531]
  type = 'AbaqusUMATStress'
  block = 'poly531_HEX8'
  constant_properties = '-137.147599346503 44.380482436198 185.050715118785 531 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_532]
  type = 'AbaqusUMATStress'
  block = 'poly532_HEX8'
  constant_properties = '93.187539284703 166.903818641128 3.016449986497 532 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_533]
  type = 'AbaqusUMATStress'
  block = 'poly533_HEX8'
  constant_properties = '-45.739736893766 81.552823862644 159.198705601126 533 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_534]
  type = 'AbaqusUMATStress'
  block = 'poly534_HEX8'
  constant_properties = '-156.427225495673 24.391736319356 10.843700846072 534 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_535]
  type = 'AbaqusUMATStress'
  block = 'poly535_HEX8'
  constant_properties = '110.480885118562 113.730005569411 -70.419564325004 535 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_536]
  type = 'AbaqusUMATStress'
  block = 'poly536_HEX8'
  constant_properties = '61.176865533657 8.202871244132 -91.216794434185 536 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_537]
  type = 'AbaqusUMATStress'
  block = 'poly537_HEX8'
  constant_properties = '-225.693088335029 96.647416357475 131.399605328131 537 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_538]
  type = 'AbaqusUMATStress'
  block = 'poly538_HEX8'
  constant_properties = '-211.087584229558 125.385174907188 115.08168323058 538 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_539]
  type = 'AbaqusUMATStress'
  block = 'poly539_HEX8'
  constant_properties = '41.395614757885 134.89067535459 -193.840934055342 539 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_540]
  type = 'AbaqusUMATStress'
  block = 'poly540_HEX8'
  constant_properties = '31.18228361515 67.783728288893 135.385921061344 540 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_541]
  type = 'AbaqusUMATStress'
  block = 'poly541_HEX8'
  constant_properties = '-188.356982152801 101.24302058533 168.718581408415 541 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_542]
  type = 'AbaqusUMATStress'
  block = 'poly542_HEX8'
  constant_properties = '-54.510344962666 105.331278884482 -22.796829556254 542 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_543]
  type = 'AbaqusUMATStress'
  block = 'poly543_HEX8'
  constant_properties = '154.891336546353 100.595718285859 -4.785615048708 543 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_544]
  type = 'AbaqusUMATStress'
  block = 'poly544_HEX8'
  constant_properties = '91.375094895091 154.032963963736 43.000973067083 544 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_545]
  type = 'AbaqusUMATStress'
  block = 'poly545_HEX8'
  constant_properties = '131.348471774407 51.317378461457 -171.505635402778 545 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_546]
  type = 'AbaqusUMATStress'
  block = 'poly546_HEX8'
  constant_properties = '-120.850164679658 46.087598402751 47.209826914698 546 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_547]
  type = 'AbaqusUMATStress'
  block = 'poly547_HEX8'
  constant_properties = '-38.551441608516 125.672577361393 131.76905949108 547 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_548]
  type = 'AbaqusUMATStress'
  block = 'poly548_HEX8'
  constant_properties = '119.862894720771 132.810243654948 -136.842548051518 548 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_549]
  type = 'AbaqusUMATStress'
  block = 'poly549_HEX8'
  constant_properties = '75.406782847856 58.588230625136 -242.841791258001 549 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_550]
  type = 'AbaqusUMATStress'
  block = 'poly550_HEX8'
  constant_properties = '-60.90546528597 102.380295670454 81.874459856403 550 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_551]
  type = 'AbaqusUMATStress'
  block = 'poly551_HEX8'
  constant_properties = '-71.647942483425 94.232224416577 -73.44695306854 551 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_552]
  type = 'AbaqusUMATStress'
  block = 'poly552_HEX8'
  constant_properties = '266.637566479988 124.646776193256 -88.134715519004 552 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_553]
  type = 'AbaqusUMATStress'
  block = 'poly553_HEX8'
  constant_properties = '-16.157778182818 67.722079495514 171.844071862006 553 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_554]
  type = 'AbaqusUMATStress'
  block = 'poly554_HEX8'
  constant_properties = '-121.332780314255 126.248082276969 37.681981921559 554 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_555]
  type = 'AbaqusUMATStress'
  block = 'poly555_HEX8'
  constant_properties = '-119.093203024685 57.022738114899 213.156921143519 555 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_556]
  type = 'AbaqusUMATStress'
  block = 'poly556_HEX8'
  constant_properties = '29.119178301192 79.748057420218 35.575777445077 556 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_557]
  type = 'AbaqusUMATStress'
  block = 'poly557_HEX8'
  constant_properties = '-28.298030229094 57.399841955616 47.662282736493 557 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_558]
  type = 'AbaqusUMATStress'
  block = 'poly558_HEX8'
  constant_properties = '161.996644678002 60.888444529309 -0.801667530433 558 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_559]
  type = 'AbaqusUMATStress'
  block = 'poly559_HEX8'
  constant_properties = '-169.29655453828 119.120999048747 66.673047912897 559 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_560]
  type = 'AbaqusUMATStress'
  block = 'poly560_HEX8'
  constant_properties = '27.235532247202 51.94929208831 -71.783716760407 560 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_561]
  type = 'AbaqusUMATStress'
  block = 'poly561_HEX8'
  constant_properties = '-6.082096534563 147.966873411499 140.049398937812 561 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_562]
  type = 'AbaqusUMATStress'
  block = 'poly562_HEX8'
  constant_properties = '-150.186927741337 32.359551406706 56.259476532098 562 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_563]
  type = 'AbaqusUMATStress'
  block = 'poly563_HEX8'
  constant_properties = '-76.002057502325 62.358381075693 170.445771091912 563 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_564]
  type = 'AbaqusUMATStress'
  block = 'poly564_HEX8'
  constant_properties = '185.134541058081 156.826847955084 -130.185549332985 564 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_565]
  type = 'AbaqusUMATStress'
  block = 'poly565_HEX8'
  constant_properties = '-131.324493160898 56.400796748861 208.626366765049 565 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_566]
  type = 'AbaqusUMATStress'
  block = 'poly566_HEX8'
  constant_properties = '-147.598022112929 75.633194679655 60.47830591425 566 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_567]
  type = 'AbaqusUMATStress'
  block = 'poly567_HEX8'
  constant_properties = '-63.753364306427 96.359996608705 38.350161410711 567 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_568]
  type = 'AbaqusUMATStress'
  block = 'poly568_HEX8'
  constant_properties = '-56.817475375887 94.27210563175 -21.733697111451 568 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_569]
  type = 'AbaqusUMATStress'
  block = 'poly569_HEX8'
  constant_properties = '49.639625806009 82.829653994956 -198.403799182328 569 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_570]
  type = 'AbaqusUMATStress'
  block = 'poly570_HEX8'
  constant_properties = '-42.640918425369 69.1833603065 137.037393541337 570 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_571]
  type = 'AbaqusUMATStress'
  block = 'poly571_HEX8'
  constant_properties = '-93.488403837347 84.368444693936 118.0049313446 571 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_572]
  type = 'AbaqusUMATStress'
  block = 'poly572_HEX8'
  constant_properties = '-87.243027372762 43.421514109301 -25.908204129317 572 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_573]
  type = 'AbaqusUMATStress'
  block = 'poly573_HEX8'
  constant_properties = '80.496486702675 59.621990913855 27.206114789439 573 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_574]
  type = 'AbaqusUMATStress'
  block = 'poly574_HEX8'
  constant_properties = '37.038157547233 68.336884250555 -190.199041470991 574 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_575]
  type = 'AbaqusUMATStress'
  block = 'poly575_HEX8'
  constant_properties = '-50.770329984943 91.151813169474 38.302047665911 575 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_576]
  type = 'AbaqusUMATStress'
  block = 'poly576_HEX8'
  constant_properties = '76.806236378534 107.699593081237 80.926750235827 576 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_577]
  type = 'AbaqusUMATStress'
  block = 'poly577_HEX8'
  constant_properties = '-61.995810650047 134.5952174225 117.839048718181 577 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_578]
  type = 'AbaqusUMATStress'
  block = 'poly578_HEX8'
  constant_properties = '-1.840062961116 70.083383205514 -56.776497696939 578 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_579]
  type = 'AbaqusUMATStress'
  block = 'poly579_HEX8'
  constant_properties = '-130.980268110062 139.520670899397 127.089890969386 579 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_580]
  type = 'AbaqusUMATStress'
  block = 'poly580_HEX8'
  constant_properties = '193.355447436039 44.743995221811 -38.206790699864 580 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_581]
  type = 'AbaqusUMATStress'
  block = 'poly581_HEX8'
  constant_properties = '176.258750669074 99.72053110562 -11.212585371743 581 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_582]
  type = 'AbaqusUMATStress'
  block = 'poly582_HEX8'
  constant_properties = '166.876107042162 136.717770197559 -56.729172074867 582 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_583]
  type = 'AbaqusUMATStress'
  block = 'poly583_HEX8'
  constant_properties = '-27.11660015665 83.049429359581 115.526756250434 583 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_584]
  type = 'AbaqusUMATStress'
  block = 'poly584_HEX8'
  constant_properties = '-60.749435085903 116.766271443609 238.944482073972 584 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_585]
  type = 'AbaqusUMATStress'
  block = 'poly585_HEX8'
  constant_properties = '98.520752652949 60.879132558211 65.481935618212 585 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_586]
  type = 'AbaqusUMATStress'
  block = 'poly586_HEX8'
  constant_properties = '130.870167378493 138.753750356485 43.717271575565 586 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_587]
  type = 'AbaqusUMATStress'
  block = 'poly587_HEX8'
  constant_properties = '14.891723086249 97.160078034056 -45.492776323099 587 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_588]
  type = 'AbaqusUMATStress'
  block = 'poly588_HEX8'
  constant_properties = '107.692230939412 59.640048874188 31.751310427992 588 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_589]
  type = 'AbaqusUMATStress'
  block = 'poly589_HEX8'
  constant_properties = '-196.249733309603 73.730549161005 58.931709086663 589 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_590]
  type = 'AbaqusUMATStress'
  block = 'poly590_HEX8'
  constant_properties = '-15.379644675319 148.141241208356 61.090009648411 590 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_591]
  type = 'AbaqusUMATStress'
  block = 'poly591_HEX8'
  constant_properties = '80.633025812144 42.951471623526 68.143014518864 591 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_592]
  type = 'AbaqusUMATStress'
  block = 'poly592_HEX8'
  constant_properties = '234.728072339664 77.209759235546 -116.209099776299 592 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_593]
  type = 'AbaqusUMATStress'
  block = 'poly593_HEX8'
  constant_properties = '73.331732864676 113.716336369054 33.159916833082 593 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_594]
  type = 'AbaqusUMATStress'
  block = 'poly594_HEX8'
  constant_properties = '-76.984241011851 28.091945615577 222.452131893083 594 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_595]
  type = 'AbaqusUMATStress'
  block = 'poly595_HEX8'
  constant_properties = '-48.063827398269 129.366949158552 196.363336077529 595 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_596]
  type = 'AbaqusUMATStress'
  block = 'poly596_HEX8'
  constant_properties = '-55.431890080947 35.209390556416 -98.828977530314 596 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_597]
  type = 'AbaqusUMATStress'
  block = 'poly597_HEX8'
  constant_properties = '-168.797490357141 53.305348267369 0.406428332331 597 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_598]
  type = 'AbaqusUMATStress'
  block = 'poly598_HEX8'
  constant_properties = '-121.478284200334 57.224025544451 133.831648320638 598 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_599]
  type = 'AbaqusUMATStress'
  block = 'poly599_HEX8'
  constant_properties = '-151.92408968159 72.803659322356 118.815271999571 599 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_600]
  type = 'AbaqusUMATStress'
  block = 'poly600_HEX8'
  constant_properties = '263.320958766336 16.888002795391 -86.268594404991 600 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_601]
  type = 'AbaqusUMATStress'
  block = 'poly601_HEX8'
  constant_properties = '208.809840965568 120.629250052057 -130.413781976555 601 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_602]
  type = 'AbaqusUMATStress'
  block = 'poly602_HEX8'
  constant_properties = '89.75503948247 132.61470410489 -242.4085920957 602 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_603]
  type = 'AbaqusUMATStress'
  block = 'poly603_HEX8'
  constant_properties = '89.816153711612 60.487128240248 -103.723320557732 603 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_604]
  type = 'AbaqusUMATStress'
  block = 'poly604_HEX8'
  constant_properties = '166.969125416889 35.187213318906 -189.075459933241 604 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_605]
  type = 'AbaqusUMATStress'
  block = 'poly605_HEX8'
  constant_properties = '73.146117624178 143.214414492901 -104.347811236238 605 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_606]
  type = 'AbaqusUMATStress'
  block = 'poly606_HEX8'
  constant_properties = '-191.738780300106 21.666992250393 125.693136555514 606 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_607]
  type = 'AbaqusUMATStress'
  block = 'poly607_HEX8'
  constant_properties = '-152.610325708454 99.119909206945 205.92267301763 607 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_608]
  type = 'AbaqusUMATStress'
  block = 'poly608_HEX8'
  constant_properties = '60.027198580701 108.350704943362 -195.321621516854 608 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_609]
  type = 'AbaqusUMATStress'
  block = 'poly609_HEX8'
  constant_properties = '80.974454161356 84.522716352126 -56.513407731395 609 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_610]
  type = 'AbaqusUMATStress'
  block = 'poly610_HEX8'
  constant_properties = '-70.360254601406 76.672473795572 -10.788314420403 610 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_611]
  type = 'AbaqusUMATStress'
  block = 'poly611_HEX8'
  constant_properties = '218.952190956629 92.121604557063 -122.927565556175 611 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_612]
  type = 'AbaqusUMATStress'
  block = 'poly612_HEX8'
  constant_properties = '-13.568513874166 74.027310452009 -21.71358025927 612 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_613]
  type = 'AbaqusUMATStress'
  block = 'poly613_HEX8'
  constant_properties = '-20.046184142319 101.839314381711 -86.32923759735 613 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_614]
  type = 'AbaqusUMATStress'
  block = 'poly614_HEX8'
  constant_properties = '-17.879426746431 151.054823306539 101.317618970271 614 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_615]
  type = 'AbaqusUMATStress'
  block = 'poly615_HEX8'
  constant_properties = '228.298428830255 138.063908271586 -85.936196865667 615 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_616]
  type = 'AbaqusUMATStress'
  block = 'poly616_HEX8'
  constant_properties = '97.659827906408 84.110289782946 -157.832035629796 616 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_617]
  type = 'AbaqusUMATStress'
  block = 'poly617_HEX8'
  constant_properties = '107.132323858348 126.192014030782 72.100654981215 617 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_618]
  type = 'AbaqusUMATStress'
  block = 'poly618_HEX8'
  constant_properties = '-0.782498042862 139.790945789331 -109.712943646033 618 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_619]
  type = 'AbaqusUMATStress'
  block = 'poly619_HEX8'
  constant_properties = '18.652648388633 76.370726699106 -28.444196394481 619 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_620]
  type = 'AbaqusUMATStress'
  block = 'poly620_HEX8'
  constant_properties = '142.111905975637 114.334452583293 9.928014695443 620 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_621]
  type = 'AbaqusUMATStress'
  block = 'poly621_HEX8'
  constant_properties = '-114.948175250932 14.416082412805 -4.140738410323 621 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_622]
  type = 'AbaqusUMATStress'
  block = 'poly622_HEX8'
  constant_properties = '63.568049993372 57.113111577425 -162.993232105846 622 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_623]
  type = 'AbaqusUMATStress'
  block = 'poly623_HEX8'
  constant_properties = '9.634482918967 83.191725712084 11.979327185728 623 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_624]
  type = 'AbaqusUMATStress'
  block = 'poly624_HEX8'
  constant_properties = '103.862801544243 174.451223732615 -22.972088791444 624 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_625]
  type = 'AbaqusUMATStress'
  block = 'poly625_HEX8'
  constant_properties = '-235.663914234676 91.884513345323 88.46778394039 625 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_626]
  type = 'AbaqusUMATStress'
  block = 'poly626_HEX8'
  constant_properties = '85.797275851085 106.622497961646 -216.818469632553 626 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_627]
  type = 'AbaqusUMATStress'
  block = 'poly627_HEX8'
  constant_properties = '68.600113901236 25.803178720197 -83.796802832257 627 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_628]
  type = 'AbaqusUMATStress'
  block = 'poly628_HEX8'
  constant_properties = '181.914528689072 134.149967796068 -109.959970170751 628 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_629]
  type = 'AbaqusUMATStress'
  block = 'poly629_HEX8'
  constant_properties = '62.042642268267 88.72581414919 104.672877238063 629 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_630]
  type = 'AbaqusUMATStress'
  block = 'poly630_HEX8'
  constant_properties = '-32.450076290686 95.900785893262 -60.86190428949 630 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_631]
  type = 'AbaqusUMATStress'
  block = 'poly631_HEX8'
  constant_properties = '-56.981721235815 31.546324189849 210.45410126838 631 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_632]
  type = 'AbaqusUMATStress'
  block = 'poly632_HEX8'
  constant_properties = '206.194125035314 39.657816682523 -29.350101092371 632 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_633]
  type = 'AbaqusUMATStress'
  block = 'poly633_HEX8'
  constant_properties = '-197.089302872606 100.467910868656 58.65692243597 633 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_634]
  type = 'AbaqusUMATStress'
  block = 'poly634_HEX8'
  constant_properties = '-156.264255270572 73.664582158046 10.590676698002 634 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_635]
  type = 'AbaqusUMATStress'
  block = 'poly635_HEX8'
  constant_properties = '-157.136157848132 33.105297514961 185.017369814891 635 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_636]
  type = 'AbaqusUMATStress'
  block = 'poly636_HEX8'
  constant_properties = '140.732741942282 98.37264757138 -66.616566592255 636 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_637]
  type = 'AbaqusUMATStress'
  block = 'poly637_HEX8'
  constant_properties = '-38.343020069819 88.499818822166 37.728209290652 637 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_638]
  type = 'AbaqusUMATStress'
  block = 'poly638_HEX8'
  constant_properties = '-237.636837994474 60.403809941655 94.591933890224 638 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_639]
  type = 'AbaqusUMATStress'
  block = 'poly639_HEX8'
  constant_properties = '-187.545315071587 40.088459951739 62.310991776838 639 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_640]
  type = 'AbaqusUMATStress'
  block = 'poly640_HEX8'
  constant_properties = '181.440489051045 106.281078286972 -71.354628509014 640 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_641]
  type = 'AbaqusUMATStress'
  block = 'poly641_HEX8'
  constant_properties = '91.193849168298 45.250481825909 -233.402237902592 641 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_642]
  type = 'AbaqusUMATStress'
  block = 'poly642_HEX8'
  constant_properties = '110.269815652587 37.083956590955 -109.979059765469 642 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_643]
  type = 'AbaqusUMATStress'
  block = 'poly643_HEX8'
  constant_properties = '167.82465350641 51.719365042778 -124.255978851684 643 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_644]
  type = 'AbaqusUMATStress'
  block = 'poly644_HEX8'
  constant_properties = '-141.298172443477 101.283788982562 111.937650741547 644 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_645]
  type = 'AbaqusUMATStress'
  block = 'poly645_HEX8'
  constant_properties = '42.763881649977 19.442295087084 -67.522585028758 645 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_646]
  type = 'AbaqusUMATStress'
  block = 'poly646_HEX8'
  constant_properties = '-113.159420386211 118.872007553199 120.072100963965 646 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_647]
  type = 'AbaqusUMATStress'
  block = 'poly647_HEX8'
  constant_properties = '-3.034260953262 69.123355877862 -90.973479024124 647 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_648]
  type = 'AbaqusUMATStress'
  block = 'poly648_HEX8'
  constant_properties = '-13.430104281375 107.919380043052 -114.010130541171 648 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_649]
  type = 'AbaqusUMATStress'
  block = 'poly649_HEX8'
  constant_properties = '-0.162010132638 106.54584520005 -159.727407120676 649 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_650]
  type = 'AbaqusUMATStress'
  block = 'poly650_HEX8'
  constant_properties = '177.814134144841 129.946424985427 -130.531689948498 650 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_651]
  type = 'AbaqusUMATStress'
  block = 'poly651_HEX8'
  constant_properties = '48.912295785454 76.619559887285 70.56986475666 651 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_652]
  type = 'AbaqusUMATStress'
  block = 'poly652_HEX8'
  constant_properties = '89.178705934367 68.461991627352 -254.836125207684 652 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_653]
  type = 'AbaqusUMATStress'
  block = 'poly653_HEX8'
  constant_properties = '134.16718583774 100.15896266431 -79.206547025135 653 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_654]
  type = 'AbaqusUMATStress'
  block = 'poly654_HEX8'
  constant_properties = '-116.923711223421 110.104925334765 -60.201646410956 654 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_655]
  type = 'AbaqusUMATStress'
  block = 'poly655_HEX8'
  constant_properties = '34.34358884275 83.111288928612 25.843205063362 655 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_656]
  type = 'AbaqusUMATStress'
  block = 'poly656_HEX8'
  constant_properties = '-65.278698911873 93.737431963579 242.596444073429 656 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_657]
  type = 'AbaqusUMATStress'
  block = 'poly657_HEX8'
  constant_properties = '-154.24845168069 108.189033617921 133.285327091511 657 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_658]
  type = 'AbaqusUMATStress'
  block = 'poly658_HEX8'
  constant_properties = '-81.05046372291 36.055140392693 254.470645810392 658 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_659]
  type = 'AbaqusUMATStress'
  block = 'poly659_HEX8'
  constant_properties = '64.687531215718 109.073811132393 -226.105399758794 659 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_660]
  type = 'AbaqusUMATStress'
  block = 'poly660_HEX8'
  constant_properties = '14.106775377329 110.992675417081 76.222485514466 660 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_661]
  type = 'AbaqusUMATStress'
  block = 'poly661_HEX8'
  constant_properties = '-237.357064488945 134.038042364262 57.958546660907 661 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_662]
  type = 'AbaqusUMATStress'
  block = 'poly662_HEX8'
  constant_properties = '-204.9906947199 76.822391223718 97.687045188065 662 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_663]
  type = 'AbaqusUMATStress'
  block = 'poly663_HEX8'
  constant_properties = '111.240535534302 56.71742907155 -180.024350957931 663 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_664]
  type = 'AbaqusUMATStress'
  block = 'poly664_HEX8'
  constant_properties = '30.508208049329 20.978787449239 20.779848302581 664 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_665]
  type = 'AbaqusUMATStress'
  block = 'poly665_HEX8'
  constant_properties = '-214.030459668073 122.909010850388 112.384475947568 665 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_666]
  type = 'AbaqusUMATStress'
  block = 'poly666_HEX8'
  constant_properties = '-71.888762633427 118.376038988764 -106.889241349134 666 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_667]
  type = 'AbaqusUMATStress'
  block = 'poly667_HEX8'
  constant_properties = '97.463773718828 121.142074892857 -135.085627448628 667 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_668]
  type = 'AbaqusUMATStress'
  block = 'poly668_HEX8'
  constant_properties = '59.620448878878 158.906002687306 -40.434418838556 668 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_669]
  type = 'AbaqusUMATStress'
  block = 'poly669_HEX8'
  constant_properties = '96.675484359851 57.046264537148 -26.085773739342 669 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_670]
  type = 'AbaqusUMATStress'
  block = 'poly670_HEX8'
  constant_properties = '-157.302432134904 97.12955176903 46.645010186538 670 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_671]
  type = 'AbaqusUMATStress'
  block = 'poly671_HEX8'
  constant_properties = '-148.848174307301 107.596458818174 179.287517005973 671 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_672]
  type = 'AbaqusUMATStress'
  block = 'poly672_HEX8'
  constant_properties = '-198.356570245212 126.764821971553 25.376738993763 672 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_673]
  type = 'AbaqusUMATStress'
  block = 'poly673_HEX8'
  constant_properties = '78.560171004419 114.017507073723 -20.280459439381 673 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_674]
  type = 'AbaqusUMATStress'
  block = 'poly674_HEX8'
  constant_properties = '3.937230430441 89.253784266361 -60.962521135421 674 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_675]
  type = 'AbaqusUMATStress'
  block = 'poly675_HEX8'
  constant_properties = '-113.51450163298 87.300513007169 178.036876377713 675 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_676]
  type = 'AbaqusUMATStress'
  block = 'poly676_HEX8'
  constant_properties = '138.132897025718 12.856762813253 -55.298569619108 676 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_677]
  type = 'AbaqusUMATStress'
  block = 'poly677_HEX8'
  constant_properties = '-35.02443972949 124.72588268768 -45.704163545967 677 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_678]
  type = 'AbaqusUMATStress'
  block = 'poly678_HEX8'
  constant_properties = '-52.978729259165 143.10688506191 132.794735531715 678 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_679]
  type = 'AbaqusUMATStress'
  block = 'poly679_HEX8'
  constant_properties = '-95.583260967538 112.790699600601 37.188355010394 679 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_680]
  type = 'AbaqusUMATStress'
  block = 'poly680_HEX8'
  constant_properties = '115.129420952061 80.561673280593 -238.791845058324 680 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_681]
  type = 'AbaqusUMATStress'
  block = 'poly681_HEX8'
  constant_properties = '-86.634837366411 16.64269622202 249.353573063735 681 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_682]
  type = 'AbaqusUMATStress'
  block = 'poly682_HEX8'
  constant_properties = '72.442372558386 96.564310254831 -81.89625968541 682 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_683]
  type = 'AbaqusUMATStress'
  block = 'poly683_HEX8'
  constant_properties = '-109.66086454168 42.752454361323 110.980384054669 683 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_684]
  type = 'AbaqusUMATStress'
  block = 'poly684_HEX8'
  constant_properties = '51.233524284202 81.726446323572 26.013117172073 684 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_685]
  type = 'AbaqusUMATStress'
  block = 'poly685_HEX8'
  constant_properties = '120.07596011539 35.739787822322 47.559853828118 685 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_686]
  type = 'AbaqusUMATStress'
  block = 'poly686_HEX8'
  constant_properties = '15.152466372511 143.799780129056 -189.689190659711 686 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_687]
  type = 'AbaqusUMATStress'
  block = 'poly687_HEX8'
  constant_properties = '48.95513695779 101.554999393229 -27.407449176994 687 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_688]
  type = 'AbaqusUMATStress'
  block = 'poly688_HEX8'
  constant_properties = '48.168897824781 27.826802542131 -106.352222191356 688 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_689]
  type = 'AbaqusUMATStress'
  block = 'poly689_HEX8'
  constant_properties = '162.876222533996 117.929587667419 16.408878829154 689 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_690]
  type = 'AbaqusUMATStress'
  block = 'poly690_HEX8'
  constant_properties = '60.546327326373 75.522388130321 -5.036651940409 690 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_691]
  type = 'AbaqusUMATStress'
  block = 'poly691_HEX8'
  constant_properties = '-153.590924407765 31.532417530873 29.110818733938 691 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_692]
  type = 'AbaqusUMATStress'
  block = 'poly692_HEX8'
  constant_properties = '176.344063167872 50.455462487458 -15.792800998768 692 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_693]
  type = 'AbaqusUMATStress'
  block = 'poly693_HEX8'
  constant_properties = '141.702407383558 143.95396773635 -72.053449118919 693 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_694]
  type = 'AbaqusUMATStress'
  block = 'poly694_HEX8'
  constant_properties = '80.92570466388 171.761686977733 -42.657587050655 694 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_695]
  type = 'AbaqusUMATStress'
  block = 'poly695_HEX8'
  constant_properties = '-124.245434846784 135.90191685253 45.5687287411 695 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_696]
  type = 'AbaqusUMATStress'
  block = 'poly696_HEX8'
  constant_properties = '-7.77239605149 38.407087753314 -4.499433233386 696 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_697]
  type = 'AbaqusUMATStress'
  block = 'poly697_HEX8'
  constant_properties = '1.651779308944 130.040071694476 2.988225304125 697 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_698]
  type = 'AbaqusUMATStress'
  block = 'poly698_HEX8'
  constant_properties = '21.683216900162 142.165214883202 -103.699982816549 698 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_699]
  type = 'AbaqusUMATStress'
  block = 'poly699_HEX8'
  constant_properties = '-51.569453788258 134.697054361623 -89.437064984457 699 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_700]
  type = 'AbaqusUMATStress'
  block = 'poly700_HEX8'
  constant_properties = '173.312104122903 169.565488374106 -111.820626355559 700 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_701]
  type = 'AbaqusUMATStress'
  block = 'poly701_HEX8'
  constant_properties = '-12.167049306115 73.541963677818 95.58090083305 701 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_702]
  type = 'AbaqusUMATStress'
  block = 'poly702_HEX8'
  constant_properties = '140.84696845358 42.771868742727 -209.612068862525 702 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_703]
  type = 'AbaqusUMATStress'
  block = 'poly703_HEX8'
  constant_properties = '-42.887965313398 46.449518899144 39.294276954096 703 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_704]
  type = 'AbaqusUMATStress'
  block = 'poly704_HEX8'
  constant_properties = '-130.378295754025 86.196675344446 227.38488605248 704 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_705]
  type = 'AbaqusUMATStress'
  block = 'poly705_HEX8'
  constant_properties = '113.716679320218 58.109286319464 -50.266366848302 705 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_706]
  type = 'AbaqusUMATStress'
  block = 'poly706_HEX8'
  constant_properties = '170.888154075276 109.011557451643 -186.281406787471 706 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_707]
  type = 'AbaqusUMATStress'
  block = 'poly707_HEX8'
  constant_properties = '133.789972855422 14.050722548005 4.022172229433 707 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_708]
  type = 'AbaqusUMATStress'
  block = 'poly708_HEX8'
  constant_properties = '-136.499726272253 65.173137669584 122.358944762883 708 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_709]
  type = 'AbaqusUMATStress'
  block = 'poly709_HEX8'
  constant_properties = '19.529736424824 120.306579890014 -2.041323838745 709 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_710]
  type = 'AbaqusUMATStress'
  block = 'poly710_HEX8'
  constant_properties = '-28.933682706236 112.13511876713 196.630432334732 710 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_711]
  type = 'AbaqusUMATStress'
  block = 'poly711_HEX8'
  constant_properties = '-59.264973144376 74.399848691304 -111.592242872032 711 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_712]
  type = 'AbaqusUMATStress'
  block = 'poly712_HEX8'
  constant_properties = '44.539550677159 73.720833877711 64.215801871263 712 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_713]
  type = 'AbaqusUMATStress'
  block = 'poly713_HEX8'
  constant_properties = '53.658552280122 127.044026836444 -63.792652047521 713 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_714]
  type = 'AbaqusUMATStress'
  block = 'poly714_HEX8'
  constant_properties = '-29.775120578535 40.696791294176 80.972336962619 714 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_715]
  type = 'AbaqusUMATStress'
  block = 'poly715_HEX8'
  constant_properties = '165.688778167467 58.33606079802 -10.508253494432 715 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_716]
  type = 'AbaqusUMATStress'
  block = 'poly716_HEX8'
  constant_properties = '124.6020532705 88.29010102962 -113.294901624797 716 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_717]
  type = 'AbaqusUMATStress'
  block = 'poly717_HEX8'
  constant_properties = '-71.634559635589 138.777341875091 151.980371198884 717 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_718]
  type = 'AbaqusUMATStress'
  block = 'poly718_HEX8'
  constant_properties = '-60.091142299512 79.838226495701 1.720197045301 718 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_719]
  type = 'AbaqusUMATStress'
  block = 'poly719_HEX8'
  constant_properties = '-223.390649638949 61.169881853037 73.979265379557 719 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_720]
  type = 'AbaqusUMATStress'
  block = 'poly720_HEX8'
  constant_properties = '-25.429965775738 51.583363799878 143.909651977755 720 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_721]
  type = 'AbaqusUMATStress'
  block = 'poly721_HEX8'
  constant_properties = '-193.263675743245 68.357063999385 123.595841495887 721 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_722]
  type = 'AbaqusUMATStress'
  block = 'poly722_HEX8'
  constant_properties = '-73.457640820413 24.905907673182 -70.815841570741 722 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_723]
  type = 'AbaqusUMATStress'
  block = 'poly723_HEX8'
  constant_properties = '-70.776895906369 135.262250634319 10.797015143995 723 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_724]
  type = 'AbaqusUMATStress'
  block = 'poly724_HEX8'
  constant_properties = '-28.693161865102 120.115579056087 18.727354231575 724 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_725]
  type = 'AbaqusUMATStress'
  block = 'poly725_HEX8'
  constant_properties = '-90.666984541573 91.323641877104 -88.493089339207 725 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_726]
  type = 'AbaqusUMATStress'
  block = 'poly726_HEX8'
  constant_properties = '203.058887430586 54.557062092676 -49.856517614359 726 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_727]
  type = 'AbaqusUMATStress'
  block = 'poly727_HEX8'
  constant_properties = '-151.757498816819 55.260511051056 48.371716910868 727 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_728]
  type = 'AbaqusUMATStress'
  block = 'poly728_HEX8'
  constant_properties = '51.636917926133 70.206062998819 123.626506680538 728 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_729]
  type = 'AbaqusUMATStress'
  block = 'poly729_HEX8'
  constant_properties = '-65.363906730556 132.098852440727 -78.32799094113 729 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_730]
  type = 'AbaqusUMATStress'
  block = 'poly730_HEX8'
  constant_properties = '-234.562368794744 144.589433947587 112.490538146348 730 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_731]
  type = 'AbaqusUMATStress'
  block = 'poly731_HEX8'
  constant_properties = '206.40725868389 60.557009809091 -135.503306445775 731 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_732]
  type = 'AbaqusUMATStress'
  block = 'poly732_HEX8'
  constant_properties = '-78.628186751764 102.589658580279 157.517544906948 732 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_733]
  type = 'AbaqusUMATStress'
  block = 'poly733_HEX8'
  constant_properties = '-58.613801288402 74.516289343581 -104.514201464695 733 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_734]
  type = 'AbaqusUMATStress'
  block = 'poly734_HEX8'
  constant_properties = '-106.540843497041 45.241355086072 226.575712073782 734 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_735]
  type = 'AbaqusUMATStress'
  block = 'poly735_HEX8'
  constant_properties = '153.696237518953 89.225469816281 -196.23627192798 735 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_736]
  type = 'AbaqusUMATStress'
  block = 'poly736_HEX8'
  constant_properties = '187.014285553932 119.245134151762 -153.753166257317 736 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_737]
  type = 'AbaqusUMATStress'
  block = 'poly737_HEX8'
  constant_properties = '104.033748632179 84.890426505327 -31.15474542276 737 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_738]
  type = 'AbaqusUMATStress'
  block = 'poly738_HEX8'
  constant_properties = '-237.798515974429 67.291731560153 115.527088432812 738 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_739]
  type = 'AbaqusUMATStress'
  block = 'poly739_HEX8'
  constant_properties = '168.348219669747 73.046984455136 -182.522770661233 739 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_740]
  type = 'AbaqusUMATStress'
  block = 'poly740_HEX8'
  constant_properties = '2.972876597824 162.857745054784 146.736083284298 740 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_741]
  type = 'AbaqusUMATStress'
  block = 'poly741_HEX8'
  constant_properties = '65.579487728872 62.434527773574 78.234499781398 741 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_742]
  type = 'AbaqusUMATStress'
  block = 'poly742_HEX8'
  constant_properties = '-171.861045717538 65.382507104713 110.219341659716 742 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_743]
  type = 'AbaqusUMATStress'
  block = 'poly743_HEX8'
  constant_properties = '-70.116626552013 91.86611733515 229.523921786996 743 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_744]
  type = 'AbaqusUMATStress'
  block = 'poly744_HEX8'
  constant_properties = '-108.534863904459 80.489292762539 202.801684218457 744 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_745]
  type = 'AbaqusUMATStress'
  block = 'poly745_HEX8'
  constant_properties = '105.307350081958 88.699989514857 32.607921531695 745 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_746]
  type = 'AbaqusUMATStress'
  block = 'poly746_HEX8'
  constant_properties = '42.587462752849 73.320555866845 -191.529627989242 746 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_747]
  type = 'AbaqusUMATStress'
  block = 'poly747_HEX8'
  constant_properties = '-3.228483038492 29.363842174166 -53.44428266937 747 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_748]
  type = 'AbaqusUMATStress'
  block = 'poly748_HEX8'
  constant_properties = '-24.230656663091 61.196564517268 107.158257415769 748 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_749]
  type = 'AbaqusUMATStress'
  block = 'poly749_HEX8'
  constant_properties = '93.581274139511 119.0365097917 -51.975050674947 749 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_750]
  type = 'AbaqusUMATStress'
  block = 'poly750_HEX8'
  constant_properties = '-88.141298856611 75.602535497439 167.01199636256 750 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_751]
  type = 'AbaqusUMATStress'
  block = 'poly751_HEX8'
  constant_properties = '144.16088499894 125.345617632578 13.756701364804 751 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_752]
  type = 'AbaqusUMATStress'
  block = 'poly752_HEX8'
  constant_properties = '38.283938031142 91.568918475176 -101.312158486654 752 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_753]
  type = 'AbaqusUMATStress'
  block = 'poly753_HEX8'
  constant_properties = '-73.076406904024 102.543500387675 -41.821242324641 753 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_754]
  type = 'AbaqusUMATStress'
  block = 'poly754_HEX8'
  constant_properties = '106.156055198188 114.619980129501 -18.66773227281 754 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_755]
  type = 'AbaqusUMATStress'
  block = 'poly755_HEX8'
  constant_properties = '-123.39238148274 91.486123864265 44.882633244812 755 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_756]
  type = 'AbaqusUMATStress'
  block = 'poly756_HEX8'
  constant_properties = '61.12023681765 71.832868403371 -184.497855631762 756 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_757]
  type = 'AbaqusUMATStress'
  block = 'poly757_HEX8'
  constant_properties = '-64.868769601547 68.30962018937 125.525369828492 757 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_758]
  type = 'AbaqusUMATStress'
  block = 'poly758_HEX8'
  constant_properties = '-95.270424174766 66.648514411743 117.058678338924 758 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_759]
  type = 'AbaqusUMATStress'
  block = 'poly759_HEX8'
  constant_properties = '-111.071990426712 157.882726637018 145.596027562226 759 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_760]
  type = 'AbaqusUMATStress'
  block = 'poly760_HEX8'
  constant_properties = '-122.755251585079 24.398889928317 161.701767093779 760 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_761]
  type = 'AbaqusUMATStress'
  block = 'poly761_HEX8'
  constant_properties = '136.444767026175 67.615086918853 19.216344162392 761 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_762]
  type = 'AbaqusUMATStress'
  block = 'poly762_HEX8'
  constant_properties = '159.46447438403 132.496977237045 -189.286044920997 762 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_763]
  type = 'AbaqusUMATStress'
  block = 'poly763_HEX8'
  constant_properties = '-97.795973735905 111.5422361511 -55.195933198714 763 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_764]
  type = 'AbaqusUMATStress'
  block = 'poly764_HEX8'
  constant_properties = '-239.398710886339 77.020845865227 94.966773762758 764 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_765]
  type = 'AbaqusUMATStress'
  block = 'poly765_HEX8'
  constant_properties = '108.558953485241 25.22891891725 -233.67479903202 765 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_766]
  type = 'AbaqusUMATStress'
  block = 'poly766_HEX8'
  constant_properties = '-32.625411500942 50.094464107777 20.070574338529 766 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_767]
  type = 'AbaqusUMATStress'
  block = 'poly767_HEX8'
  constant_properties = '58.899448445918 17.396016838899 -94.764670583383 767 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_768]
  type = 'AbaqusUMATStress'
  block = 'poly768_HEX8'
  constant_properties = '-43.582037377105 70.060343177506 45.508121278176 768 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_769]
  type = 'AbaqusUMATStress'
  block = 'poly769_HEX8'
  constant_properties = '203.5445176419 43.449099731918 -94.368722241494 769 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_770]
  type = 'AbaqusUMATStress'
  block = 'poly770_HEX8'
  constant_properties = '124.262209322871 152.420016928065 0.742836325604 770 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_771]
  type = 'AbaqusUMATStress'
  block = 'poly771_HEX8'
  constant_properties = '255.024492719479 72.768770390466 -89.838388177406 771 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_772]
  type = 'AbaqusUMATStress'
  block = 'poly772_HEX8'
  constant_properties = '-131.906957842512 166.895261131839 100.460415639328 772 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_773]
  type = 'AbaqusUMATStress'
  block = 'poly773_HEX8'
  constant_properties = '-71.642958051128 52.518370922232 230.301946046577 773 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_774]
  type = 'AbaqusUMATStress'
  block = 'poly774_HEX8'
  constant_properties = '-119.124002362776 78.615710155824 2.695834413254 774 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_775]
  type = 'AbaqusUMATStress'
  block = 'poly775_HEX8'
  constant_properties = '155.255221653892 109.098579023686 -79.9996211439 775 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_776]
  type = 'AbaqusUMATStress'
  block = 'poly776_HEX8'
  constant_properties = '-65.284878427429 88.92763470913 95.215309284066 776 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_777]
  type = 'AbaqusUMATStress'
  block = 'poly777_HEX8'
  constant_properties = '-181.294908506455 98.293596343642 62.125557383168 777 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_778]
  type = 'AbaqusUMATStress'
  block = 'poly778_HEX8'
  constant_properties = '23.596147829041 43.497303686399 -89.946875619749 778 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_779]
  type = 'AbaqusUMATStress'
  block = 'poly779_HEX8'
  constant_properties = '20.668993861995 127.045832008341 -188.124057924177 779 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_780]
  type = 'AbaqusUMATStress'
  block = 'poly780_HEX8'
  constant_properties = '79.850377183894 130.653077653323 -52.313414563701 780 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_781]
  type = 'AbaqusUMATStress'
  block = 'poly781_HEX8'
  constant_properties = '185.815660029187 58.825117792473 -53.961231140306 781 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_782]
  type = 'AbaqusUMATStress'
  block = 'poly782_HEX8'
  constant_properties = '-176.192183160244 106.422829506564 50.97637825792 782 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_783]
  type = 'AbaqusUMATStress'
  block = 'poly783_HEX8'
  constant_properties = '29.75380442896 96.920650735732 23.043041871725 783 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_784]
  type = 'AbaqusUMATStress'
  block = 'poly784_HEX8'
  constant_properties = '2.770557450602 103.362498543325 41.066651116492 784 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_785]
  type = 'AbaqusUMATStress'
  block = 'poly785_HEX8'
  constant_properties = '-143.004066596057 140.48958803577 175.159617769614 785 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_786]
  type = 'AbaqusUMATStress'
  block = 'poly786_HEX8'
  constant_properties = '112.751477758251 25.978086809661 -135.564298177546 786 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_787]
  type = 'AbaqusUMATStress'
  block = 'poly787_HEX8'
  constant_properties = '16.425370075705 93.667995149887 -89.758156886898 787 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_788]
  type = 'AbaqusUMATStress'
  block = 'poly788_HEX8'
  constant_properties = '-11.052314977565 155.700303448134 -132.176978795759 788 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_789]
  type = 'AbaqusUMATStress'
  block = 'poly789_HEX8'
  constant_properties = '11.620985392723 74.596685915102 -86.076566265275 789 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_790]
  type = 'AbaqusUMATStress'
  block = 'poly790_HEX8'
  constant_properties = '11.329987094374 71.54174038689 -33.063018479083 790 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_791]
  type = 'AbaqusUMATStress'
  block = 'poly791_HEX8'
  constant_properties = '108.122387316221 76.901841544449 -173.793118413289 791 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_792]
  type = 'AbaqusUMATStress'
  block = 'poly792_HEX8'
  constant_properties = '-28.760213418 130.06523898043 -81.117248010224 792 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_793]
  type = 'AbaqusUMATStress'
  block = 'poly793_HEX8'
  constant_properties = '194.693674023123 88.561973337431 -150.887830121123 793 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_794]
  type = 'AbaqusUMATStress'
  block = 'poly794_HEX8'
  constant_properties = '-216.045654489278 116.408672051975 96.302630432056 794 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_795]
  type = 'AbaqusUMATStress'
  block = 'poly795_HEX8'
  constant_properties = '129.942113190674 43.263348128828 19.238919775735 795 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_796]
  type = 'AbaqusUMATStress'
  block = 'poly796_HEX8'
  constant_properties = '28.168705502712 67.481419946427 15.692940658474 796 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_797]
  type = 'AbaqusUMATStress'
  block = 'poly797_HEX8'
  constant_properties = '143.938081591134 57.142928745449 -37.944598750198 797 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_798]
  type = 'AbaqusUMATStress'
  block = 'poly798_HEX8'
  constant_properties = '-4.114582097468 102.935223994981 -107.655537130967 798 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_799]
  type = 'AbaqusUMATStress'
  block = 'poly799_HEX8'
  constant_properties = '155.419250989995 163.620209940247 -81.217919023314 799 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_800]
  type = 'AbaqusUMATStress'
  block = 'poly800_HEX8'
  constant_properties = '-183.480729309565 157.205076118586 123.212375994363 800 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_801]
  type = 'AbaqusUMATStress'
  block = 'poly801_HEX8'
  constant_properties = '23.075487659526 59.253904114993 99.43868794553 801 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_802]
  type = 'AbaqusUMATStress'
  block = 'poly802_HEX8'
  constant_properties = '171.944486706594 46.196153186525 -28.588973929972 802 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_803]
  type = 'AbaqusUMATStress'
  block = 'poly803_HEX8'
  constant_properties = '-31.435677453253 96.857891973381 -31.74221579111 803 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_804]
  type = 'AbaqusUMATStress'
  block = 'poly804_HEX8'
  constant_properties = '14.054895877448 69.971770788248 73.831797808105 804 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_805]
  type = 'AbaqusUMATStress'
  block = 'poly805_HEX8'
  constant_properties = '95.838763175501 94.099402851847 -235.303276740842 805 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_806]
  type = 'AbaqusUMATStress'
  block = 'poly806_HEX8'
  constant_properties = '210.474429365547 67.375909171275 -130.927652320498 806 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_807]
  type = 'AbaqusUMATStress'
  block = 'poly807_HEX8'
  constant_properties = '126.37575382272 78.193537226915 -122.13887733803 807 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_808]
  type = 'AbaqusUMATStress'
  block = 'poly808_HEX8'
  constant_properties = '149.547385510192 62.098145698413 -76.147202863916 808 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_809]
  type = 'AbaqusUMATStress'
  block = 'poly809_HEX8'
  constant_properties = '33.840075630884 105.531169030917 139.892898282856 809 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_810]
  type = 'AbaqusUMATStress'
  block = 'poly810_HEX8'
  constant_properties = '-166.04209321737 48.714288792135 184.982623298697 810 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_811]
  type = 'AbaqusUMATStress'
  block = 'poly811_HEX8'
  constant_properties = '155.807304172041 72.129837454938 -125.130362069409 811 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_812]
  type = 'AbaqusUMATStress'
  block = 'poly812_HEX8'
  constant_properties = '39.034224209153 67.031947013614 -118.120908863859 812 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_813]
  type = 'AbaqusUMATStress'
  block = 'poly813_HEX8'
  constant_properties = '82.247853475121 69.499453549427 -205.277536168951 813 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_814]
  type = 'AbaqusUMATStress'
  block = 'poly814_HEX8'
  constant_properties = '132.88621861605 8.68694133925 -144.463419854376 814 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_815]
  type = 'AbaqusUMATStress'
  block = 'poly815_HEX8'
  constant_properties = '10.73743429022 111.769211356054 -65.708857068507 815 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_816]
  type = 'AbaqusUMATStress'
  block = 'poly816_HEX8'
  constant_properties = '41.507848232616 125.995959738315 -161.754367842851 816 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_817]
  type = 'AbaqusUMATStress'
  block = 'poly817_HEX8'
  constant_properties = '-52.211096833484 56.050027848407 100.42328348923 817 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_818]
  type = 'AbaqusUMATStress'
  block = 'poly818_HEX8'
  constant_properties = '85.180846531216 4.96596138161 -176.482103772426 818 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_819]
  type = 'AbaqusUMATStress'
  block = 'poly819_HEX8'
  constant_properties = '-139.725124425043 93.67149816441 69.518578335979 819 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_820]
  type = 'AbaqusUMATStress'
  block = 'poly820_HEX8'
  constant_properties = '95.177279497698 121.217732745751 -111.470301893541 820 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_821]
  type = 'AbaqusUMATStress'
  block = 'poly821_HEX8'
  constant_properties = '-146.982569272076 77.288535322105 31.310315905765 821 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_822]
  type = 'AbaqusUMATStress'
  block = 'poly822_HEX8'
  constant_properties = '-153.088316880224 73.286215584831 58.75355234454 822 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_823]
  type = 'AbaqusUMATStress'
  block = 'poly823_HEX8'
  constant_properties = '-131.927112450462 28.065560029475 37.671759989733 823 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_824]
  type = 'AbaqusUMATStress'
  block = 'poly824_HEX8'
  constant_properties = '61.101070291335 60.527905334264 28.740971489186 824 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_825]
  type = 'AbaqusUMATStress'
  block = 'poly825_HEX8'
  constant_properties = '-20.021313336393 112.182097330399 158.558904084869 825 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_826]
  type = 'AbaqusUMATStress'
  block = 'poly826_HEX8'
  constant_properties = '-90.069599576863 70.894223927142 134.786882472822 826 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_827]
  type = 'AbaqusUMATStress'
  block = 'poly827_HEX8'
  constant_properties = '-200.52860243498 80.392653460397 33.269331300573 827 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_828]
  type = 'AbaqusUMATStress'
  block = 'poly828_HEX8'
  constant_properties = '-127.068482861 82.61036780464 97.850922099249 828 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_829]
  type = 'AbaqusUMATStress'
  block = 'poly829_HEX8'
  constant_properties = '-93.156343310764 124.902133033695 -77.688929598938 829 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_830]
  type = 'AbaqusUMATStress'
  block = 'poly830_HEX8'
  constant_properties = '-157.850370789097 74.187149886464 69.621417011734 830 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_831]
  type = 'AbaqusUMATStress'
  block = 'poly831_HEX8'
  constant_properties = '-185.730501687975 135.583177447607 19.674644624287 831 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_832]
  type = 'AbaqusUMATStress'
  block = 'poly832_HEX8'
  constant_properties = '-11.26161165716 46.104769974978 166.088218393504 832 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_833]
  type = 'AbaqusUMATStress'
  block = 'poly833_HEX8'
  constant_properties = '-181.320955219712 85.067697162791 91.992583228696 833 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_834]
  type = 'AbaqusUMATStress'
  block = 'poly834_HEX8'
  constant_properties = '209.413787825293 51.197735811918 -77.687972050792 834 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_835]
  type = 'AbaqusUMATStress'
  block = 'poly835_HEX8'
  constant_properties = '-104.60673145456 50.799937192081 80.468891018392 835 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_836]
  type = 'AbaqusUMATStress'
  block = 'poly836_HEX8'
  constant_properties = '-136.555802099335 33.946873519445 13.910062134851 836 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_837]
  type = 'AbaqusUMATStress'
  block = 'poly837_HEX8'
  constant_properties = '97.081976178386 102.316623925727 -7.956042249317 837 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_838]
  type = 'AbaqusUMATStress'
  block = 'poly838_HEX8'
  constant_properties = '29.890081651325 49.027264130696 -97.770999901197 838 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_839]
  type = 'AbaqusUMATStress'
  block = 'poly839_HEX8'
  constant_properties = '-24.04024921493 64.474624154694 -38.508528441949 839 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_840]
  type = 'AbaqusUMATStress'
  block = 'poly840_HEX8'
  constant_properties = '151.94466342063 150.916718240499 -146.244619331489 840 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_841]
  type = 'AbaqusUMATStress'
  block = 'poly841_HEX8'
  constant_properties = '-125.550280203923 129.273036783106 220.430945393096 841 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_842]
  type = 'AbaqusUMATStress'
  block = 'poly842_HEX8'
  constant_properties = '21.95009354434 29.222372477643 -57.303472999366 842 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_843]
  type = 'AbaqusUMATStress'
  block = 'poly843_HEX8'
  constant_properties = '-124.187256132243 55.625444776668 47.975826836279 843 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_844]
  type = 'AbaqusUMATStress'
  block = 'poly844_HEX8'
  constant_properties = '-17.651920062541 136.855663100478 131.668833578959 844 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_845]
  type = 'AbaqusUMATStress'
  block = 'poly845_HEX8'
  constant_properties = '7.549188349065 73.261525841511 49.652964964243 845 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_846]
  type = 'AbaqusUMATStress'
  block = 'poly846_HEX8'
  constant_properties = '73.608318608298 124.087312196505 85.794808171338 846 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_847]
  type = 'AbaqusUMATStress'
  block = 'poly847_HEX8'
  constant_properties = '215.616492025035 56.305675436443 -79.242198530771 847 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_848]
  type = 'AbaqusUMATStress'
  block = 'poly848_HEX8'
  constant_properties = '119.885218453868 140.002725417893 -221.360064503712 848 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_849]
  type = 'AbaqusUMATStress'
  block = 'poly849_HEX8'
  constant_properties = '105.14425704685 93.493547186853 -209.582805506044 849 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_850]
  type = 'AbaqusUMATStress'
  block = 'poly850_HEX8'
  constant_properties = '-120.819128057569 92.397410615518 70.531027443816 850 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_851]
  type = 'AbaqusUMATStress'
  block = 'poly851_HEX8'
  constant_properties = '-110.243680376598 129.394401277911 202.11780498478 851 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_852]
  type = 'AbaqusUMATStress'
  block = 'poly852_HEX8'
  constant_properties = '-55.768844587398 28.126627197979 211.7623605638 852 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_853]
  type = 'AbaqusUMATStress'
  block = 'poly853_HEX8'
  constant_properties = '-29.982093223709 1.031837575226 69.382774402296 853 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_854]
  type = 'AbaqusUMATStress'
  block = 'poly854_HEX8'
  constant_properties = '178.860234756148 88.955437724564 -21.387342243012 854 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_855]
  type = 'AbaqusUMATStress'
  block = 'poly855_HEX8'
  constant_properties = '-75.857787024187 86.421969674941 11.599501480385 855 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_856]
  type = 'AbaqusUMATStress'
  block = 'poly856_HEX8'
  constant_properties = '72.476560828197 11.74047745961 26.558986188052 856 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_857]
  type = 'AbaqusUMATStress'
  block = 'poly857_HEX8'
  constant_properties = '-27.254949993647 146.229616471632 28.897710241283 857 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_858]
  type = 'AbaqusUMATStress'
  block = 'poly858_HEX8'
  constant_properties = '-185.129878324221 160.613747983581 154.751606318205 858 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_859]
  type = 'AbaqusUMATStress'
  block = 'poly859_HEX8'
  constant_properties = '-38.940147439286 59.986000270033 46.889865471113 859 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_860]
  type = 'AbaqusUMATStress'
  block = 'poly860_HEX8'
  constant_properties = '128.934536593784 94.773703691134 -201.037391538714 860 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_861]
  type = 'AbaqusUMATStress'
  block = 'poly861_HEX8'
  constant_properties = '151.912798719962 88.318024768918 -122.369299996695 861 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_862]
  type = 'AbaqusUMATStress'
  block = 'poly862_HEX8'
  constant_properties = '153.383392015827 34.900477136699 -149.580691784128 862 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_863]
  type = 'AbaqusUMATStress'
  block = 'poly863_HEX8'
  constant_properties = '-55.970768947927 67.392987453875 -86.327169508454 863 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_864]
  type = 'AbaqusUMATStress'
  block = 'poly864_HEX8'
  constant_properties = '-71.125114509096 78.065351681326 76.237173025265 864 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_865]
  type = 'AbaqusUMATStress'
  block = 'poly865_HEX8'
  constant_properties = '31.42139822518 168.113894304127 -57.150184617607 865 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_866]
  type = 'AbaqusUMATStress'
  block = 'poly866_HEX8'
  constant_properties = '110.41864845008 41.806088882582 -185.026879772636 866 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_867]
  type = 'AbaqusUMATStress'
  block = 'poly867_HEX8'
  constant_properties = '-138.953729480762 67.276439471837 6.54596152739 867 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_868]
  type = 'AbaqusUMATStress'
  block = 'poly868_HEX8'
  constant_properties = '75.437341070405 86.414454843307 -83.953222484895 868 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_869]
  type = 'AbaqusUMATStress'
  block = 'poly869_HEX8'
  constant_properties = '-16.709912551945 77.148666549804 148.155014895161 869 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_870]
  type = 'AbaqusUMATStress'
  block = 'poly870_HEX8'
  constant_properties = '-56.597345202182 76.254807245706 -48.677904884221 870 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_871]
  type = 'AbaqusUMATStress'
  block = 'poly871_HEX8'
  constant_properties = '178.991896159421 77.23914584723 -115.173336499047 871 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_872]
  type = 'AbaqusUMATStress'
  block = 'poly872_HEX8'
  constant_properties = '47.727275949759 108.146645505524 72.873109569392 872 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_873]
  type = 'AbaqusUMATStress'
  block = 'poly873_HEX8'
  constant_properties = '-136.197683463228 120.773240649407 -38.023501549848 873 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_874]
  type = 'AbaqusUMATStress'
  block = 'poly874_HEX8'
  constant_properties = '85.823787675322 51.297347870599 -100.943373962539 874 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_875]
  type = 'AbaqusUMATStress'
  block = 'poly875_HEX8'
  constant_properties = '-18.010422286975 31.745858498498 -10.825748239177 875 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_876]
  type = 'AbaqusUMATStress'
  block = 'poly876_HEX8'
  constant_properties = '138.071494688126 154.551614908762 -111.812169004706 876 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_877]
  type = 'AbaqusUMATStress'
  block = 'poly877_HEX8'
  constant_properties = '129.593709955147 114.023723815431 -212.511082621047 877 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_878]
  type = 'AbaqusUMATStress'
  block = 'poly878_HEX8'
  constant_properties = '32.98339385415 22.855530959195 48.225242810876 878 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_879]
  type = 'AbaqusUMATStress'
  block = 'poly879_HEX8'
  constant_properties = '-65.857402871886 111.387205010115 80.201065364495 879 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_880]
  type = 'AbaqusUMATStress'
  block = 'poly880_HEX8'
  constant_properties = '40.380001976284 51.06845785496 1.326733203248 880 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_881]
  type = 'AbaqusUMATStress'
  block = 'poly881_HEX8'
  constant_properties = '-62.858616441993 160.467695149044 146.937977502311 881 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_882]
  type = 'AbaqusUMATStress'
  block = 'poly882_HEX8'
  constant_properties = '86.26706324244 23.318336060137 -204.513665437238 882 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_883]
  type = 'AbaqusUMATStress'
  block = 'poly883_HEX8'
  constant_properties = '-10.897644014598 78.405903205575 -37.170122772204 883 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_884]
  type = 'AbaqusUMATStress'
  block = 'poly884_HEX8'
  constant_properties = '161.614021305524 61.589723739921 -175.455159761557 884 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_885]
  type = 'AbaqusUMATStress'
  block = 'poly885_HEX8'
  constant_properties = '-27.044451955948 28.34019066002 -83.827738987935 885 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_886]
  type = 'AbaqusUMATStress'
  block = 'poly886_HEX8'
  constant_properties = '-16.937934874738 34.056270399745 -54.359844961913 886 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_887]
  type = 'AbaqusUMATStress'
  block = 'poly887_HEX8'
  constant_properties = '44.024286000125 96.639473800627 22.147249277069 887 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_888]
  type = 'AbaqusUMATStress'
  block = 'poly888_HEX8'
  constant_properties = '129.380423094644 169.747338249154 -124.88756803877 888 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_889]
  type = 'AbaqusUMATStress'
  block = 'poly889_HEX8'
  constant_properties = '-146.319198226768 138.964684040037 168.02296826971 889 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_890]
  type = 'AbaqusUMATStress'
  block = 'poly890_HEX8'
  constant_properties = '-170.160658044898 12.11351033795 147.142209210041 890 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_891]
  type = 'AbaqusUMATStress'
  block = 'poly891_HEX8'
  constant_properties = '97.429128082195 125.08528285582 -179.615026927056 891 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_892]
  type = 'AbaqusUMATStress'
  block = 'poly892_HEX8'
  constant_properties = '-22.239507077353 88.914282322399 4.668775635973 892 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_893]
  type = 'AbaqusUMATStress'
  block = 'poly893_HEX8'
  constant_properties = '228.490523653235 92.49778516369 -121.069759146894 893 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_894]
  type = 'AbaqusUMATStress'
  block = 'poly894_HEX8'
  constant_properties = '-27.064646341063 17.426183211402 197.40798566381 894 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_895]
  type = 'AbaqusUMATStress'
  block = 'poly895_HEX8'
  constant_properties = '125.074279572205 92.566591197551 -187.965795723815 895 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_896]
  type = 'AbaqusUMATStress'
  block = 'poly896_HEX8'
  constant_properties = '47.034885850253 121.395037293576 56.932564283843 896 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_897]
  type = 'AbaqusUMATStress'
  block = 'poly897_HEX8'
  constant_properties = '30.124621368244 99.795028049491 -35.739593266737 897 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_898]
  type = 'AbaqusUMATStress'
  block = 'poly898_HEX8'
  constant_properties = '-139.358506512443 125.436465799731 -25.40963955496 898 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_899]
  type = 'AbaqusUMATStress'
  block = 'poly899_HEX8'
  constant_properties = '18.586579297982 119.112379630237 -96.799693825149 899 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_900]
  type = 'AbaqusUMATStress'
  block = 'poly900_HEX8'
  constant_properties = '-108.545885727535 155.837185005243 249.267560385098 900 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_901]
  type = 'AbaqusUMATStress'
  block = 'poly901_HEX8'
  constant_properties = '71.701527731067 90.178761435217 -238.216592921831 901 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_902]
  type = 'AbaqusUMATStress'
  block = 'poly902_HEX8'
  constant_properties = '-144.959503280545 106.172000345966 -9.757617964515 902 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_903]
  type = 'AbaqusUMATStress'
  block = 'poly903_HEX8'
  constant_properties = '104.462305327217 69.837800223022 -119.106845920425 903 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_904]
  type = 'AbaqusUMATStress'
  block = 'poly904_HEX8'
  constant_properties = '-97.831912825686 28.712577128798 230.573723720806 904 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_905]
  type = 'AbaqusUMATStress'
  block = 'poly905_HEX8'
  constant_properties = '-1.011434746258 78.284616811447 -89.4138623377 905 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_906]
  type = 'AbaqusUMATStress'
  block = 'poly906_HEX8'
  constant_properties = '23.161257841823 37.717920751148 -145.310627031677 906 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_907]
  type = 'AbaqusUMATStress'
  block = 'poly907_HEX8'
  constant_properties = '-126.297545066773 91.460358406103 -12.330128363843 907 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_908]
  type = 'AbaqusUMATStress'
  block = 'poly908_HEX8'
  constant_properties = '32.622180291558 110.761884030534 -35.609391781767 908 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_909]
  type = 'AbaqusUMATStress'
  block = 'poly909_HEX8'
  constant_properties = '220.942728445302 47.19016445789 -84.56684132278 909 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_910]
  type = 'AbaqusUMATStress'
  block = 'poly910_HEX8'
  constant_properties = '-3.982734958132 138.151140330034 45.523857417082 910 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_911]
  type = 'AbaqusUMATStress'
  block = 'poly911_HEX8'
  constant_properties = '128.785987933054 112.103736438877 -110.380891722128 911 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_912]
  type = 'AbaqusUMATStress'
  block = 'poly912_HEX8'
  constant_properties = '-106.849894058558 100.592000600975 207.116792343588 912 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_913]
  type = 'AbaqusUMATStress'
  block = 'poly913_HEX8'
  constant_properties = '-90.157665709922 117.50884581639 -49.025309329213 913 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_914]
  type = 'AbaqusUMATStress'
  block = 'poly914_HEX8'
  constant_properties = '76.57311969189 33.08458096906 -164.16295076591 914 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_915]
  type = 'AbaqusUMATStress'
  block = 'poly915_HEX8'
  constant_properties = '40.496577439325 48.762410151223 78.136093841543 915 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_916]
  type = 'AbaqusUMATStress'
  block = 'poly916_HEX8'
  constant_properties = '-118.338303367474 78.098699615072 30.278529654852 916 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_917]
  type = 'AbaqusUMATStress'
  block = 'poly917_HEX8'
  constant_properties = '175.804492722839 84.427320164252 -136.287455963275 917 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_918]
  type = 'AbaqusUMATStress'
  block = 'poly918_HEX8'
  constant_properties = '16.127803445592 142.060278361606 -70.646806779094 918 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_919]
  type = 'AbaqusUMATStress'
  block = 'poly919_HEX8'
  constant_properties = '-90.576292027351 72.381050661674 256.447080313692 919 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_920]
  type = 'AbaqusUMATStress'
  block = 'poly920_HEX8'
  constant_properties = '147.980530329912 168.68743757406 -157.869075005433 920 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_921]
  type = 'AbaqusUMATStress'
  block = 'poly921_HEX8'
  constant_properties = '41.638918716088 55.328105305396 -33.418208301065 921 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_922]
  type = 'AbaqusUMATStress'
  block = 'poly922_HEX8'
  constant_properties = '-74.30558882167 132.482108054249 -55.955347613464 922 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_923]
  type = 'AbaqusUMATStress'
  block = 'poly923_HEX8'
  constant_properties = '-245.668141105894 94.876493635385 103.375398714527 923 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_924]
  type = 'AbaqusUMATStress'
  block = 'poly924_HEX8'
  constant_properties = '206.798008922485 105.19620687725 -108.576593042782 924 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_925]
  type = 'AbaqusUMATStress'
  block = 'poly925_HEX8'
  constant_properties = '215.047736095038 54.8813135022 -51.683856399928 925 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_926]
  type = 'AbaqusUMATStress'
  block = 'poly926_HEX8'
  constant_properties = '51.3513306668 107.74396620283 -103.679699241325 926 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_927]
  type = 'AbaqusUMATStress'
  block = 'poly927_HEX8'
  constant_properties = '37.699478760884 79.404651627242 133.27696505698 927 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_928]
  type = 'AbaqusUMATStress'
  block = 'poly928_HEX8'
  constant_properties = '114.721439500426 146.95240909494 30.470327938691 928 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_929]
  type = 'AbaqusUMATStress'
  block = 'poly929_HEX8'
  constant_properties = '88.00127367475 68.226298192031 35.808087266343 929 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_930]
  type = 'AbaqusUMATStress'
  block = 'poly930_HEX8'
  constant_properties = '49.364465916228 109.124576097467 -31.981858446796 930 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_931]
  type = 'AbaqusUMATStress'
  block = 'poly931_HEX8'
  constant_properties = '135.779311693113 59.242219135105 -67.414705044731 931 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_932]
  type = 'AbaqusUMATStress'
  block = 'poly932_HEX8'
  constant_properties = '190.319687853036 108.239498555805 -70.214117530342 932 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_933]
  type = 'AbaqusUMATStress'
  block = 'poly933_HEX8'
  constant_properties = '224.096512229934 66.223900394706 -114.98826647534 933 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_934]
  type = 'AbaqusUMATStress'
  block = 'poly934_HEX8'
  constant_properties = '-58.512377276564 84.935107577769 204.353100051371 934 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_935]
  type = 'AbaqusUMATStress'
  block = 'poly935_HEX8'
  constant_properties = '-52.2286572398 25.108503928272 -71.266119483613 935 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_936]
  type = 'AbaqusUMATStress'
  block = 'poly936_HEX8'
  constant_properties = '-111.386207985839 111.524783160558 242.362609471816 936 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_937]
  type = 'AbaqusUMATStress'
  block = 'poly937_HEX8'
  constant_properties = '-87.810963606922 46.975315775015 9.446252250788 937 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_938]
  type = 'AbaqusUMATStress'
  block = 'poly938_HEX8'
  constant_properties = '-31.570172976047 153.785434696857 24.598271012547 938 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_939]
  type = 'AbaqusUMATStress'
  block = 'poly939_HEX8'
  constant_properties = '-2.590926817997 47.785805075476 98.62475096746 939 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_940]
  type = 'AbaqusUMATStress'
  block = 'poly940_HEX8'
  constant_properties = '-129.54222173716 135.80778463849 12.423779364216 940 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_941]
  type = 'AbaqusUMATStress'
  block = 'poly941_HEX8'
  constant_properties = '83.921866730349 55.884428257607 -208.793585189914 941 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_942]
  type = 'AbaqusUMATStress'
  block = 'poly942_HEX8'
  constant_properties = '75.706436162803 82.13265310049 75.065838949618 942 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_943]
  type = 'AbaqusUMATStress'
  block = 'poly943_HEX8'
  constant_properties = '75.94222419869 113.286942963974 -46.527350988197 943 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_944]
  type = 'AbaqusUMATStress'
  block = 'poly944_HEX8'
  constant_properties = '157.217321112632 65.154583215324 -175.635860930301 944 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_945]
  type = 'AbaqusUMATStress'
  block = 'poly945_HEX8'
  constant_properties = '88.872058833224 146.142326813822 -194.224510315884 945 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_946]
  type = 'AbaqusUMATStress'
  block = 'poly946_HEX8'
  constant_properties = '-105.843407428462 67.235780829172 -44.96014068953 946 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_947]
  type = 'AbaqusUMATStress'
  block = 'poly947_HEX8'
  constant_properties = '-128.892410504609 108.627679697319 176.623552105412 947 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_948]
  type = 'AbaqusUMATStress'
  block = 'poly948_HEX8'
  constant_properties = '196.607286103252 3.789998580706 -120.937644401528 948 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_949]
  type = 'AbaqusUMATStress'
  block = 'poly949_HEX8'
  constant_properties = '58.287655026798 114.155720002732 28.550145553336 949 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_950]
  type = 'AbaqusUMATStress'
  block = 'poly950_HEX8'
  constant_properties = '237.71526126236 41.738243981372 -118.05423632226 950 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_951]
  type = 'AbaqusUMATStress'
  block = 'poly951_HEX8'
  constant_properties = '-51.494910709483 48.630637976579 98.336572902107 951 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_952]
  type = 'AbaqusUMATStress'
  block = 'poly952_HEX8'
  constant_properties = '-41.781398574199 30.821049727521 -84.968690305226 952 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_953]
  type = 'AbaqusUMATStress'
  block = 'poly953_HEX8'
  constant_properties = '-72.215385033622 146.731338382468 32.491951625501 953 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_954]
  type = 'AbaqusUMATStress'
  block = 'poly954_HEX8'
  constant_properties = '-117.276772722992 134.211420607908 74.449519932716 954 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_955]
  type = 'AbaqusUMATStress'
  block = 'poly955_HEX8'
  constant_properties = '-168.890959940676 103.468450996921 178.484281318551 955 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_956]
  type = 'AbaqusUMATStress'
  block = 'poly956_HEX8'
  constant_properties = '-41.432530698937 50.757872802612 -1.912480045474 956 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_957]
  type = 'AbaqusUMATStress'
  block = 'poly957_HEX8'
  constant_properties = '72.802439507152 31.971322850299 -82.157194138972 957 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_958]
  type = 'AbaqusUMATStress'
  block = 'poly958_HEX8'
  constant_properties = '-46.566389614464 144.851615068199 119.539543790478 958 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_959]
  type = 'AbaqusUMATStress'
  block = 'poly959_HEX8'
  constant_properties = '-35.256544814241 23.728720815782 -9.104691786101 959 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_960]
  type = 'AbaqusUMATStress'
  block = 'poly960_HEX8'
  constant_properties = '-4.551011378124 122.979401051215 1.53136986927 960 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_961]
  type = 'AbaqusUMATStress'
  block = 'poly961_HEX8'
  constant_properties = '40.575817458285 42.184848300182 -149.531256572957 961 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_962]
  type = 'AbaqusUMATStress'
  block = 'poly962_HEX8'
  constant_properties = '-108.599491146925 118.476688577538 205.177111584001 962 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_963]
  type = 'AbaqusUMATStress'
  block = 'poly963_HEX8'
  constant_properties = '133.43505411527 95.557109309407 -224.033008888052 963 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_964]
  type = 'AbaqusUMATStress'
  block = 'poly964_HEX8'
  constant_properties = '112.553171763524 130.813302954452 37.486258255933 964 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_965]
  type = 'AbaqusUMATStress'
  block = 'poly965_HEX8'
  constant_properties = '40.822469814441 128.438870199869 104.127299561046 965 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_966]
  type = 'AbaqusUMATStress'
  block = 'poly966_HEX8'
  constant_properties = '103.769410994679 98.908729983818 -135.808272323818 966 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_967]
  type = 'AbaqusUMATStress'
  block = 'poly967_HEX8'
  constant_properties = '-224.092669664498 80.233979108293 110.285632812794 967 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_968]
  type = 'AbaqusUMATStress'
  block = 'poly968_HEX8'
  constant_properties = '105.608030740969 6.839827033802 -208.596484278115 968 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_969]
  type = 'AbaqusUMATStress'
  block = 'poly969_HEX8'
  constant_properties = '-2.588627981001 142.634047450437 -104.572032668163 969 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_970]
  type = 'AbaqusUMATStress'
  block = 'poly970_HEX8'
  constant_properties = '18.565043272363 75.770005694006 -191.817083424068 970 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_971]
  type = 'AbaqusUMATStress'
  block = 'poly971_HEX8'
  constant_properties = '11.156590298008 126.383010680303 -185.470139015126 971 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_972]
  type = 'AbaqusUMATStress'
  block = 'poly972_HEX8'
  constant_properties = '-66.268967570565 106.796280141294 2.154157225564 972 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_973]
  type = 'AbaqusUMATStress'
  block = 'poly973_HEX8'
  constant_properties = '-84.673992181512 107.269786945995 228.74765837192 973 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_974]
  type = 'AbaqusUMATStress'
  block = 'poly974_HEX8'
  constant_properties = '-65.875096548857 35.825222233269 -80.005872157186 974 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_975]
  type = 'AbaqusUMATStress'
  block = 'poly975_HEX8'
  constant_properties = '-212.549341001935 33.144189386028 63.353153668757 975 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_976]
  type = 'AbaqusUMATStress'
  block = 'poly976_HEX8'
  constant_properties = '-151.234103045633 153.443756359705 17.670784946174 976 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_977]
  type = 'AbaqusUMATStress'
  block = 'poly977_HEX8'
  constant_properties = '-66.074312469245 126.353990529801 177.810813206598 977 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_978]
  type = 'AbaqusUMATStress'
  block = 'poly978_HEX8'
  constant_properties = '-7.325120212671 102.931098488381 30.188255134509 978 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_979]
  type = 'AbaqusUMATStress'
  block = 'poly979_HEX8'
  constant_properties = '-126.852512223475 102.505408340363 223.185857931438 979 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_980]
  type = 'AbaqusUMATStress'
  block = 'poly980_HEX8'
  constant_properties = '2.954794120464 55.002662502658 168.835660011801 980 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_981]
  type = 'AbaqusUMATStress'
  block = 'poly981_HEX8'
  constant_properties = '-64.792539040454 89.512266430951 -6.504144805974 981 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_982]
  type = 'AbaqusUMATStress'
  block = 'poly982_HEX8'
  constant_properties = '42.935535991109 120.439280799162 -27.187484016675 982 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_983]
  type = 'AbaqusUMATStress'
  block = 'poly983_HEX8'
  constant_properties = '-204.91398440435 25.437182144168 110.846530414355 983 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_984]
  type = 'AbaqusUMATStress'
  block = 'poly984_HEX8'
  constant_properties = '-68.565392479676 145.741735772729 208.535413878172 984 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_985]
  type = 'AbaqusUMATStress'
  block = 'poly985_HEX8'
  constant_properties = '45.340221513504 8.829822339265 131.374341246865 985 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_986]
  type = 'AbaqusUMATStress'
  block = 'poly986_HEX8'
  constant_properties = '190.969182497699 49.353844565077 -135.451414430243 986 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_987]
  type = 'AbaqusUMATStress'
  block = 'poly987_HEX8'
  constant_properties = '-74.326910312438 103.734723008876 47.617806168768 987 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_988]
  type = 'AbaqusUMATStress'
  block = 'poly988_HEX8'
  constant_properties = '11.153921252863 12.057154255961 96.146556326928 988 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_989]
  type = 'AbaqusUMATStress'
  block = 'poly989_HEX8'
  constant_properties = '-198.33403160241 43.645178967594 124.625171020175 989 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_990]
  type = 'AbaqusUMATStress'
  block = 'poly990_HEX8'
  constant_properties = '70.595476511766 34.236450951874 5.513058971949 990 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_991]
  type = 'AbaqusUMATStress'
  block = 'poly991_HEX8'
  constant_properties = '-123.681051020909 52.778849423344 16.522265153655 991 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_992]
  type = 'AbaqusUMATStress'
  block = 'poly992_HEX8'
  constant_properties = '-163.735689469791 20.890717291018 28.806180853774 992 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_993]
  type = 'AbaqusUMATStress'
  block = 'poly993_HEX8'
  constant_properties = '-173.201477650293 23.237298565062 155.359687451871 993 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_994]
  type = 'AbaqusUMATStress'
  block = 'poly994_HEX8'
  constant_properties = '43.103639530284 148.432268571858 -165.272017474262 994 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_995]
  type = 'AbaqusUMATStress'
  block = 'poly995_HEX8'
  constant_properties = '-19.246251293252 87.147505267193 -158.857131119263 995 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_996]
  type = 'AbaqusUMATStress'
  block = 'poly996_HEX8'
  constant_properties = '5.743403889467 82.670009491897 -24.671570697918 996 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_997]
  type = 'AbaqusUMATStress'
  block = 'poly997_HEX8'
  constant_properties = '-189.06882922238 83.456891552284 117.645336778768 997 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_998]
  type = 'AbaqusUMATStress'
  block = 'poly998_HEX8'
  constant_properties = '-132.547315670341 166.104729394839 125.676233068375 998 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_999]
  type = 'AbaqusUMATStress'
  block = 'poly999_HEX8'
  constant_properties = '54.713274268117 90.241474324406 -215.078361924654 999 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Materials/grain_1000]
  type = 'AbaqusUMATStress'
  block = 'poly1000_HEX8'
  constant_properties = '-159.290115733733 139.020919505493 98.528557962906 1000 2 0'
  plugin = '@UMAT@'
  num_state_vars = '1'
  use_one_based_indexing = 'true'
  external_fields = 'stress_xx strain_xx stress_yy strain_yy stress_zz strain_zz'
[]

[Executioner/TimeStepper]
  type = 'ConstantDT'
  dt = '1e-06'
[]

[Outputs/history_csv]
  type = 'CSV'
  execute_on = 'INITIAL TIMESTEP_END'
[]

[Postprocessors/iteration]
  type = 'NumTimeSteps'
  execute_on = 'INITIAL TIMESTEP_END'
[]

[Postprocessors/nonlinear_iterations]
  type = 'NumNonlinearIterations'
  execute_on = 'INITIAL TIMESTEP_END'
[]

[Postprocessors/linear_iterations]
  type = 'NumLinearIterations'
  execute_on = 'INITIAL TIMESTEP_END'
[]

[Postprocessors/max_gcum]
  type = 'ElementExtremeValue'
  variable = 'gcum'
  value_type = 'max'
  execute_on = 'TIMESTEP_END'
[]

[UserObjects/elastic_guard]
  type = 'Terminator'
  expression = 'max_gcum > 1e-12'
  execute_on = 'TIMESTEP_END'
  fail_mode = 'HARD'
  error_level = 'ERROR'
  message = 'Elastic-only benchmark stopped: cumulative slip exceeds 1e-12.'
[]

[Postprocessors/solve_seconds]
  type = 'PerfGraphData'
  section_name = 'FEProblem::solve'
  data_type = 'TOTAL'
  must_exist = 'false'
  execute_on = 'INITIAL TIMESTEP_END'
[]
