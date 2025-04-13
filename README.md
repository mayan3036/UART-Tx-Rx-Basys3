# UART Transmitter and Receiver on Basys 3 FPGA using Verilog

This project implements **UART (Universal Asynchronous Receiver-Transmitter)** communication on the **Basys 3 FPGA** development board using **Verilog**. It includes separate modules for **transmitting** and **receiving** serial data, facilitating communication between the FPGA and a PC via the **USB-UART** interface. Communication is verified using the **Tera Term** serial terminal.

---

## 🔧 Features

### UART Transmitter
- Converts **switch inputs** into **ASCII characters**
- Transmits **8-bit data** serially over the TxD line
- Transmission initiated by a **debounced push button**
- **Baud rate:** 9600 bps

### UART Receiver
- Receives serial data from the PC via the RxD line
- Displays received **ASCII characters on 8 onboard LEDs**
- Uses **oversampling technique** for accurate reception
- **Baud rate:** 9600 bps

---

## 🛠️ Development Workflow

1. **Design Modules**
   - Implement separate Verilog modules for UART TX and RX
   - Add a **debounce module** in the **transmitter design** to stabilize button press

2. **Configure Constraints**
   - Edit the `.xdc` file to assign correct pins for **LEDs, switches, buttons**, and **UART lines**

3. **Run Flow in Vivado**
   - Perform **Synthesis**, **Implementation**, and **Bitstream Generation**

4. **Program the FPGA**
   - Connect the **Basys 3 board** via USB
   - Use **Vivado Hardware Manager** to upload the `.bit` file

5. **Test via Tera Term**
   - **For Transmitter:**
     - Set switches for desired ASCII input
     - Press button to send data
     - View transmitted character on Tera Term
   - **For Receiver:**
     - Type characters in Tera Term
     - Observe **LED pattern** for received character on FPGA board

---

## 🧪 Tools and Technologies

- **Hardware**
  - Basys 3 FPGA Development Board (Xilinx Artix-7)
  - USB-UART Interface

- **Software**
  - Xilinx Vivado
  - Tera Term

- **Language**
  - Verilog HDL

---

## 📚 References

- [UART Transmitter - Instructables](https://www.instructables.com/UART-Communication-on-Basys-3-FPGA-Dev-Board-Power/)
- [UART Receiver - Instructables](https://www.instructables.com/UART-Communication-on-Basys-3-FPGA-Dev-Board-Power-1/)
