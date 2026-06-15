# GA4 Ecommerce Conversion Funnel Analysis

## Project Overview

This project focuses on analyzing the ecommerce conversion funnel using Google Analytics 4 public data in BigQuery.

The goal was to build an interactive dashboard for marketing managers to monitor user behavior, conversion rates, traffic sources, devices, and landing pages.

## Business Task

The dashboard helps answer key business questions:

- How many users move through each step of the ecommerce funnel?
- Where do users drop off before purchase?
- Which devices, sources, campaigns, and landing pages perform best?
- How does conversion performance change over time?

## Funnel Steps

1. Session start
2. View item
3. Add to cart
4. Begin checkout
5. Add shipping info
6. Add payment info
7. Purchase

## Tools Used

- BigQuery
- SQL
- Tableau
- Google Analytics 4
- Data Visualization

## Key Metrics

- Sessions
- Product views
- Add to cart events
- Checkout starts
- Purchases
- Purchase revenue
- Conversion rate

## Key Insights

- The largest drop-off occurs between session start and product view.
- Only a small share of sessions reaches the purchase stage.
- Desktop users generated more sessions than mobile users.
- Landing pages and traffic sources have a strong impact on funnel performance.

## Dashboard

[View Dashboard](https://public.tableau.com/views/DA4_Final_Project_2026/GA4ConversionFunnelAnalysis?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Dataset

The project is based on the public GA4 ecommerce dataset available in BigQuery.

## Project Files

- `SQL/` — SQL query used to prepare funnel data
- `data/` — exported dataset for visualization
- `dashboard/` — dashboard screenshots
- `README.md` — project documentation
