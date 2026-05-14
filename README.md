Robust Drone Altitude Stabilization using PID Control under Wind Disturbances

Problem Statement

Drone altitude becomes unstable when external disturbances such as wind gusts affect the system. The objective of this project is to design and implement a PID-based control system capable of stabilizing the drone altitude while maintaining smooth and reliable response characteristics.

The system must:

Reduce oscillations

Improve stability

Minimize overshoot

Reduce settling time

Reject disturbances effectively

---

Objective

The primary objective of this project is to design a closed-loop PID controller for drone altitude stabilization.

The controller dynamically adjusts the drone thrust to:

Maintain stable hovering

Improve transient response

Reduce oscillatory behavior

Handle external wind disturbances

Maintain robustness under sensor noise conditions

---

System Model

The vertical dynamics of the drone are represented using the following transfer function:

G(s) = 1 / (s² + 2s + 5)

Where:

Input  : Thrust command

Output : Drone altitude


This second-order system exhibits oscillatory behavior in open-loop condition.

---

Control Technique Used

A PID (Proportional–Integral–Derivative) controller was implemented to improve system performance.

The PID controller continuously calculates the altitude error and adjusts the drone thrust accordingly.

PID Controller Equation:

u(t) = Kp*e(t) + Ki∫e(t)dt + Kd(de/dt)

Where:

Kp = Proportional Gain

Ki = Integral Gain

Kd = Derivative Gain


Final Tuned PID Parameters:

Kp = 25

Ki = 8

Kd = 6

---

Software Used

GNU Octave (MATLAB-compatible environment)

Scilab/Xcos (Simulink-style block modelling)

---

Features Implemented

This project includes:

Open-loop response analysis

Closed-loop PID stabilization

Wind disturbance simulation

Motor thrust adjustment analysis

Sensor noise simulation

Open-loop vs closed-loop comparison

Simulink-style block modelling using Xcos



---

Open Loop Analysis

The open-loop system was initially analyzed without any controller.

Observations:

Oscillatory response

Poor stabilization

Slower settling behavior

Reduced control over altitude


This demonstrated the need for an effective feedback controller.


---

Closed Loop PID Control

A PID controller was introduced to improve the system performance.

After tuning the PID gains:

Stability improved significantly

Oscillations were reduced

Settling became smoother

Altitude tracking improved


The closed-loop system demonstrated better damping characteristics compared to the open-loop system.


---

Wind Disturbance Simulation

To simulate real-world operating conditions, an external wind disturbance was introduced into the system.

The disturbance affects the drone altitude, causing deviation from the desired position.

The PID controller successfully:

Detected the altitude error

Adjusted motor thrust dynamically

Restored stable hovering condition


This demonstrates disturbance rejection capability and robustness of the controller.


---

Motor Thrust Adjustment

The project also includes motor thrust analysis.

The controller dynamically changes motor thrust based on altitude error:

Higher thrust during takeoff

Reduced thrust near stable hovering

Automatic thrust correction during disturbances


This behavior closely resembles real quadcopter stabilization systems.


---

Sensor Noise Simulation

Real-world drone sensors contain noise and measurement inaccuracies.

To simulate practical conditions, random sensor noise was added to the altitude response.

Even under noisy conditions:

The PID controller maintained stability

System robustness remained acceptable

Altitude response stayed near the desired value


