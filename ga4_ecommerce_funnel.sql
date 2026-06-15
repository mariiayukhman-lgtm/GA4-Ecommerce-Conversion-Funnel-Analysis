WITH sessions_info AS (
  SELECT
    CONCAT(
      user_pseudo_id,
      '-',
      CAST((
        SELECT value.int_value
        FROM e.event_params
        WHERE key = 'ga_session_id'
      ) AS STRING)
    ) AS unique_session_id,

    TIMESTAMP_MICROS(event_timestamp) AS session_start_time,

    device.category AS device_category,
    device.language AS device_language,
    device.operating_system AS device_os,

    traffic_source.source AS source,
    traffic_source.medium AS medium,
    traffic_source.name AS campaign,

    COALESCE(
      NULLIF(
        REGEXP_EXTRACT((
          SELECT value.string_value
          FROM e.event_params
          WHERE key = 'page_location'
        ), r'^https?://[^/]+/?([^?#]*)'),
        ''
      ),
      'home'
    ) AS landing_page

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
  WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name = 'session_start'
),

events AS (
  SELECT
    CONCAT(
      user_pseudo_id,
      '-',
      CAST((
        SELECT value.int_value
        FROM e.event_params
        WHERE key = 'ga_session_id'
      ) AS STRING)
    ) AS unique_session_id,

    event_name,
    ecommerce.purchase_revenue AS purchase_revenue

  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
  WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN (
      'session_start',
      'view_item',
      'add_to_cart',
      'begin_checkout',
      'add_shipping_info',
      'add_payment_info',
      'purchase'
    )
)

SELECT
  s.unique_session_id,
  s.session_start_time,
  s.device_category,
  s.device_language,
  s.device_os,
  s.source,
  s.medium,
  s.campaign,
  s.landing_page,

  e.event_name,

  CASE e.event_name
    WHEN 'session_start' THEN 1
    WHEN 'view_item' THEN 2
    WHEN 'add_to_cart' THEN 3
    WHEN 'begin_checkout' THEN 4
    WHEN 'add_shipping_info' THEN 5
    WHEN 'add_payment_info' THEN 6
    WHEN 'purchase' THEN 7
  END AS funnel_step_number,

  CASE e.event_name
    WHEN 'session_start' THEN '1. Session start'
    WHEN 'view_item' THEN '2. View item'
    WHEN 'add_to_cart' THEN '3. Add to cart'
    WHEN 'begin_checkout' THEN '4. Begin checkout'
    WHEN 'add_shipping_info' THEN '5. Add shipping info'
    WHEN 'add_payment_info' THEN '6. Add payment info'
    WHEN 'purchase' THEN '7. Purchase'
  END AS funnel_step_name,

  e.purchase_revenue

FROM sessions_info s
LEFT JOIN events e
  ON s.unique_session_id = e.unique_session_id;
