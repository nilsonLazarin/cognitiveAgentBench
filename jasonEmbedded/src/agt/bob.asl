/* Plans */
+!connect(Port) <-
    .argo.port(Port);
    +myPort(Port);
    .argo.percepts(open);
.

+!startBench <- .argo.act(startBench); .print("Starting...").

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

+port(P,on): not running <-
    +running;
    .print("Connected.... port=",P);
    .my_name(Agent);
    .broadcast(tell,ready(Agent));
.

+port(P,off) <-
    .argo.percepts(close);
    .abolish(port(_,_));
    .random(R); .wait(5000);
    ?myPort(Port);
    .print("Tryng again....",Port);
    !connect(Port);
.