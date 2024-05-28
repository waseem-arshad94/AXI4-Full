
################################################################
# This is a generated script based on design: axi4_block
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
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source axi4_block_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# axi4_master, axi4_slave

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx485tffg1157-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name axi4_block

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
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

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

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



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
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set m_axi_aclk_0 [ create_bd_port -dir I -type clk m_axi_aclk_0 ]
  set m_axi_aresetn_0 [ create_bd_port -dir I -type rst m_axi_aresetn_0 ]
  set read_0 [ create_bd_port -dir I read_0 ]
  set read_address_0 [ create_bd_port -dir I -from 23 -to 0 read_address_0 ]
  set read_burstlen_0 [ create_bd_port -dir I -from 7 -to 0 read_burstlen_0 ]
  set read_data_0 [ create_bd_port -dir O -from 31 -to 0 read_data_0 ]
  set write_0 [ create_bd_port -dir I write_0 ]
  set write_address_0 [ create_bd_port -dir I -from 23 -to 0 write_address_0 ]
  set write_burstlen_0 [ create_bd_port -dir I -from 7 -to 0 write_burstlen_0 ]
  set write_data_0 [ create_bd_port -dir I -from 31 -to 0 write_data_0 ]

  # Create instance: axi4_master_0, and set properties
  set block_name axi4_master
  set block_cell_name axi4_master_0
  if { [catch {set axi4_master_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi4_master_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi4_slave_0, and set properties
  set block_name axi4_slave
  set block_cell_name axi4_slave_0
  if { [catch {set axi4_slave_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi4_slave_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_protocol_checker_0, and set properties
  set axi_protocol_checker_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_checker:2.0 axi_protocol_checker_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi4_master_0_m_axi [get_bd_intf_pins axi4_master_0/m_axi] [get_bd_intf_pins axi4_slave_0/s_axi]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi4_master_0_m_axi] [get_bd_intf_pins axi4_master_0/m_axi] [get_bd_intf_pins axi_protocol_checker_0/PC_AXI]

  # Create port connections
  connect_bd_net -net axi4_master_0_read_data [get_bd_ports read_data_0] [get_bd_pins axi4_master_0/read_data]
  connect_bd_net -net m_axi_aclk_0_1 [get_bd_ports m_axi_aclk_0] [get_bd_pins axi4_master_0/m_axi_aclk] [get_bd_pins axi4_slave_0/s_axi_aclk] [get_bd_pins axi_protocol_checker_0/aclk]
  connect_bd_net -net m_axi_aresetn_0_1 [get_bd_ports m_axi_aresetn_0] [get_bd_pins axi4_master_0/m_axi_aresetn] [get_bd_pins axi4_slave_0/s_axi_aresetn] [get_bd_pins axi_protocol_checker_0/aresetn]
  connect_bd_net -net read_0_1 [get_bd_ports read_0] [get_bd_pins axi4_master_0/read]
  connect_bd_net -net read_address_0_1 [get_bd_ports read_address_0] [get_bd_pins axi4_master_0/read_address]
  connect_bd_net -net read_burstlen_0_1 [get_bd_ports read_burstlen_0] [get_bd_pins axi4_master_0/read_burstlen]
  connect_bd_net -net write_0_1 [get_bd_ports write_0] [get_bd_pins axi4_master_0/write]
  connect_bd_net -net write_address_0_1 [get_bd_ports write_address_0] [get_bd_pins axi4_master_0/write_address]
  connect_bd_net -net write_burstlen_0_1 [get_bd_ports write_burstlen_0] [get_bd_pins axi4_master_0/write_burstlen]
  connect_bd_net -net write_data_0_1 [get_bd_ports write_data_0] [get_bd_pins axi4_master_0/write_data]

  # Create address segments


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


