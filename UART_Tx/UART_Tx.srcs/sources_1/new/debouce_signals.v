`timescale 1ns / 1ps

module debounce_signals #(parameter threshold = 100000)(
    input clk,
    input btn,
    output reg transmit   // 1-cycle pulse on clean press
);

reg button_ff1 = 0;
reg button_ff2 = 0;
reg [30:0] count = 0;
reg stable_high = 0;
reg prev_stable = 0;

// Step 1: Synchronize
always @(posedge clk) begin
    button_ff1 <= btn;
    button_ff2 <= button_ff1;
end

// Step 2: Debounce
always @(posedge clk) begin
    if (button_ff2) begin
        if (~&count)
            count <= count + 1;
    end 
    else begin
        if (|count)
            count <= count - 1;
    end

    stable_high <= (count > threshold);
end

// Step 3: Generate 1-cycle pulse on rising edge of stable debounced signal
always @(posedge clk) begin
    transmit <= (stable_high && !prev_stable);
    prev_stable <= stable_high;
end

endmodule
