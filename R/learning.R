# Loading Packages --------------------------------------------------------

library(tidyverse)
library(NHANES)


# Using dplyr for data wrangling ------------------------------------------

# Looking at the data
glimpse(NHANES)

# Selecting columns
select(NHANES, Age)

# Multiple columns
select(NHANES, Age, Weight, BMI)

# Removing a column
select(NHANES, -HeadCirc)

# Selecting a column with something specific
select(NHANES, starts_with("BP"))

select(NHANES, ends_with("Day"))

select(NHANES, contains("Age"))


# Creating a smaller NHANES dataset
NHANES_small <- select(
  NHANES, Age, Gender, BMI, Diabetes,
  PhysActive, BPSysAve, BPDiaAve, Education
)

# Renaming columns to fit the tidyverse snake case format
NHANES_small <- rename_with(
  NHANES_small,
  snakecase::to_snake_case
)

# Renaming specific columns
NHANES_small <- rename(NHANES_small,
  sex = gender
)

# Trying out the pipe
colnames(NHANES_small)

NHANES_small %>% ## doing the same, but with a pipe:
  colnames()

NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

# Exercise 7.8
NHANES_small %>%
  select(bp_sys_ave, education)

NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

select(NHANES_small, bmi, contains("age")) # rewrite this using pipe

NHANES_small %>%
  select(bmi, contains("age"))

blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys_ave) # rewrite without the temp object

NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)


# Filtering
NHANES_small %>%
  filter(phys_active == "No")

NHANES_small %>%
  filter(bmi >= 25)

# Combining logical operators
NHANES_small %>%
  filter(bmi >= 25 & phys_active == "No")

NHANES_small %>%
  filter(bmi >= 25 | phys_active == "No")

# Arrange data
NHANES_small %>%
  arrange(desc(age))

NHANES_small %>%
  arrange(education, age)

# Transforming data
NHANES_small %>%
  mutate(
    age = age * 12,
    logged_bmi = log(bmi)
  )

NHANES_small %>%
  mutate(old = if_else(age >= 30, "Yes", "No"))


# Exercise 7.12 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
    dplyr::filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

nhanes_modified <- NHANES_small %>%
    mutate(
        mean_arterial_pressure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        young_child = if_else(age<6, "Yes", "No")
    )
nhanes_modified
