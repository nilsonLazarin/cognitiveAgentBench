// Agent bob in project cognitiveAgentBenchWithJasonARGO
/* Initial beliefs and rules */
//usbPort(ttyEmulatedPort0).
usbPort(ttyUSB0).
littePrime(999989).
bigPrime(99999997).

/* Initial goals */
!start.

/* Plans */
+!start <-
    ?usbPort(SerialPort);
    .argo.port(SerialPort);
    .argo.percepts(open);
    .print("Press any key (LCD Keypad Shield) or A0 on Arduino to start....").

+number(R) <-
    .argo.percepts(close);
    !calc(R);
    .argo.percepts(open).

+result(PPM) <-
    .print("PPM = ",PPM);
    .stopMAS.

+port(ttyUSB0,on): not running <-
    .print("Iniciando....");
    .argo.act(startBench);
.



+bobPublicKey(K) <- .print(K).

+!calc(PrivateKey) <-
    .number(PrivateKey);
    ?littePrime(B);           
    ?bigPrime(N);             
    !powmod(B, PrivateKey, N, PublicKey);
    -+bobPublicKey(PublicKey);
.

// ---- Exponenciação modular: Res = (Base^Exp) mod Mod ----
+!powmod(Base, Exp, Mod, Res) : Exp == 0 <-
    Res = 1.

+!powmod(Base, Exp, Mod, Res) : Exp > 0 & (Exp mod 2) == 0 <-
    E2 = Exp div 2;
    !powmod(Base, E2, Mod, T);
    Res = (T * T) mod Mod.

+!powmod(Base, Exp, Mod, Res) : Exp > 0 & (Exp mod 2) == 1 <-
    Exp1 = Exp - 1;
    !powmod(Base, Exp1, Mod, T);
    Res = (Base * T) mod Mod.
