/* HeroScript Test Examples */

/* DECLARATIONS */
assemble scalar power_level initialized to 9000;
assemble binary is_active initialized to yes;
assemble decimal energy_consumption initialized to 150.75;
assemble scalar enemy_count initialized to 5;
assemble decimal damage_multiplier initialized to 1.5;

/* ARITHMETIC OPERATIONS */
assemble scalar attack_power initialized to 100 plus 50;
assemble scalar defense_score initialized to 200 minus 30;
assemble scalar total_damage initialized to 45 times 2;
assemble scalar critical_hit initialized to 1000 dividedby 4;

/* CONDITIONAL LOGIC */
check (power_level above 8000) then {
    shout(power_level);
    update power_level to power_level plus 100;
} otherwise {
    update is_active to no;
};

/* COMPARISON CHECKS */
check (enemy_count below 10) then {
    shout(enemy_count);
    update enemy_count to enemy_count plus 1;
};

/* EQUAL COMPARISON */
check (attack_power equal 150) then {
    shout(attack_power);
};

/* UPDATE STATEMENTS */
update power_level to power_level minus 500;
update energy_consumption to energy_consumption plus 25.5;
update damage_multiplier to damage_multiplier times 0.8;

/* REPEAT LOOP */
repeat (3) {
    update power_level to power_level plus 200;
    shout(power_level);
};

/* WHILE LOOP */
while (enemy_count below 20) {
    update enemy_count to enemy_count plus 2;
    update attack_power to attack_power plus 10;
    shout(enemy_count);
};

/* COMPLEX EXPRESSIONS */
assemble scalar final_score initialized to 100 plus 50 times 2;
assemble binary mission_complete initialized to 1;
update critical_hit to critical_hit minus 50 plus 25;
