import time

start_time, end_time = 1000, 5000
cur_time = 0

radius_cur = 150
radius_min = 50

while True:
    cur_time += 1000

    if cur_time > end_time:
        print(cur_time, start_time, end_time)
        break

    dt = end_time - start_time
    d_radius = radius_cur - radius_min
    speed = d_radius / dt
    t_radius = speed * cur_time
    radius = radius_cur - t_radius

    print(f"cur_time: {cur_time}; radius: {radius}; d_radius: {d_radius}; t_radius: {t_radius}; dt: {dt}; speed: {speed}")

    time.sleep(0.5)