// Agent bob in project cognitiveAgentBenchWithJasonARGO
/* Initial beliefs and rules */
//usbPort(ttyEmulatedPort0).
usbPort(ttyUSB0).

/* Initial goals */
!start.

/* Plans */
+!start <-
    ?usbPort(SerialPort);
    .argo.port(SerialPort);
    .argo.percepts(open);
.

+number(R) <-
    .argo.percepts(close);
    .send(alice,achieve,calc(R));
    .argo.percepts(open).

+result(PPM) <-
    .print("PPM = ",PPM);
    .stopMAS.

+port(ttyUSB0,on): not running <-
    .print("Starting....");
    .argo.act(startBench);
.