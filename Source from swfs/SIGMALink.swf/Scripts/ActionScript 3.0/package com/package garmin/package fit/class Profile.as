//class Profile
package com.garmin.fit 
{
    public class Profile extends Object
    {
        public function Profile()
        {
            super();
            return;
        }

        public static const FILE_ID_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const FILE_ID_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const FILE_ID_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const FILE_ID_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SLAVE_DEVICE_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_NUM_PER_FILE:int=0;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAX_PER_FILE:int=1;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAX_PER_FILE_TYPE:int=2;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_SUBFIELDS:int=3;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const MESG_CAPABILITIES_MESG_COUNT_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_TOTAL_STRIDES:int=0;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_TOTAL_CYCLES_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_AVG_RUNNING_CADENCE:int=0;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_AVG_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_MAX_RUNNING_CADENCE:int=0;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SESSION_MESG_MAX_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_TOTAL_STRIDES:int=0;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_TOTAL_CYCLES_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_AVG_CADENCE_FIELD_AVG_RUNNING_CADENCE:int=0;

        public static const LAP_MESG_AVG_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_AVG_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_AVG_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const LAP_MESG_MAX_CADENCE_FIELD_MAX_RUNNING_CADENCE:int=0;

        public static const LAP_MESG_MAX_CADENCE_FIELD_SUBFIELDS:int=1;

        public static const LAP_MESG_MAX_CADENCE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const LAP_MESG_MAX_CADENCE_FIELD_MAIN_FIELD:int=65535;

        public static const EVENT_MESG_DATA_FIELD_TIMER_TRIGGER:int=0;

        public static const EVENT_MESG_DATA_FIELD_COURSE_POINT_INDEX:int=1;

        public static const EVENT_MESG_DATA_FIELD_BATTERY_LEVEL:int=2;

        public static const EVENT_MESG_DATA_FIELD_VIRTUAL_PARTNER_SPEED:int=3;

        public static const EVENT_MESG_DATA_FIELD_HR_HIGH_ALERT:int=4;

        public static const EVENT_MESG_DATA_FIELD_HR_LOW_ALERT:int=5;

        public static const EVENT_MESG_DATA_FIELD_SPEED_HIGH_ALERT:int=6;

        public static const EVENT_MESG_DATA_FIELD_SPEED_LOW_ALERT:int=7;

        public static const EVENT_MESG_DATA_FIELD_CAD_HIGH_ALERT:int=8;

        public static const EVENT_MESG_DATA_FIELD_CAD_LOW_ALERT:int=9;

        public static const EVENT_MESG_DATA_FIELD_POWER_HIGH_ALERT:int=10;

        public static const EVENT_MESG_DATA_FIELD_POWER_LOW_ALERT:int=11;

        public static const EVENT_MESG_DATA_FIELD_TIME_DURATION_ALERT:int=12;

        public static const EVENT_MESG_DATA_FIELD_DISTANCE_DURATION_ALERT:int=13;

        public static const EVENT_MESG_DATA_FIELD_CALORIE_DURATION_ALERT:int=14;

        public static const EVENT_MESG_DATA_FIELD_FITNESS_EQUIPMENT_STATE:int=15;

        public static const EVENT_MESG_DATA_FIELD_SUBFIELDS:int=16;

        public static const EVENT_MESG_DATA_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const EVENT_MESG_DATA_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_TIME:int=0;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_DISTANCE:int=1;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_HR:int=2;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_CALORIES:int=3;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_STEP:int=4;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_DURATION_POWER:int=5;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_SUBFIELDS:int=6;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_DURATION_VALUE_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_TARGET_HR_ZONE:int=0;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_TARGET_POWER_ZONE:int=1;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_STEPS:int=2;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_TIME:int=3;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_DISTANCE:int=4;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_CALORIES:int=5;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_HR:int=6;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_REPEAT_POWER:int=7;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_SUBFIELDS:int=8;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_TARGET_VALUE_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_SPEED_LOW:int=0;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_HEART_RATE_LOW:int=1;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_CADENCE_LOW:int=2;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_CUSTOM_TARGET_POWER_LOW:int=3;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_SUBFIELDS:int=4;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_LOW_FIELD_MAIN_FIELD:int=65535;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_SPEED_HIGH:int=0;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_HEART_RATE_HIGH:int=1;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_CADENCE_HIGH:int=2;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_CUSTOM_TARGET_POWER_HIGH:int=3;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_SUBFIELDS:int=4;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const WORKOUT_STEP_MESG_CUSTOM_TARGET_VALUE_HIGH_FIELD_MAIN_FIELD:int=65535;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_GARMIN_PRODUCT:int=0;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_SUBFIELDS:int=1;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_ACTIVE_SUBFIELD:int=65534;

        public static const SCHEDULE_MESG_PRODUCT_FIELD_MAIN_FIELD:int=65535;
    }
}


