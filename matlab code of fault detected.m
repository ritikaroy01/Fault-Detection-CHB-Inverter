clc;
clear;
close all;

% Simulation Parameters
Vdc = 100;                 % DC voltage per H-Bridge
fs = 10e3;                 % Switching frequency (Hz)
Ts = 1/fs;                 % Time step
t_final = 0.05;            % Simulation time
t = 0:Ts:t_final;          % Time vector

% Carrier and Modulating Signal
fc = fs;                   % Carrier frequency
fm = 50;                   % Modulating frequency
Am = 1;                    % Amplitude of modulating signal
Ac = 1;                    % Amplitude of carrier signal

% Generate carriers for 5-level (4 carriers)
carrier = zeros(4, length(t));
for i = 1:4
    carrier(i,:) = Ac * sawtooth(2*pi*fc*t, 0.5) + (i-1)*0.5;  % Level-shifted carriers
end

% Modulating signal (sinusoidal)
mod_signal = Am * sin(2*pi*fm*t);

% LS-PWM comparison
gates = zeros(4, length(t));
for i = 1:4
    gates(i,:) = mod_signal >= carrier(i,:);
end

% Define H-Bridge outputs
S1 = gates(1,:);   S2 = ~gates(1,:);
S3 = gates(2,:);   S4 = ~gates(2,:);
S5 = gates(3,:);   S6 = ~gates(3,:);
S7 = gates(4,:);   S8 = ~gates(4,:);

% OC Fault Injection (e.g., S5 fails at 0.02s)
fault_time = 0.02;
S5(t >= fault_time) = 0;  % Open-circuit fault in S5

% Output voltage from each H-bridge
vo1 = Vdc*(S1 - S2);   % H-Bridge 1
vo2 = Vdc*(S3 - S4);   % H-Bridge 2
vo3 = Vdc*(S5 - S6);   % H-Bridge 3 (Faulty)
vo4 = Vdc*(S7 - S8);   % H-Bridge 4

% Cascaded output voltage
vo_total = vo1 + vo2 + vo3 + vo4;

% Fault detection logic (Deviation check)
expected_vo = vo1 + vo2 + Vdc*(gates(3,:) - ~gates(3,:)) + vo4;
error = abs(vo_total - expected_vo);
fault_detected = error > 0.1*Vdc;

% Plot results
figure;
subplot(3,1,1);
plot(t, vo_total, 'b'); title('Cascaded Output Voltage'); ylabel('V_o (V)');
grid on;

subplot(3,1,2);
plot(t, error, 'r'); title('Voltage Error for Fault Detection'); ylabel('Error (V)');
grid on;

subplot(3,1,3);
plot(t, fault_detected, 'k'); title('Fault Detection Flag'); xlabel('Time (s)');
ylim([-0.1 1.1]); ylabel('Fault');
grid on;
