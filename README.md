## BrightTV Viewership Analysis

## Project Overview

This project presents an exploratory data analysis (EDA) of BrightTV’s user and viewership data to understand user behaviour, content consumption patterns, and engagement trends.

The objective is to generate actionable insights that support Customer Value Management (CVM) strategies to improve user engagement, retention, and subscription growth.

## Business Objective

To grow BrightTV’s subscription base by:
- Analysing user demographics and behaviour
- Identifying content consumption patterns
- Understanding engagement trends
- Recommending strategies to improve retention and increase usage

## Key Questions

- What are the user and usage trends?
- What factors influence content consumption?
- How can low-consumption periods be improved?
- How can BrightTV grow its user base?

## Data Sources

### 1. User Profile Data
Contains demographic and identity information:
- UserID
- Name and Surname
- Email
- Gender
- Race
- Age
- Province
- Social Media Handle

### 2. Viewership Data (Session-Level)
Each row represents a viewing session:
- UserID
- Channel/Content
- Session Duration
- Record Date (UTC)

## Data Preparation

The following preprocessing steps were applied:

- Handling missing values using NULL standardisation
- Converting timestamps from UTC to South African time (UTC +2)
- Feature engineering:
  - Date
  - Hour of day
  - Day of week
  - Age groups
- Data cleaning and validation

## Data Integration

The datasets were combined using `UserID` to:
- Enrich viewership data with user demographics
- Create a unified dataset for analysis
- Enable deeper insights into user behaviour and engagement

## Exploratory Data Analysis (EDA)

### User Analysis
- Users by Gender
- Users by Race
- Users by Province
- Users by Age Group

### Usage Analysis
- Total number of sessions
- Viewing by day of week
- Viewing by time of day
- Peak vs low usage periods

### Content Analysis
- Most watched content
- Most popular channels
- Content consumption by demographic groups

### Engagement Analysis
- Sessions per user
- Most active users
- Least active users
- Repeat vs one-time viewers

### Low Consumption Analysis
- Identification of lowest viewing days
- Analysis of low engagement time periods
- Content performance during low-activity periods

## Key Insights

- Peak viewing occurs between **14:00–20:00**
- Highest engagement days are **Wednesday, Friday, and Saturday**
- **Monday** is the lowest consumption day
- Core audience: **25–34 age group in Gauteng**
- A small number of channels dominate content consumption
- A segment of users is inactive, indicating re-engagement opportunities

## Strategic Recommendations

###  Content Strategy
- Promote high-performing content
- Introduce content aligned with top demographics
- Curate content for low-consumption days

###  Engagement Strategy
- Personalised content recommendations
- Notifications during low-activity periods
- Introduce "peak-time content drops"

### Growth Strategy
- Target underrepresented demographics
- Run province-specific campaigns
- Leverage social media marketing

### Retention Strategy
- Re-engage inactive users
- Introduce loyalty and reward programmes
- Improve onboarding experience

## Expected Impact

- Increased user engagement
- Higher content consumption
- Improved retention rates
- Growth in subscription base

##  Tools & Technologies

- SQL (Databricks)
- Excel (Pivot Tables & Dashboard)
- Canva (Presentation Design)

## Dashboard

The dashboard was built in Excel using pivot tables and charts to visualise:
- User distribution
- Viewing patterns
- Content performance
- Engagement trends
- Low-consumption opportunities

## Repository Structure



## Conclusion

This analysis demonstrates how combining user demographics with viewership behaviour enables data-driven decision-making.

By focusing on engagement, content strategy, and retention, BrightTV can improve user experience and achieve sustainable growth.


## Author

**Nompumelelo Simango**  
Strategic Communications & Junior Data Analyst
