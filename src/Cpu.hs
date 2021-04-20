module Cpu where

import Data.Aeson ( FromJSON, ToJSON )
import Data.Word (Word8, Word16)
import GHC.Generics ( Generic )

data CpuFlags = CpuFlags
  { sign :: Bool,
    zero :: Bool,
    auxCarry :: Bool,
    parity :: Bool,
    carry :: Bool
  }
  deriving (Generic)

data CpuState = CpuState
  { a :: Word8,
    b :: Word8,
    c :: Word8,
    d :: Word8,
    e :: Word8,
    h :: Word8,
    l :: Word8,
    stackPointer :: Word16,
    programCounter :: Word16,
    cycles :: Integer,
    flags :: CpuFlags
  }
  deriving (Generic)

data Cpu = Cpu
  { opcode :: Word8,
    state :: CpuState
  }
  deriving (Generic)

instance FromJSON CpuFlags
instance FromJSON CpuState
instance FromJSON Cpu
instance ToJSON CpuFlags
instance ToJSON CpuState
instance ToJSON Cpu