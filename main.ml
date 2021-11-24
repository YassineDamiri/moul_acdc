INCLUDE "correction/list_tools.ml"
INCLUDE "correction/gameOfLife.ml"


open Graphics ;;            (* Open the module *)
open_graph "";;             (* Open the window *)
open_graph " 300x100";;     (* Open 300w × 100h window *)


let load name =
    let ic = open_in name in
    let try_read () =
        try Some (input_line ic) with End_of_file -> None in
    let rec loop () = match try_read () with
    Some s -> s::(loop ())
    |None -> close_in ic; []
    in loop ();;

(*LOAD THE BOARD*)
let load_board filename =
    let file = load filename
  in
  let convert str =
      let size_str = String.length str in
      let rec conv_rec index =
          if index >= size_str then
              []
          else
              int_of_string (Char.escaped str.[index]) :: conv_rec (index+2)
      in conv_rec 0
      in
  let rec load_rec = function
      [] -> []
    |e::l -> (convert e) :: load_rec l
  in load_rec file;;

(*PRINT THE BOARD*)
let rec print_board board =
  if board = [] then
    ();
    let rec print_list = function
        [] -> ()
      | e::l -> print_int e ; print_string " " ; print_list l in
    if (List.length board) != 0 then
      let elt = List.hd board in
      print_list elt;
      Printf.printf "\n";
      print_board (List.tl board);;



(* Print a Matrix as follows [[a,b....,c],[a,b....,c],[a,b....,c]]*)
let print_matrix ch =
    let h = Array.length ch  in
    let w = Array.length ch.(0) in

    for i = 0 to h-1 do
        for j = 0 to w-1 do
            Printf.fprintf stdout "%i " ch.(i).(j);
            if (j == w-1) then
                Printf.fprintf stdout "\n";
        done;
    done;
  Printf.fprintf stdout "\n";;


(*PRINT THE IMAGE*)
let print_grid  x y w h =
    let current_image = get_image x y w h in
    let matrix = dump_image (current_image) in
    print_matrix matrix;
    clear_graph ();;



if Array.length Sys.argv != 7 then
    failwith "Not enought arguments. Usage : ./moulinette [FUNC NAME] [BOARD FILE] \
    [ARG1] [ARG2] [ARG3] [ARG4]" ;;

let function_name = Sys.argv.(1)

let filename = Sys.argv.(2)

let arg_1 = int_of_string (Sys.argv.(2));;
let arg_2 = int_of_string (Sys.argv.(3));;
let arg_3 = int_of_string (Sys.argv.(4));;
let arg_4 = int_of_string (Sys.argv.(5));;

try
with
    Timeout -> print_endline "Timeout on function";

INCLUDE "sandbox.ml"


