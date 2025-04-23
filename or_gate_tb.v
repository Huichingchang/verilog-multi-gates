`timescale 1ns/1ps

module or_gate_tb;
    reg a, b;
    wire y;
    integer f;

    // 宣告 DUT
    or_gate uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // 嘗試打開文字檔
        f = $fopen("monitor_log.txt", "w");
        if (f == 0) begin
            $display("❌ Failed to open monitor_log.txt");
            $finish;
        end else begin
            $display("✅ File opened.");
        end

        // 加入 VCD 波形檔輸出
        $dumpfile("or_gate.vcd");
        $dumpvars(0, or_gate_tb);

        // 測試序列 + 手動寫入
        a = 0; b = 0; #10;
        $fwrite(f, "a=%b, b=%b, y=%b @ %0t ns\n", a, b, y, $time);

        a = 0; b = 1; #10;
        $fwrite(f, "a=%b, b=%b, y=%b @ %0t ns\n", a, b, y, $time);

        a = 1; b = 0; #10;
        $fwrite(f, "a=%b, b=%b, y=%b @ %0t ns\n", a, b, y, $time);

        a = 1; b = 1; #10;
        $fwrite(f, "a=%b, b=%b, y=%b @ %0t ns\n", a, b, y, $time);

        #10;

        $fclose(f);
        $display("✅ Done writing to file.");
        $finish;
    end
endmodule
