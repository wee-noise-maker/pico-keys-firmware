with BBqueue.Buffers;

package body Pico_Keys.MIDI is

   --------------------------
   -- Push_To_Serial_Queue --
   --------------------------

   procedure Push_To_Serial_Queue (Msg : Message) is
      use BBqueue;
      use BBqueue.Buffers;

      WG : BBqueue.Buffers.Write_Grant;
   begin
      Grant (MIDI_Serial_Queue, WG, Size => 3);

      if State (WG) = Valid then
         declare
            Addr : constant System.Address := Slice (WG).Addr;
            Dst : Message with Import, Address => Addr;
         begin
            Dst := Msg;
         end;
         Commit (MIDI_Serial_Queue, WG);
      end if;
   end Push_To_Serial_Queue;

   ----------
   -- Send --
   ----------

   procedure Send (M : Message) is
   begin
      Push_To_Serial_Queue (M);
   end Send;

   ------------------
   -- Send_Note_On --
   ------------------

   procedure Send_Note_On (K    : MIDI_Key;
                           Chan : MIDI_Channel)
   is
   begin
      Send ((Note_On, Chan, K, MIDI_Data'Last));
   end Send_Note_On;

   -------------------
   -- Send_Note_Off --
   -------------------

   procedure Send_Note_Off (K    : MIDI_Key;
                            Chan : MIDI_Channel)
   is
   begin
      Send ((Note_Off, Chan, K, MIDI_Data'Last));
   end Send_Note_Off;

end Pico_Keys.MIDI;