with MIDI;
with Pico_Keys.Generator;

package Pico_Keys.Arpeggiator is

   subtype Parent is Generator.Instance;
   type Instance is new Parent with private;

   overriding
   procedure Play (This : in out Instance);

   overriding
   procedure Stop (This : in out Instance);

   overriding
   procedure Falling (This : in out Instance;
                      K    :        MIDI.MIDI_Key);

   overriding
   procedure Rising (This : in out Instance;
                     K    :        MIDI.MIDI_Key);

   overriding
   procedure No_Keys_Pressed (This : in out Instance);

   overriding
   procedure Enter_Focus (This : in out Instance);

   overriding
   procedure Leave_Focus (This : in out Instance);

   overriding
   procedure Enter_Func_Mode (This : in out Instance) is null;

   overriding
   procedure Trigger (This : in out Instance);

   overriding
   procedure Clear (This : in out Instance) ;

   function In_Arp (This : Instance;
                    K    : MIDI.MIDI_Key)
                    return Boolean;
   --  Return True if a key is part of the Arp sequence


   type Arp_Mode is (Up, Down, Up_N_Down, Order);

   function Mode (This : Instance) return Arp_Mode;
   procedure Next_Mode (This : in out Instance);


   type Oct_Range is range -2 .. 2;
   function Octave_Range (This : Instance) return Oct_Range;
   procedure Next_Octave_Range (This : in out Instance);
   procedure Prev_Octave_Range (This : in out Instance);

private

   type Key_Mask is array (MIDI.MIDI_Key) of Boolean;

   type Note_Index is range 0 .. 126;
   type Arp_Seq_Array is array (Note_Index) of MIDI.MIDI_Key;

   type Instance is new Parent with record
      Current_Mode : Arp_Mode := Arp_Mode'First;
      Waiting_For_Notes : Boolean := False;

      Next_Add : Note_Index := 0;
      Next_Index : Note_Index := 0;
      Arp_Seq : Arp_Seq_Array := (others => 0);

      Note_To_Turn_Off : MIDI.MIDI_Key := 0;
      Last_Note        : MIDI.MIDI_Key := 0;

      Notes_In_Arp : Key_Mask := (others => False);
      Going_Up : Boolean := True;

      Oct_Rng     : Oct_Range := 0;
      Current_Oct : Oct_Range := 0;
   end record;

   procedure Trig_Next_Oct (This : in out Instance);

end Pico_Keys.Arpeggiator;
