---------------------
----- FUNCTIONS -----
---------------------
-- define function
def joinStringsWith (first second third : String) : String
:= String.append second (String.append first third)

-- checks function's signature
#check joinStringsWith
-- chceks function evaluation
#check (joinStringsWith)
-- evaluates statement
#eval joinStringsWith "," "one" " and other"


-----------------
----- TYPES -----
-----------------
-- define new Type
def Str : Type := String
-- usage of new Type - Str
def aStr : Str := "This is a string."

-- Type definition error due to numbers overloading
def NaturalNumber : Type := Nat
--def thirtyEight : NaturalNumber := 38  -- leads to error
-- How to handle:
def thirtyEight : NaturalNumber := (38 : Nat)
-- or use abbrev
abbrev N : Type := Nat
def thirtyNine : N := 39


----------------------
----- STRUCTURES -----
----------------------
structure Point where
  x : Float
  y : Float

def origin : Point := { x := 0.0, y := 0.0 }
#eval origin
#eval origin.x
#eval origin.y

-- structures can be used as a params types
def addPoints (p1 : Point) (p2 : Point) : Point :=
  { x := p1.x + p2.x, y := p1.y + p2.y }
#eval addPoints { x := 1.5, y := 32 } { x := -8, y := 0.2 }

-- one more example with structures
def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p2.x - p1.x) ^ 2.0) + ((p2.y - p1.y) ^ 2.0))
#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }

-- Updating the stractures
-- we need to create a function to set x value of a Point to 0
-- not a good way to do it:
def zeroX_wrong (p : Point) : Point :=
  { x := 0, y := p.y }

-- how to do it correctly (using 'with' keyword):
-- creates new Point with x := 0 based on p
def zeroX (p : Point) : Point :=
  { p with x := 0 }

-- structure constructors
#check (Point.mk)
-- to override constructor name
structure Point_ where
  point ::
  x : Float
  y : Float

-- structure accessors
#eval "one string".append " and another"


----------------------
------ Datatypes -----
----------------------
inductive Bool_ where
  | false : Bool_
  | true : Bool_

def isZero (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => false

#eval Nat.succ 5

-- define function for even
def even (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (even k)


----------------------
--- Polymorphism -----
----------------------
-- Polymorphic in sense that it can use any type
-- A polymorphic version of Point
structure PPoint (α : Type) where
  x : α
  y : α

  def natOrigin : PPoint Nat :=
  { x := Nat.zero, y := Nat.zero }

--o work with any polymorphic point, it must be polymorphic itself
  def replaceX (α : Type) (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX }

  -- Linked Lists
  -- following lists are the same
  def primesUnder10 : List Nat := [2, 3, 5, 7]
  def explicitPrimesUnder10 : List Nat :=
  List.cons 2 (List.cons 3 (List.cons 5 (List.cons 7 List.nil)))

  -- example of the function length
  def length (α : Type) (xs : List α) : Nat :=
  match xs with
  | List.nil => Nat.zero
  | List.cons y ys => Nat.succ (length α ys)
  -- amother example
  def length_ (α : Type) (xs : List α) : Nat :=
  match xs with
  | [] => 0
  | y :: ys => Nat.succ (length α ys)

  -- implicit arguments
  def replaceX_ {α : Type} (point : PPoint α) (newX : α) : PPoint α :=
  { point with x := newX }
  #eval replaceX_ natOrigin 5

  #eval primesUnder10.head?
  --#eval [].head? -- provides errors
  #eval [].head? (α := Int)
