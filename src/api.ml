(* 
 * hardcaml - hardware design in OCaml
 *
 *   (c) 2014 MicroJamJar Ltd
 *
 * Author(s): andy.ray@ujamjar.com
 * Description: 
 *
 *)

(* Pre-build functors *)

module type S = sig
  module B : Comb.S
  module Cyclesim : module type of Cyclesim.Make(B)
  module Cosim : module type of Cosim.Make(B)
  module Gtkwave : module type of Vcd.Gtkwave(B) 
  module Vcd : module type of Vcd.Make(B)
  module Interface : sig
    module Gen : module type of Interface.Gen(B)
    module Gen_cosim : module type of Interface.Gen_cosim(B)
    module Sim : module type of Interface.Sim(B)
  end
  type bits = B.t
  type signal = Signal.Comb.t
end

module Make(Bits : Comb.S) = struct

  module B = Bits

  module Cyclesim = Cyclesim.Make(Bits)
  module Cosim = Cosim.Make(Bits)

  module Gtkwave = Vcd.Gtkwave(Bits)
  module Vcd = Vcd.Make(Bits)

  module Interface = struct
    module Gen = Interface.Gen(Bits)
    module Gen_cosim = Interface.Gen_cosim(Bits)
    module Sim = Interface.Sim(Bits)
  end

  type bits = B.t
  type signal = Signal.Comb.t
end

module Comb = Signal.Comb
module Seq = Signal.Seq
module Cs = Cyclesim.Api

include Make(Bits.Comb.IntbitsList)

