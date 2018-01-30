# Octapod
As a result of an analysis performed for [Intermediate Engineering Project](https://github.com/KarolloS/Spider-motion-analysis) 
at Warsaw University of Technology, data describing quantitatively the movement of a real spider was obtained. The next part of the project
(my Bachelor Thesis) included: prototype design, control software design and its implementation in real robot.

## Mechanical design
Each leg of a robot was simplified and has only three degrees of freedom. The proportions between the legs and the body of analysed 
spider were maintained. However the whole robot is approximately 7x bigger than the real spider. Each leg contains three
[Dynamixel AX-12A servo actuators](http://support.robotis.com/en/product/actuator/dynamixel/ax_series/dxl_ax_actuator.htm) (the whole robot has 
24 actuators). Prototype model: 

![alt text](https://github.com/KarolloS/Octapod/blob/master/robot_model.jpg)

## Control software
Control software is based on the data obtained from real spider motion analysis. Analytical solution for inverse kinematics was 
derived in order to be able to perform calculations efficiently. All calculations were performed in MatLab (`sterowanie.m`). Library provided by
[ROBOTIS](http://support.robotis.com/en/software/dynamixel_sdk/usb2dynamixel/windows/matlab.htm) (producer of Dynamixel servos)
was used for low-level control of actuators directly from MatLab. Simple graphical interface was provided for robot control:

![alt text](https://github.com/KarolloS/Octapod/blob/master/GUI.png)

## Prototype

![alt text](https://github.com/KarolloS/Octapod/blob/master/prototype.JPG)

Project was done as a part of Bachelor of Science Thesis - „Eight legged walking robot - mechanical and control design, prototype” 
at Warsaw University Technology. It received the highest possible mark 5/5.
