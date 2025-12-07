/* Plans */
+!start(Port) <-
    .argo.port(Port);
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
    .broadcast(untell,busy(Agent));
.

+port(P,on) <-
    .print("Starting.... port=",P);
    .my_name(Agent);
    .broadcast(tell,busy(Agent));
    .argo.act(startBench);
.

+port(P,off) <-
    .argo.percepts(close);
    .print("Skipping....",P);
.

+port(P,timeout) <-
    .argo.percepts(close);
    .print("Timeout....",P);
.