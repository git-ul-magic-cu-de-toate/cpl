class A {
    f() : SELF_TYPE { new SELF_TYPE };
};

class B inherits A {
    g() : Int { 0 };
};

(*
    Următoarele remarci vizează tipul lui f și linia "b.f().g()" de mai jos:

    * Dacă f are tipul A, b.f() are tipul A, dar metoda g nu este vizibilă
      pentru tipul A, și obținem eroare.

    * Dacă f are tipul SELF_TYPE și b din let are tipul static B, ca mai jos,
      se consideră că f.b() întoarce B, și metoda g este vizibilă pentru tipul
      B.

    * Dacă f are tipul SELF_TYPE, dar b din let are tipul static A, se consideră
      că b.f() întoarce A, dar metoda g nu este vizibilă pentru tipul A,
      și obținem eroare.

    * Dacă f are implementarea de mai sus, tipul dinamic al obiectului întors
      de b.f() va fi întotdeauna B, datorită lui new SELF_TYPE, indiferent
      de tipul static al lui b.
*)
class Main {
    main() : Object {
        let b : B <- new B 
        in
            {
                b.f();
                b.g();
                b.f().g();  -- linia de interes
            }
    };
};