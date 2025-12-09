littePrime(999989).
bigPrime(99999997).
count(0).
ppm(0,0).
devices(0).

!start.

+!start <-
    !newDevice(b0,ttyUSB0);
    !newDevice(b1,ttyUSB1);
    !newDevice(b2,ttyUSB2);
    !newDevice(b3,ttyUSB3);
    ?devices(A);
    .print("Waiting for ",A," agents...");
    .wait(.count(ready(_),A));
    .print("All agents ready...");
    .broadcast(achieve,startBench);
    .print("Starting Benchmarking..."); 
.

+!newDevice(Name,Port) <-
    .create_agent(Name,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(Name,achieve,connect(Port));
    ?devices(N);
    -+devices(N+1);
.

+!calc(PrivateKey)[source(Origem)]: count(C) <-
    -+count(C+1);
    .number(PrivateKey);
    ?littePrime(B);           
    ?bigPrime(N);             
    !powmod(B, PrivateKey+C, N, PublicKey);
    .send(Origem,tell,publicKey(C+1,PublicKey));
.

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

+ready(Agent)[source(A)]: not waitting <- +waitting; !stopTest.

+!stopTest: not ready(Agent)[source(A)] <- .stopMAS.
-!stopTest <- .wait(1000); !stopTest.

+!calcPPM(PPM) <-
    ?ppm(A,V);
    -+ppm(A+1,V+PPM).
