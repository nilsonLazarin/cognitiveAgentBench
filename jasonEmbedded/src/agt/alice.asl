littePrime(999989).
bigPrime(99999997).
count(0).
ppm(0,0).
agts(0).

!start.

+!start <-
    .create_agent(b0,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b0,achieve,start(ttyUSB0));
    .create_agent(b1,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b1,achieve,start(ttyUSB1));
    /*.create_agent(b2,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b2,achieve,start(ttyUSB2));
    .create_agent(b3,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b3,achieve,start(ttyUSB3));
    .create_agent(b4,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b4,achieve,start(ttyUSB4));
    .create_agent(b5,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b5,achieve,start(ttyUSB5));
    .create_agent(b6,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b6,achieve,start(ttyUSB6));
    .create_agent(b7,"bob.asl", [agentArchClass("jason.Argo")]);
    .send(b7,achieve,start(ttyUSB7));*/
    .print("Waiting agents...");       
    .wait(agts(2));
    .broadcast(achieve,startBench);
    .print("Starting Benchmarking..."); 
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

+ready(Agent)[source(A)]: waitting <- ?agts(C); -+agts(C+1).

+ready(Agent)[source(A)]: not waitting <- +waitting; ?agts(C); -+agts(C+1); !stopTest.

+!stopTest: not ready(Agent)[source(A)] <- 
    ?ppm(A,V);
    .print(" PPM = ",A,"/",V," = ",V/A);
    .stopMAS;
.
-!stopTest <- .wait(1000); !stopTest.

+!calcPPM(PPM) <-
    ?ppm(A,V);
    -+ppm(A+1,V+PPM).