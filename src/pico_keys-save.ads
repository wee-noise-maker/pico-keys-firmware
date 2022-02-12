with Pico_Keys.Generator_Instances;
with Pico_Keys.Meta_Gen;

package Pico_Keys.Save is

   type Gen_Array is array (Gen_Id) of Pico_Keys.Meta_Gen.Instance;

   type Save_State is record
      Valid      : Boolean := False;
      BPM        : Natural := 120;
      Generators : Gen_Array;
   end record;

   RAM_State : Save_State;

   procedure Save_To_Flash;

   procedure Load_From_Flash;

private
   Flash_State : Save_State
     with Linker_Section => ".save_data";


end Pico_keys.Save;