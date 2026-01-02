## Testbench sequence summary
The testbench performs multiple transactions:
1) Write 16-bit data (Data_Type=1) to Address_Pointer=0xEF with Data_In=0xABCD
2) Write 8-bit data (Data_Type=0)
3) Read 16-bit (R_W=1, Data_Type=1)
4) Read 8-bit (R_W=1, Data_Type=0)
...
Check waveforms under docs/images for timing and bus behavior.
