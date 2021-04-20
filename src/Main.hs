module Main where

import Cpu (Cpu (..),CpuState (..), CpuFlags (carry, CpuFlags, auxCarry, zero, sign, parity))
import Web.Scotty ( json, jsonData, post, scotty )

main :: IO ()
main = do
  scotty 8080 $ do
    post "/api/v1/execute" $
      do
        cpu <- jsonData
        let updatedCpu = stc cpu
        json updatedCpu

stc :: Cpu -> Cpu
stc cpu = Cpu (opcode cpu) (CpuState (a s) (b s) (c s) (d s) (e s) (h s) (l s) (stackPointer s) (programCounter s) newCycles (CpuFlags (sign f) (zero f) (auxCarry f) (parity f) newCarry))
  where
    s = state cpu
    f = flags s
    newCycles = cycles s + 1
    newCarry = True
