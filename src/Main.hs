module Main where

import Prelude hiding (id)
import Cpu (Cpu (..),CpuState (..), CpuFlags (carry, CpuFlags, auxCarry, zero, sign, parity))
import Web.Scotty ( get, json, jsonData, post, scotty, text )

main :: IO ()
main = do
  scotty 8080 $ do
    get "/status" $
      do
        text "Healthy"
    post "/api/v1/execute" $
      do
        cpu <- jsonData
        let updatedCpu = stc cpu
        json updatedCpu

stc :: Cpu -> Cpu
stc cpu = Cpu (opcode cpu) (id cpu) (CpuState (a s) (b s) (c s) (d s) (e s) (h s) (l s) (stackPointer s) (programCounter s) newCycles (CpuFlags (sign f) (zero f) (auxCarry f) (parity f) newCarry))
  where
    s = state cpu
    f = flags s
    newCycles = cycles s + 4
    newCarry = True
