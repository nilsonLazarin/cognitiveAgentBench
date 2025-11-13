// Agent bob in project cognitiveBenchWithJaCaMoARGO

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start <-
    .print("hello world.");
    .argo.port(ttyUSB0);
    .argo.percepts(open).

/*
{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
*/
// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }
