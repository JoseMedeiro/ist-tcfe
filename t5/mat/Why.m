% Imput Impedance

I1*(ZCI + RB) - I2*ZB                               == Vin
- I1*ZB + I2*(ZB + zpi1 + ZE1CB) - I4*ZE1CB         == 0
I2*zpi1 + I3                                        == 0
- I2*ZE1CB - I3*zo1 + I4*(ZE1CB + zo1 + ZC) - I5*ZC == 0
- I4*ZC + I5*zpi2 + I6*Zo2E2 - I7*Zo2E2             == 0
- I5*(1 + zpi2) + I6                                == 0
I7                                                  == 0

% Output Impedance

I1*(ZCI + RB) - I2*ZB                               == 0
I2*(ZB + zpi1 + ZE1CB) - I4*ZE1CB                   == 0
I2*zpi1 + I3                                        == 0
- I2*ZE1CB - I3*zo1 + I4*(ZE1CB + zo1 + ZC) - I5*RC == 0
- I4*ZC + I5*zpi2 + I6*Zo2E2 - I7*Zo2E2             == 0
- I5*(1 + zpi2) + I6                                == 0
- I6*Zo2E2 + I7*(Zo2E2 + CO)                        == -Vout

% Normal Business

I1*(ZS +ZCI + RB) - I2*ZB                           == Vin
I2*(ZB + zpi1 + ZE1CB) - I4*ZE1CB                   == 0
I2*zpi1 + I3                                        == 0
- I2*ZE1CB - I3*zo1 + I4*(ZE1CB + zo1 + ZC) - I5*RC == 0
- I4*ZC + I5*zpi2 + I6*Zo2E2 - I7*Zo2E2             == 0
- I5*(1 + zpi2) + I6                                == 0
- I6*Zo2E2 + I7*(Zo2E2 + CO + ZL)                   == 0