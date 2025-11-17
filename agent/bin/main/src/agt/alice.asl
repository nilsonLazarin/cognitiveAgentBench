littePrime(999989).
bigPrime(99999997).
count(0).

+!calc(PrivateKey) <-
    ?count(C);
    -+count(C+1);
    .number(PrivateKey);
    ?littePrime(B);           
    ?bigPrime(N);             
    !powmod(B, PrivateKey, N, PublicKey);
    .send(charlie,tell,key(C+1,PublicKey));
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
