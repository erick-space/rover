catch {TE::UTILS::te_msg TE_BD-0 INFO "This block design tcl-file was generate with Trenz Electronic GmbH Board Part:trenz.biz:te0802_1eg_1e:part0:1.0, FPGA: xczu1eg-sbva484-1-e at 2023-06-26T14:20:25."}
catch {TE::UTILS::te_msg TE_BD-1 INFO "This block design tcl-file was modified by TE-Scripts. Modifications are labelled with comment tag  # #TE_MOD# on the Block-Design tcl-file."}

#if { ![info exist TE::VERSION_CONTROL] } {
#  namespace eval ::TE  {
#    set ::TE::VERSION_CONTROL true
#  }
#}
################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2024.2
set current_vivado_version [version -short ]
if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado < $scripts_vivado_version> and is being run in < $current_vivado_version> of Vivado. Please run the script in Vivado < $scripts_vivado_version> then open the design in Vivado < $current_vivado_version>. Upgrade the design by running "Tools => Report => Report IP Status...", then run write_bd_tcl to create an updated script."}
 return 1
}

################################################################
# This is a generated script based on design: zusys
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_gid_msg -ssname BD::TCL -id 2040 -severity "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source zusys_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu1eg-sbva484-1-e
   set_property BOARD_PART trenz.biz:te0802_1eg_1e:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name zusys

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
trenz.biz:user:axi_reg32:*\
trenz.biz:user:axis_audio_pwm:*\
trenz.biz:user:bcd7seg:*\
xilinx.com:ip:c_counter_binary:*\
xilinx.com:ip:jtag_axi:*\
trenz.biz:user:labtools_fmeter:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:util_reduced_logic:*\
xilinx.com:ip:util_vector_logic:*\
trenz.biz:user:vga_ctrl:*\
xilinx.com:ip:vio:*\
xilinx.com:ip:xlconcat:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:xlslice:*\
xilinx.com:ip:zynq_ultra_ps_e:*\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: digital_clock
proc create_hier_cell_digital_clock { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_digital_clock() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir O -from 15 -to 0 digits
  create_bd_pin -dir O -from 2 -to 0 up_points

  # Create instance: and2, and set properties
  set and2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and2 ]
  set_property CONFIG.C_SIZE {1} $and2


  # Create instance: and3, and set properties
  set and3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and3 ]
  set_property CONFIG.C_SIZE {1} $and3


  # Create instance: and4, and set properties
  set and4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and4 ]
  set_property CONFIG.C_SIZE {1} $and4


  # Create instance: and5, and set properties
  set and5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and5 ]
  set_property CONFIG.C_SIZE {1} $and5


  # Create instance: cycle_counter, and set properties
  set cycle_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary cycle_counter ]
  set_property -dict [list \
    CONFIG.Final_Count_Value {5F5E0FF} \
    CONFIG.Output_Width {27} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {5F5E0FF} \
  ] $cycle_counter


  # Create instance: hour_high_counter, and set properties
  set hour_high_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary hour_high_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {9} \
    CONFIG.Output_Width {4} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {false} \
  ] $hour_high_counter


  # Create instance: hour_low_counter, and set properties
  set hour_low_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary hour_low_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {9} \
    CONFIG.Output_Width {4} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {9} \
  ] $hour_low_counter


  # Create instance: low, and set properties
  set low [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant low ]
  set_property CONFIG.CONST_VAL {0} $low


  # Create instance: min_counter, and set properties
  set min_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary min_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {3B} \
    CONFIG.Output_Width {8} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {3B} \
  ] $min_counter


  # Create instance: min_high_counter, and set properties
  set min_high_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary min_high_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {5} \
    CONFIG.Output_Width {4} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {false} \
  ] $min_high_counter


  # Create instance: min_low_counter, and set properties
  set min_low_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary min_low_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {9} \
    CONFIG.Output_Width {4} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {9} \
  ] $min_low_counter


  # Create instance: sec_counter, and set properties
  set sec_counter [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary sec_counter ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {3B} \
    CONFIG.Output_Width {6} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {true} \
    CONFIG.Threshold_Value {3B} \
  ] $sec_counter


  # Create instance: sec_counter_ind, and set properties
  set sec_counter_ind [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary sec_counter_ind ]
  set_property -dict [list \
    CONFIG.CE {true} \
    CONFIG.Final_Count_Value {1} \
    CONFIG.Output_Width {1} \
    CONFIG.Restrict_Count {true} \
    CONFIG.Sync_Threshold_Output {false} \
  ] $sec_counter_ind


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {3} $xlconcat_0


  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_1 ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {4} \
    CONFIG.IN1_WIDTH {4} \
    CONFIG.IN2_WIDTH {4} \
    CONFIG.IN3_WIDTH {4} \
    CONFIG.NUM_PORTS {4} \
  ] $xlconcat_1


  # Create port connections
  connect_bd_net -net CLK_1 [get_bd_pins CLK] [get_bd_pins cycle_counter/CLK] [get_bd_pins hour_high_counter/CLK] [get_bd_pins hour_low_counter/CLK] [get_bd_pins min_counter/CLK] [get_bd_pins min_high_counter/CLK] [get_bd_pins min_low_counter/CLK] [get_bd_pins sec_counter/CLK] [get_bd_pins sec_counter_ind/CLK]
  connect_bd_net -net and3_Res [get_bd_pins and3/Res] [get_bd_pins and5/Op1] [get_bd_pins hour_low_counter/CE]
  connect_bd_net -net and4_Res [get_bd_pins and4/Res] [get_bd_pins min_high_counter/CE]
  connect_bd_net -net and5_Res [get_bd_pins and5/Res] [get_bd_pins hour_high_counter/CE]
  connect_bd_net -net cycle_counter_THRESH0 [get_bd_pins and2/Op1] [get_bd_pins cycle_counter/THRESH0] [get_bd_pins sec_counter/CE] [get_bd_pins sec_counter_ind/CE]
  connect_bd_net -net hour_high_counter_Q [get_bd_pins hour_high_counter/Q] [get_bd_pins xlconcat_1/In3]
  connect_bd_net -net hour_low_counter_Q [get_bd_pins hour_low_counter/Q] [get_bd_pins xlconcat_1/In2]
  connect_bd_net -net hour_low_counter_THRESH0 [get_bd_pins and5/Op2] [get_bd_pins hour_low_counter/THRESH0]
  connect_bd_net -net low_dout [get_bd_pins low/dout] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net min_counter_THRESH0 [get_bd_pins and3/Op2] [get_bd_pins min_counter/THRESH0]
  connect_bd_net -net min_high_counter_Q [get_bd_pins min_high_counter/Q] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net min_low_counter_Q [get_bd_pins min_low_counter/Q] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net min_low_counter_THRESH0 [get_bd_pins and4/Op2] [get_bd_pins min_low_counter/THRESH0]
  connect_bd_net -net sec_counter_THRESH0 [get_bd_pins and2/Op2] [get_bd_pins sec_counter/THRESH0]
  connect_bd_net -net sec_counter_ind_Q [get_bd_pins sec_counter_ind/Q] [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins and2/Res] [get_bd_pins and3/Op1] [get_bd_pins and4/Op1] [get_bd_pins min_counter/CE] [get_bd_pins min_low_counter/CE]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins up_points] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins digits] [get_bd_pins xlconcat_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set CLK_25MHZ [ create_bd_port -dir I -type clk -freq_hz 25000000 CLK_25MHZ ]
  set LED [ create_bd_port -dir O -from 7 -to 0 LED ]
  set PWM_L [ create_bd_port -dir O PWM_L ]
  set PWM_R [ create_bd_port -dir O PWM_R ]
  set SEG_AN [ create_bd_port -dir O -from 4 -to 0 SEG_AN ]
  set SEG_C [ create_bd_port -dir O -from 7 -to 0 SEG_C ]
  set USER_BTN_DOWN [ create_bd_port -dir I USER_BTN_DOWN ]
  set USER_BTN_LEFT [ create_bd_port -dir I USER_BTN_LEFT ]
  set USER_BTN_OK [ create_bd_port -dir I USER_BTN_OK ]
  set USER_BTN_RIGHT [ create_bd_port -dir I USER_BTN_RIGHT ]
  set USER_BTN_UP [ create_bd_port -dir I USER_BTN_UP ]
  set USER_SW [ create_bd_port -dir I -from 7 -to 0 USER_SW ]
  set VGA_B [ create_bd_port -dir O -from 3 -to 0 VGA_B ]
  set VGA_G [ create_bd_port -dir O -from 3 -to 0 VGA_G ]
  set VGA_HS [ create_bd_port -dir O -from 0 -to 0 VGA_HS ]
  set VGA_R [ create_bd_port -dir O -from 3 -to 0 VGA_R ]
  set VGA_VS [ create_bd_port -dir O -from 0 -to 0 VGA_VS ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {2} \
  ] $axi_interconnect_0


  # Create instance: axi_reg32_0, and set properties
  set axi_reg32_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:axi_reg32 axi_reg32_0 ]
  set_property -dict [list \
    CONFIG.C_NUM_RO_REG {1} \
    CONFIG.C_NUM_WR_REG {0} \
  ] $axi_reg32_0


  # Create instance: axis_audio_pwm_0, and set properties
  set axis_audio_pwm_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:axis_audio_pwm axis_audio_pwm_0 ]
  set_property -dict [list \
    CONFIG.C_MODE {1} \
    CONFIG.C_SYS_FREQ {25000000} \
  ] $axis_audio_pwm_0


  # Create instance: bcd7seg_0, and set properties
  set bcd7seg_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:bcd7seg bcd7seg_0 ]
  set_property CONFIG.CLK_DIVISOR {200000} $bcd7seg_0


  # Create instance: c_counter_binary_0, and set properties
  set c_counter_binary_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_counter_binary c_counter_binary_0 ]
  set_property -dict [list \
    CONFIG.Load {true} \
    CONFIG.Output_Width {32} \
  ] $c_counter_binary_0


  # Create instance: digital_clock
  create_hier_cell_digital_clock [current_bd_instance .] digital_clock

  # Create instance: jtag_axi_0, and set properties
  set jtag_axi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi jtag_axi_0 ]

  # Create instance: labtools_fmeter_0, and set properties
  set labtools_fmeter_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:labtools_fmeter labtools_fmeter_0 ]
  set_property CONFIG.C_CHANNELS {1} $labtools_fmeter_0


  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0 ]

  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic util_reduced_logic_0 ]
  set_property CONFIG.C_SIZE {5} $util_reduced_logic_0


  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {5} \
  ] $util_vector_logic_0


  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_1 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {8} \
  ] $util_vector_logic_1


  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic util_vector_logic_2 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_2


  # Create instance: vga_ctrl_0, and set properties
  set vga_ctrl_0 [ create_bd_cell -type ip -vlnv trenz.biz:user:vga_ctrl vga_ctrl_0 ]

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio vio_0 ]
  set_property CONFIG.C_NUM_PROBE_OUT {0} $vio_0


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {5} $xlconcat_0


  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_1 ]
  set_property -dict [list \
    CONFIG.IN0_WIDTH {24} \
    CONFIG.IN1_WIDTH {8} \
  ] $xlconcat_1


  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {24} \
  ] $xlconstant_0


  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {31} \
    CONFIG.DIN_TO {24} \
    CONFIG.DOUT_WIDTH {8} \
  ] $xlslice_0


  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e_0 ]
# #TE_MOD#_Add next line#
  apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
# #TE_MOD#_Add next line#
  set tcl_pr_ext [];if { [catch {set tcl_pr_ext [glob -join -dir ${TE::BOARDDEF_PATH}/preset_extension/ *_preset.tcl]}] } {};foreach preset_ext $tcl_pr_ext { source  $preset_ext};
# #TE_MOD#   set_property -dict [list \
# #TE_MOD#   ] $zynq_ultra_ps_e_0

# #TE_MOD#     CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS33} \
# #TE_MOD#     CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS33} \
# #TE_MOD#     CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
# #TE_MOD#     CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS33} \
# #TE_MOD#     CONFIG.PSU_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
# #TE_MOD#     CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x00000002} \
# #TE_MOD#     CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x40000000} \
# #TE_MOD#     CONFIG.PSU_MIO_12_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_13_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_13_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_14_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_14_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_15_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_15_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_16_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_16_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_17_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_20_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_21_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_21_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_22_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_23_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_24_INPUT_TYPE {cmos} \
# #TE_MOD#     CONFIG.PSU_MIO_24_PULLUPDOWN {disable} \
# #TE_MOD#     CONFIG.PSU_MIO_25_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_26_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_28_PULLUPDOWN {pulldown} \
# #TE_MOD#     CONFIG.PSU_MIO_32_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_33_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_34_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_35_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_36_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_37_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_38_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_39_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_40_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_41_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_42_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_43_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_44_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_45_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_46_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_47_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_48_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_49_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_50_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_51_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_7_POLARITY {Default} \
# #TE_MOD#     CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#GPIO0 MIO#I2C 1#I2C 1#UART 0#UART 0#GPIO0 MIO#SD 0#SD 0#SD 0#SD\
# #TE_MOD# 0#GPIO0 MIO#I2C 0#I2C 0#GPIO0 MIO#SD 0#SD 0#GPIO0 MIO#SD 0#GPIO0 MIO#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#PCIE#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1\
# #TE_MOD# MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem\
# #TE_MOD# 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
# #TE_MOD#     CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#gpio0[7]#scl_out#sda_out#rxd#txd#gpio0[12]#sdio0_data_out[0]#sdio0_data_out[1]#sdio0_data_out[2]#sdio0_data_out[3]#gpio0[17]#scl_out#sda_out#gpio0[20]#sdio0_cmd_out#sdio0_clk_out#gpio0[23]#sdio0_cd_n#gpio0[25]#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#reset_n#gpio1[32]#gpio1[33]#gpio1[34]#gpio1[35]#gpio1[36]#gpio1[37]#gpio1[38]#gpio1[39]#gpio1[40]#gpio1[41]#gpio1[42]#gpio1[43]#gpio1[44]#gpio1[45]#gpio1[46]#gpio1[47]#gpio1[48]#gpio1[49]#gpio1[50]#gpio1[51]#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out}\
# #TE_MOD# \
# #TE_MOD#     CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {4} \
# #TE_MOD#     CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__ACT_DDR_FREQ_MHZ {342.857147} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1200.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {171.428574} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {350} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {25.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.785715} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {300.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {600.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {400.000000} \
# #TE_MOD#     CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {APLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {500.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {50.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {500.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1500.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {125.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {500.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.500000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {62.500000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {65} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {300.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {187.500000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {33.333332} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {250.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {20.000000} \
# #TE_MOD#     CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__DDRC__ADDR_MIRROR {1} \
# #TE_MOD#     CONFIG.PSU__DDRC__BUS_WIDTH {32 Bit} \
# #TE_MOD#     CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
# #TE_MOD#     CONFIG.PSU__DDRC__DM_DBI {NO_DM_NO_DBI} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__DRAM_WIDTH {32 Bits} \
# #TE_MOD#     CONFIG.PSU__DDRC__ECC {Disabled} \
# #TE_MOD#     CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
# #TE_MOD#     CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {High (95 Max)} \
# #TE_MOD#     CONFIG.PSU__DDRC__MEMORY_TYPE {LPDDR 4} \
# #TE_MOD#     CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
# #TE_MOD#     CONFIG.PSU__DDRC__SPEED_BIN {LPDDR4_1066} \
# #TE_MOD#     CONFIG.PSU__DDRC__T_FAW {40.0} \
# #TE_MOD#     CONFIG.PSU__DDRC__T_RAS_MIN {42} \
# #TE_MOD#     CONFIG.PSU__DDRC__T_RC {63} \
# #TE_MOD#     CONFIG.PSU__DDRC__T_RCD {10} \
# #TE_MOD#     CONFIG.PSU__DDRC__T_RP {12} \
# #TE_MOD#     CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
# #TE_MOD#     CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__DDR__INTERFACE__FREQMHZ {175.000} \
# #TE_MOD#     CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane3} \
# #TE_MOD#     CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane2} \
# #TE_MOD#     CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__DLL__ISUSED {1} \
# #TE_MOD#     CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
# #TE_MOD#     CONFIG.PSU__DP__LANE_SEL {Dual Higher} \
# #TE_MOD#     CONFIG.PSU__DP__REF_CLK_FREQ {27} \
# #TE_MOD#     CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk2} \
# #TE_MOD#     CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
# #TE_MOD#     CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
# #TE_MOD#     CONFIG.PSU__ENET3__PTP__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__ENET3__TSU__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
# #TE_MOD#     CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__FPGA_PL1_ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__GEM3_COHERENCY {0} \
# #TE_MOD#     CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
# #TE_MOD#     CONFIG.PSU__GEM__TSU__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
# #TE_MOD#     CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
# #TE_MOD#     CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__GPIO2_MIO__IO {MIO 52 .. 77} \
# #TE_MOD#     CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__GT__LINK_SPEED {HBR} \
# #TE_MOD#     CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
# #TE_MOD#     CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
# #TE_MOD#     CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 18 .. 19} \
# #TE_MOD#     CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 8 .. 9} \
# #TE_MOD#     CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {100.000000} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR0_ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR0_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR1_ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR1_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR2_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR3_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR4_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__BAR5_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \
# #TE_MOD#     CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x04} \
# #TE_MOD#     CONFIG.PSU__PCIE__CLASS_CODE_VALUE {0x60400} \
# #TE_MOD#     CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \
# #TE_MOD#     CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {Root Port} \
# #TE_MOD#     CONFIG.PSU__PCIE__EROM_ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__EROM_VAL {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__LANE0__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__PCIE__LANE0__IO {GT Lane0} \
# #TE_MOD#     CONFIG.PSU__PCIE__LANE1__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__LANE2__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__LANE3__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__LINK_SPEED {5.0 Gb/s} \
# #TE_MOD#     CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {x1} \
# #TE_MOD#     CONFIG.PSU__PCIE__MAX_PAYLOAD_SIZE {256 bytes} \
# #TE_MOD#     CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {MIO 31} \
# #TE_MOD#     CONFIG.PSU__PCIE__REF_CLK_FREQ {100} \
# #TE_MOD#     CONFIG.PSU__PCIE__REF_CLK_SEL {Ref Clk0} \
# #TE_MOD#     CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
# #TE_MOD#     CONFIG.PSU__PCIE__REVISION_ID {0x0} \
# #TE_MOD#     CONFIG.PSU__PCIE__SUBSYSTEM_ID {0x7} \
# #TE_MOD#     CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {0x10EE} \
# #TE_MOD#     CONFIG.PSU__PCIE__VENDOR_ID {0x10EE} \
# #TE_MOD#     CONFIG.PSU__PL_CLK1_BUF {TRUE} \
# #TE_MOD#     CONFIG.PSU__PRESET_APPLIED {1} \
# #TE_MOD#     CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;0|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;0|SD0:NonSecure;1|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;1|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1}\
# #TE_MOD# \
# #TE_MOD#     CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;0|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;1|FPD;PCIE_LOW;E0000000;EFFFFFFF;1|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;1|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;1|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;1|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;1|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display\
# #TE_MOD# Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;3FFFFFFF;1|DDR;DDR_HIGH;800000000;800000000;0|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1}\
# #TE_MOD# \
# #TE_MOD#     CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.3333333} \
# #TE_MOD#     CONFIG.PSU__QSPI_COHERENCY {0} \
# #TE_MOD#     CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
# #TE_MOD#     CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
# #TE_MOD#     CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
# #TE_MOD#     CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 5} \
# #TE_MOD#     CONFIG.PSU__QSPI__PERIPHERAL__MODE {Single} \
# #TE_MOD#     CONFIG.PSU__SD0_COHERENCY {0} \
# #TE_MOD#     CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
# #TE_MOD#     CONFIG.PSU__SD0__CLK_50_SDR_ITAP_DLY {0x15} \
# #TE_MOD#     CONFIG.PSU__SD0__CLK_50_SDR_OTAP_DLY {0x5} \
# #TE_MOD#     CONFIG.PSU__SD0__DATA_TRANSFER_MODE {4Bit} \
# #TE_MOD#     CONFIG.PSU__SD0__GRP_CD__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__SD0__GRP_CD__IO {MIO 24} \
# #TE_MOD#     CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 16 21 22} \
# #TE_MOD#     CONFIG.PSU__SD0__SLOT_TYPE {SD 2.0} \
# #TE_MOD#     CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
# #TE_MOD#     CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__UART0__BAUD_RATE {115200} \
# #TE_MOD#     CONFIG.PSU__UART0__MODEM__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 10 .. 11} \
# #TE_MOD#     CONFIG.PSU__USB0_COHERENCY {0} \
# #TE_MOD#     CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
# #TE_MOD#     CONFIG.PSU__USB0__REF_CLK_FREQ {100} \
# #TE_MOD#     CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk0} \
# #TE_MOD#     CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
# #TE_MOD#     CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
# #TE_MOD#     CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane1} \
# #TE_MOD#     CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
# #TE_MOD#     CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
# #TE_MOD#     CONFIG.PSU__USE__AUDIO {1} \
# #TE_MOD# #Empty Line

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins jtag_axi_0/M_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins axi_reg32_0/S_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXIS_MIXED_AUDIO [get_bd_intf_pins axis_audio_pwm_0/S00_AXIS] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXIS_MIXED_AUDIO]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_LPD [get_bd_intf_pins axi_interconnect_0/S01_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net CLK_25MHZ_1 [get_bd_ports CLK_25MHZ] [get_bd_pins labtools_fmeter_0/fin]
  connect_bd_net -net S01_ARESETN_1 [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_reg32_0/s_axi_aresetn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net USER_BTN_DOWN_1 [get_bd_ports USER_BTN_DOWN] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net USER_BTN_LEFT_1 [get_bd_ports USER_BTN_LEFT] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net USER_BTN_OK_1 [get_bd_ports USER_BTN_OK] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net USER_BTN_RIGHT_1 [get_bd_ports USER_BTN_RIGHT] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net USER_BTN_UP_1 [get_bd_ports USER_BTN_UP] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net USER_SW_1 [get_bd_ports USER_SW] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axis_audio_pwm_0_pwm_l_out [get_bd_ports PWM_L] [get_bd_pins axis_audio_pwm_0/pwm_l_out]
  connect_bd_net -net axis_audio_pwm_0_pwm_r_out [get_bd_ports PWM_R] [get_bd_pins axis_audio_pwm_0/pwm_r_out]
  connect_bd_net -net bcd7seg_0_A [get_bd_pins bcd7seg_0/A] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net bcd7seg_0_C [get_bd_pins bcd7seg_0/C] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net c_counter_binary_0_Q [get_bd_pins c_counter_binary_0/Q] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net digital_clock_digits [get_bd_pins bcd7seg_0/D] [get_bd_pins digital_clock/digits]
  connect_bd_net -net digital_clock_up_points [get_bd_pins bcd7seg_0/L] [get_bd_pins digital_clock/up_points]
  connect_bd_net -net labtools_fmeter_0_F0 [get_bd_pins axi_reg32_0/RR0] [get_bd_pins labtools_fmeter_0/F0] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins util_reduced_logic_0/Res] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_ports SEG_AN] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_ports SEG_C] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins c_counter_binary_0/LOAD] [get_bd_pins util_vector_logic_2/Res]
  connect_bd_net -net vga_ctrl_0_blue_out [get_bd_ports VGA_B] [get_bd_pins vga_ctrl_0/blue_out]
  connect_bd_net -net vga_ctrl_0_green_out [get_bd_ports VGA_G] [get_bd_pins vga_ctrl_0/green_out]
  connect_bd_net -net vga_ctrl_0_h_sync [get_bd_ports VGA_HS] [get_bd_pins vga_ctrl_0/h_sync]
  connect_bd_net -net vga_ctrl_0_red_out [get_bd_ports VGA_R] [get_bd_pins vga_ctrl_0/red_out]
  connect_bd_net -net vga_ctrl_0_v_sync [get_bd_ports VGA_VS] [get_bd_pins vga_ctrl_0/v_sync]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins util_reduced_logic_0/Op1] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins c_counter_binary_0/L] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_1/In0] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_ports LED] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net zynq_ultra_ps_e_0_dp_audio_ref_clk [get_bd_pins axis_audio_pwm_0/s00_axis_aclk] [get_bd_pins zynq_ultra_ps_e_0/dp_audio_ref_clk] [get_bd_pins zynq_ultra_ps_e_0/dp_s_axis_audio_clk]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_reg32_0/s_axi_aclk] [get_bd_pins bcd7seg_0/clk] [get_bd_pins c_counter_binary_0/CLK] [get_bd_pins digital_clock/CLK] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins labtools_fmeter_0/refclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins vio_0/clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk1 [get_bd_pins vga_ctrl_0/pixel_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk1]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins vga_ctrl_0/reset_n] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  assign_bd_address -offset 0x80000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs axi_reg32_0/S_AXI/S_AXI_reg] -force
  assign_bd_address -offset 0x80000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_reg32_0/S_AXI/S_AXI_reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



