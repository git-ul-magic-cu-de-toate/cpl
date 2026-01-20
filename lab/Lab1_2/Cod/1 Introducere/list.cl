(*
    Listă omogenă cu elemente de tip Int. Clasa List constituie rădăcina
    ierarhiei de clase reprezentând liste, codificând în același timp
    o listă vidă.

    Adaptare după arhiva oficială de exemple a limbajului COOL.
*)
class List inherits IO {
    isEmpty() : Bool { true };

    -- 0, deși cod mort, este necesar pentru verificarea tipurilor
    hd() : Int { { abort(); 0; } };

    -- Similar pentru self
    tl() : List { { abort(); self; } };

    cons(h : Int) : List {
        new Cons.init(h, self)
    };

    print() : IO { out_string("\n") };
};

(*
    În privința vizibilității, atributele sunt implicit protejate, iar metodele,
    publice.

    Atributele și metodele utilizează spații de nume diferite, motiv pentru care
    hd și tl reprezintă nume atât de atribute, cât și de metode.
*)
class Cons inherits List {
    hd : Int;
    tl : List;

    init(h : Int, t : List) : List {
        {
            hd <- h;
            tl <- t;
            self;
        }
    };

    -- Supradefinirea funcțiilor din clasa List
    isEmpty() : Bool { false };

    hd() : Int { hd };

    tl() : List { tl };

    print() : IO {
        {
            out_int(hd);
            out_string(" ");
            -- Mecanismul de dynamic dispatch asigură alegerea implementării
            -- corecte a metodei print.
            tl.print();
        }
    };
};

class Main inherits IO {
    main() : Object {
        let list : List <- new List.cons(1).cons(2).cons(3),
            temp : List <- list
        in
            {
                -- Afișare utilizând o buclă while. Mecanismul de dynamic
                -- dispatch asigură alegerea implementării corecte a metodei
                -- isEmpty, din clasele List, respectiv Cons.
                while (not temp.isEmpty()) loop
                    {
                        out_int(temp.hd());
                        out_string(" ");
                        temp <- temp.tl();
                    }
                pool;

                out_string("\n");

                -- Afișare utilizând metoda din clasele pe liste.
                list.print();
            }
    };
};