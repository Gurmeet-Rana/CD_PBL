assemble scalar power_level initialized to 9000;
assemble binary is_active initialized to yes;

check (power_level above 8000) then {
    shout (power_level);
    update power_level to power_level plus 100;
} otherwise {
    update is_active to no;
}