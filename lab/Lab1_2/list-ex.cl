(*
    Laborator COOL.
*)

(*
    Exercițiul 1.

    Implementați funcția fibonacci, utilizând atât varianta recursivă,
    cât și cea iterativă.
*)
class Fibo {
    fibo_rec(n : Int) : Int {
        if n = 1 then 0
        else if n = 2 then 1
        else fibo_rec(n - 1) + fibo_rec(n - 2) fi fi
    };

    fibo_iter(n : Int) : Int {
        let n1 : Int <- 0,
            n2 : Int <- 1,
            n3 : Int<- 1,
            dummy : Int <- 1,
            i : Int <- 3
        in {
            if n = 1 then 0
            else if n = 2 then 1
            else {
            
            while (i <= n) loop {
                n3 <- n1 + n2;
                i <- i + 1;
                dummy <- n2;
                n1 <- n2;
                n2 <- n3;
            }
            pool;
            n3;
            } fi fi;
        }
    };
};
    
(*
    Exercițiul 2.

    Pornind de la ierarhia de clase implementată la curs, aferentă listelor
    (găsiți clasele List și Cons mai jos), implementați următoarele funcții
    și testați-le. Este necesară definirea lor în clasa List și supradefinirea
    în clasa Cons.

    * append: întoarce o nouă listă rezultată prin concatenarea listei curente
        (self) cu lista dată ca parametru;
    * reverse: întoarce o nouă listă cu elementele în ordine inversă.
*)

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

    cons(h : Int) : Cons {
        new Cons.init(h, self)
    };

    print() : IO { out_string("\n") };

    reverse() : List {{abort(); self;}};

    append(l : List) : List {{abort(); self;}};

    map(m: Map) : List {{abort(); self;}};

    filter(f: Filter) : List {{abort(); self;}};
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

    init(h : Int, t : List) : Cons {
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

    reverse() : List {
        let newList : List <- new List,
            copy : List <- self
        in {
            while (not copy.isEmpty()) loop {
                newList <- newList.cons(copy.hd());
                copy <- copy.tl();
            } pool;
            newList;
        }
    };

    append(l : List) : List {
        let copy : List <- self,
            revCopy : List <- copy.reverse()
        in {
            while (not l.isEmpty()) loop {
                revCopy <- revCopy.cons(l.hd());
                l <- l.tl();
            } pool;
            revCopy.reverse();
        }
    };

    map(m: Map) : List {
        let copy : List <- self in m.apply(copy)
    };

    filter(f: Filter) : List {
        let copy : List <- self in f.apply(copy)
    };
};

(*
    Exercițiul 3.

    Scopul este implementarea unor mecanisme similare funcționalelor
    map și filter din limbajele funcționale. map aplică o funcție pe fiecare
    element, iar filter reține doar elementele care satisfac o anumită condiție.
    Ambele întorc o nouă listă.

    Definiți clasele schelet Map, respectiv Filter, care vor include unica
    metodă apply, având tipul potrivit în fiecare clasă, și implementare
    de formă.

    Pentru a defini o funcție utilă, care adună 1 la fiecare element al listei,
    definiți o subclasă a lui Map, cu implementarea corectă a metodei apply.

    În final, definiți în cadrul ierarhiei List-Cons o metodă map, care primește
    un parametru de tipul Map.

    Definiți o subclasă a subclasei de mai sus, care, pe lângă funcționalitatea
    existentă, de incrementare cu 1 a fiecărui element, contorizează intern
    și numărul de elemente prelucrate. Utilizați static dispatch pentru apelarea
    metodei de incrementare, deja definită.

    Repetați pentru clasa Filter, cu o implementare la alegere a metodei apply.
*)

class Map inherits Cons {
    apply(l : List) : List {{abort(); self;}};
};

class Filter inherits Cons {
    apply(l : List) : List {{abort(); self;}};
};

class MapAddOne inherits Map {
    apply(l : List) : List {
        let copy : List <- l,
            res : List <- new List,
            elem : Int <- 0
        in {
            while (not copy.isEmpty()) loop {
                elem <- copy.hd() + 1;
                res <- res.cons(elem);
                copy <- copy.tl();
            } pool;
            res.reverse();
        }
    };
};

class FilterMoreThanFive inherits Filter {
    apply(l : List) : List {
        let copy : List <- l,
            res : List <- new List,
            elem : Int <- 0
        in {
            while (not copy.isEmpty()) loop {
                elem <- copy.hd();
                if 4 < elem then res <- res.cons(elem) else res <- res fi;
                copy <- copy.tl();
            } pool;
            res.reverse();
        }
    };
};

-- Testați în main.
class Main inherits IO {


    main() : Object {

        let list : List <- new List.cons(1).cons(2).cons(3),
            temp : List <- list,
            list2 : List <- new List.cons(69).cons(420),
            mapping : Map <- new MapAddOne,
            filtering : Filter <- new FilterMoreThanFive
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
                
                out_string("Fibo recursive\n");
                out_int(new Fibo.fibo_rec(5));
                out_string("\n");
                out_string("Fibo iter\n");
                out_int(new Fibo.fibo_iter(5));
                out_string("\n");

                out_string("Reverse list\n");
                list.reverse().print();

                out_string("Append list\n");
                list2.print();
                list.append(list2).print();

                out_string("Map add with one\n");
                list.map(mapping).print();

                out_string("Filter positive\n");
                list.cons(10).cons(20).cons(6).filter(filtering).print();

            }
    };
};