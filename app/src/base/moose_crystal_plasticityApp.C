#include "moose_crystal_plasticityApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
moose_crystal_plasticityApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

moose_crystal_plasticityApp::moose_crystal_plasticityApp(InputParameters parameters) : MooseApp(parameters)
{
  moose_crystal_plasticityApp::registerAll(_factory, _action_factory, _syntax);
}

moose_crystal_plasticityApp::~moose_crystal_plasticityApp() {}

void
moose_crystal_plasticityApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<moose_crystal_plasticityApp>(f, af, s);
  Registry::registerObjectsTo(f, {"moose_crystal_plasticityApp"});
  Registry::registerActionsTo(af, {"moose_crystal_plasticityApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
moose_crystal_plasticityApp::registerApps()
{
  registerApp(moose_crystal_plasticityApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
moose_crystal_plasticityApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  moose_crystal_plasticityApp::registerAll(f, af, s);
}
extern "C" void
moose_crystal_plasticityApp__registerApps()
{
  moose_crystal_plasticityApp::registerApps();
}
