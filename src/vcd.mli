(* 
 * hardcaml - hardware design in OCaml
 *
 *   (c) 2014 MicroJamJar Ltd
 *
 * Author(s): andy.ray@ujamjar.com
 * Description: 
 *
 *)

(** VCD file generation *)

(** Make vcd generator from a simulator *)
module Make(S : Comb.S) : sig

    open Signal.Types
    type t = S.t

    type cyclesim = t Cyclesim.Api.cyclesim

    (** wrap a simulator to generate a vcd file *)
    val wrap : (string->unit) -> cyclesim -> cyclesim

end 

(** Drive the gtkwave waveform viewer *)
module Gtkwave(S : Comb.S) : sig

    open Signal.Types
    type t = S.t

    type cyclesim = t Cyclesim.Api.cyclesim

    (** wrap a simulator to generate a vcd file *)
    val wrap : out_channel -> cyclesim -> cyclesim

    (** launch gtkwave to view the VCD output interactively *)
    val gtkwave : ?args:string -> cyclesim -> cyclesim

end 


