connect

for {set i 0} {$i < 20} {incr i} {
  if { [ta] != "" } break;
  after 50
};

#Configuring the FPGA
targets -set -nocase -filter {name =~ "*PSU*"};
fpga "./trenz/image/linux/system.bit"; 
after 2000;

#disabling security gates on the Processing System Unit(PSU). 
mask_write 0xFFCA0038 0x1C0 0x1C0

#download the PMU Firmware
targets -set -nocase -filter {name =~ "*MicroBlaze PMU*"}
dow "./trenz/image/linux/pmufw.elf"
after 2000; 

#re-enable the security gates to prevent access to the MicroBlaze PMU 
targets -set -nocase -filter {name =~ "*PSU*"}
mask_write 0xFFCA0038 0x1C0 0x0

#release resets
targets -set -nocase -filter {name =~ "*APU*"}
mwr 0xffff0000 0x14000000
mask_write 0xFD1A0104 0x501 0x0
after 5000;

#initialize hardware
source ./trenz/image/linux/psu_init.tcl

#dowload fsbl
targets -set -nocase -filter {name =~ "*A53 #0*"}
dow "./trenz/image/linux/zynqmp_fsbl.elf"
after 2000;
con;
after 4000; stop;

#download device tree
targets -set -nocase -filter {name =~ "*A53 #0*"}
dow -data "./trenz/image/linux/system.dtb" 0x100000
after 2000;

#load u-boot (Ssbl)
targets -set -nocase -filter {name =~ "*A53 #0*"}
dow  "./trenz/image/linux/u-boot.elf"
after 2000;

targets -set -nocase -filter {name =~ "*A53 #0*"}
dow -data ./trenz/image/linux/boot.scr 0x20000000
after 2000;

#dowload ARM Trusted Firmware
targets -set -nocase -filter {name =~ "*A53 #0*"}
dow  "./trenz/image/linux/bl31.elf"
after 2000;
con;


