# EV-Market-Intelligence
Electric Vehicle Insights Project: SQL-powered data analysis and Power BI dashboard revealing trends in EV range, pricing, and eligibility.

🧱 1. Background and Overview
As a Data Analyst, my objective for this project was to explore and analyze electric vehicle (EV) data using SQL and Power BI to uncover actionable product insights. With the rise in EV adoption, understanding how pricing, range, eligibility, and other product features vary by brand, model, and vehicle type is crucial for business stakeholders such as product strategists, marketing teams, and supply chain planners.

The project focuses on answering key business questions:

Which EV models are performing best based on price-to-range ratio?

How does eligibility (e.g., government incentives) vary by vehicle type?

What trends exist in product performance across manufacturers?

How can companies optimize their EV offerings based on data?

📊 2. Data Structure Overview
The dataset consists of publicly available product-level EV data. Here’s a high-level view of the data schema:

Column Name	Data Type	Description
Model	Text	EV model name
Manufacturer	Text	Name of the car company
Price_INR	Numeric	Price of the vehicle in Indian Rupees
Range_KM	Numeric	Maximum driving range on a full charge (in kilometers)
Top_Speed_KMPH	Numeric	Top speed of the vehicle
Charging_Time_Hours	Numeric	Time taken for full charge
Battery_Capacity_kWh	Numeric	Battery capacity of the EV
Vehicle_Type	Text	Type of EV (Sedan, Hatchback, SUV, etc.)
Eligible_For_Incentive	Boolean	Indicates government eligibility

🔧 Data Cleaning & Transformations
Cleaned inconsistent model names and manufacturer values.

Converted data types for numerical and boolean analysis.

Created derived columns in Power BI (e.g., Price per KM range).

Used SQL queries with CTEs, Window Functions, and Aggregation to prepare summarized tables.

📈 3. Executive Summary (Key Findings)
✅ Tata Motors leads the EV market with the highest number of models offered.

📈 Average vehicle range is ~270 KM, while some premium models exceed 500 KM.

💸 Eligible vehicles have an average price of ₹14.2L, suggesting affordability boosts incentive qualification.

🕐 Fast-charging models (< 5 hrs) are 30% more likely to be eligible for incentives.

🚙 SUVs dominate the EV space, but hatchbacks provide the best price-to-range efficiency.

🔌 Battery capacity and price show a strong positive correlation, helping identify overpriced or underperforming models.

🔍 4. Insights Deep Dive
Insight 1: Tata’s Market Dominance
📊 Metric: Product Variety

🔢 Quantified: 9 models from Tata

🧠 Story: Tata Motors is positioning itself aggressively in the EV space, indicating brand trust and affordability as a strategy.

Insight 2: Affordable EVs and Incentive Eligibility
📊 Metric: Government Incentive Qualification

🔢 Quantified: Avg Price = ₹14.2L for eligible models

🧠 Story: Budget-conscious buyers are more likely to benefit from incentives — useful insight for pricing and marketing teams.

Insight 3: Fast-Charging = Incentive Eligible
📊 Metric: Charging Time vs Incentive

🔢 Quantified: 30% more eligibility in fast-charging EVs

🧠 Story: Technical features like charging speed play a critical role in making vehicles more attractive and eligible.

Insight 4: Price vs Battery Efficiency
📊 Metric: Price per Battery Capacity

🔢 Quantified: High correlation (R² ~ 0.82)

🧠 Story: Overpriced models can be identified by comparing against battery size — helps consumers and investors spot inefficiencies.

Insight 5: Optimal Vehicle Type
📊 Metric: Price-to-Range Ratio

🔢 Quantified: Hatchbacks average ₹4,500 per KM

🧠 Story: Hatchbacks outperform other vehicle types in terms of cost-efficiency, ideal for urban and price-sensitive segments.

📢 5. Recommendations
💡 Marketing Focus: Highlight fast-charging and incentive-eligible features in ad campaigns.

🚀 Product Strategy: Expand affordable EV variants like hatchbacks with optimized range and battery balance.

📍 Policy Collaboration: Partner with government to improve visibility and awareness of incentive schemes.

📊 Business Intelligence: Track performance using a dynamic Power BI dashboard for future product launch planning.

⚠️ 6. Caveats and Assumptions
⚠️ No historical time-series data – insights are from a single snapshot in time.

⚠️ Pricing assumed as ex-showroom, not inclusive of state-wise taxes or subsidies.

⚠️ Eligibility criteria may vary by state policy and not fully reflected in the dataset.

⚠️ Charging time based on manufacturer specs, not real-world conditions.

🛠 Tools Used
SQL Server: Data cleaning, transformation, and analysis using joins, CTEs, window functions.

Power BI: Interactive dashboard, DAX calculations, KPI visualizations, filters, and cards.

GitHub: For sharing project insights and documentation.
