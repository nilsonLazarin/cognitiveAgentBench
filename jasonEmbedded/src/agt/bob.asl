/* Plans */
+!start(Port) <-
    .argo.port(Port);
    +myPort(Port);
    .argo.percepts(open);
.

+publicKey(N,V) <- .argo.percepts(open).

+number(R) <-
    .argo.percepts(close);
    .send(alice,achieve,calc(R)).

+result(PPM) <-
    .argo.percepts(close);
    .print("PPM = ",PPM);
    .my_name(Agent);
    .random(R);
    .wait(5000*R);
    .send(alice,achieve,calcPPM(PPM));
    .wait(2000*R);
    .broadcast(untell,ready(Agent));
.

+port(P,on) <-
    .print("Connected.... port=",P);
    .my_name(Agent);
    .broadcast(tell,ready(Agent));
.

+!startBench <- .argo.act(startBench); .print("Starting...").

+port(P,off) <-
    .argo.percepts(close);
    .random(R); .wait(2000*R);
    .print("Tryng again....",P);
    !start(Port);
.

+port(P,timeout) <-
    .argo.percepts(close);
    .print("Timeout....",P);
.