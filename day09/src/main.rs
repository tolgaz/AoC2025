use std::collections::{HashMap, HashSet};
use std::sync::atomic::{AtomicBool, Ordering};

static DEBUG: AtomicBool = AtomicBool::new(false);

// Function to enable/disable debug at runtime
fn set_debug(enabled: bool) {
    DEBUG.store(enabled, Ordering::Relaxed);
}

// Debug print with formatting - only prints if DEBUG is true
macro_rules! debug_print {
    ($($arg:tt)*) => {
        if DEBUG.load(std::sync::atomic::Ordering::Relaxed) {
            println!($($arg)*);
        }
    };
}

fn read_input(filename: &str) -> std::io::Result<Vec<Vec<i64>>> {
    let contents = std::fs::read_to_string(filename)?;
    Ok(contents
        .lines()
        .map(|s| s.split(",").map(|x| x.parse::<i64>().unwrap()).collect())
        .collect())
}

fn solve_part1(lines: &[Vec<i64>]) -> i64 {
    let mut highest_area = 0;
    for i in 0..lines.len() {
        let i_x = lines[i][0];
        let i_y = lines[i][1];

        for y in i + 1..lines.len() {
            let y_x = lines[y][0];
            let y_y = lines[y][1];

            let current_area = ((i_x - y_x).abs() + 1) * ((i_y - y_y).abs() + 1);
            if current_area > highest_area {
                highest_area = current_area;
            }
        }
    }

    highest_area
}

// Find cluster of consecutive values starting at index i
fn find_cluster(y_values: &[i64], start_idx: usize, check_ends: bool) -> (usize, i64, i64) {
    let mut end_idx = start_idx;
    let start_value = y_values[start_idx];
    let mut end_value = y_values[start_idx + 1];
    if end_value - start_value == 1 {
        while end_idx + 1 < y_values.len() {
            let current = y_values[end_idx];
            let next = y_values[end_idx + 1];

            if next - current != 1 {
                break;
            }

            end_idx += 1;
            end_value = next;
        }
        debug_print!(
            "Cluster found: indices [{} to {}], values [{} to {}]",
            start_idx,
            end_idx,
            start_value,
            end_value
        );
    } else {
        debug_print!(
            "Cluster: start_value={}, end_value={}",
            start_value,
            end_value
        );
        if check_ends {
            // There are cases where end - start is not 1, but the end part is the start of a new cluster
            // In that case, we should set end to the end of said cluster
            // We only check this if we are gonna check if the end part is a part of the range
            if end_idx + 2 < y_values.len() && y_values[end_idx + 2] - end_value == 1 {
                debug_print!("Re running as the end point, was the start of a new cluster");
                let (end_idx_new, _, end_value_new) = find_cluster(y_values, end_idx + 1, false);
                end_idx = end_idx_new;
                end_value = end_value_new;
            }
        } else {
            // If there is not a cluster, and we did not check ends, we need to send end_idx to one larger
            if end_idx == start_idx {
                end_idx = end_idx + 1;
            }
        }
    }

    (end_idx, start_value, end_value)
}

// Check if a rectangle is valid by verifying start and end points are inside
fn check_y_range_validity(y_values: &[i64], start_point_y_1: i64, start_point_y_2: i64) -> bool {
    debug_print!("y_values: {:?}", y_values);
    debug_print!(
        "Starting Y value search loop. Looking for start_y={}, end_y={}",
        start_point_y_1,
        start_point_y_2
    );

    let mut i = 0;
    let mut found_start = false;
    let mut inside = false;
    while i < y_values.len() {
        inside = !inside;
        debug_print!("Loop iteration i={}, inside={}", i, inside);
        let (end_idx, start_value, mut end_value) = find_cluster(y_values, i, false);
        if !found_start {
            debug_print!("Looking for start point");
            if start_point_y_1 >= start_value && start_point_y_1 <= end_value {
                debug_print!(
                    "Found start! start_point_y_1={} >= start_value={}",
                    start_point_y_1,
                    start_value
                );
                found_start = true;
                i = end_idx;

                if start_point_y_2 <= end_value {
                    return true;
                }

                // If the start is the same as the end, and the inside is currently false, it means that it should be set to true, because it wil be true when it gets to end
                if start_point_y_1 == end_value {
                    continue;
                }

                // Found start, but its outside
                if inside == false {
                    return false;
                }
            }
        }

        if found_start {
            (_, _, end_value) = find_cluster(y_values, i, true);

            if start_point_y_2 <= end_value {
                debug_print!("Found valid end! Breaking.");
                return true;
            }
            return false;
        }

        i += 1;
    }

    false
}

fn solve_part2(lines: &[Vec<i64>]) -> i64 {
    let mut highest_area = 0;
    let mut map: HashMap<i64, HashSet<i64>> = HashMap::new();
    let mut i = 0;

    // Inserting all the borders (red/green tiles)
    loop {
        let curr_x_value = lines[i][0];
        let curr_y_value = lines[i][1];
        let next_x_value;
        let next_y_value;
        let mut break_out = false;

        if i == lines.len() - 1 {
            next_x_value = lines[0][0];
            next_y_value = lines[0][1];
            break_out = true;
        } else {
            next_x_value = lines[i + 1][0];
            next_y_value = lines[i + 1][1];
        }

        map.entry(curr_x_value)
            .or_insert(HashSet::from([curr_y_value]))
            .insert(curr_y_value);

        if curr_x_value == next_x_value {
            for y in i64::min(curr_y_value, next_y_value)..=i64::max(curr_y_value, next_y_value) {
                map.entry(curr_x_value)
                    .or_insert(HashSet::from([y]))
                    .insert(y);
            }
        } else {
            for x in i64::min(curr_x_value, next_x_value)..=i64::max(curr_x_value, next_x_value) {
                map.entry(x)
                    .or_insert(HashSet::from([curr_y_value]))
                    .insert(curr_y_value);
            }
        }

        if break_out {
            break;
        }
        i += 1;
    }

    // Sort all y values for each x coordinate
    let mut sorted_map: HashMap<i64, Vec<i64>> = HashMap::new();
    for (x, y_values) in map.iter() {
        let mut y_sorted: Vec<i64> = y_values.iter().copied().collect();
        y_sorted.sort();
        sorted_map.insert(*x, y_sorted);
    }

    // First, collect all possible rectangles with their areas
    let mut rectangles: Vec<(i64, usize, usize)> = Vec::new();
    for i in 0..lines.len() {
        for y in i + 1..lines.len() {
            let i_x = lines[i][0];
            let i_y = lines[i][1];
            let y_x = lines[y][0];
            let y_y = lines[y][1];

            let current_area = ((i_x - y_x).abs() + 1) * ((i_y - y_y).abs() + 1);
            rectangles.push((current_area, i, y));
        }
    }

    // Sort by area descending
    rectangles.sort_by(|a, b| b.0.cmp(&a.0));

    for (_, (area, i, y)) in rectangles.iter().enumerate() {
        let i_x = lines[*i][0];
        let i_y = lines[*i][1];
        let y_x = lines[*y][0];
        let y_y = lines[*y][1];

        let start_point_x_1 = i64::min(i_x, y_x);
        let start_point_x_2 = i64::max(i_x, y_x);
        let start_point_y_1 = i64::min(i_y, y_y);
        let start_point_y_2 = i64::max(i_y, y_y);

        // Quick corner check first - if any corner fails, entire rectangle fails
        let corners = [
            (start_point_x_1, start_point_y_1),
            (start_point_x_1, start_point_y_2),
            (start_point_x_2, start_point_y_1),
            (start_point_x_2, start_point_y_2),
        ];

        let corners_valid = corners.iter().all(|&(x, y)| {
            let y_values = sorted_map.get(&x).unwrap();
            let smallest_y_value = y_values[0];
            let highest_y_value = y_values[y_values.len() - 1];
            debug_print!(
                "Checking if cords are valid range. x: {}, y: {}. Smallest y: {} - highest y: {}",
                x,
                y,
                smallest_y_value,
                highest_y_value
            );

            if y >= smallest_y_value && y <= highest_y_value {
                return true;
            }

            return false;
        });

        if !corners_valid {
            continue;
        }

        let y_values_for_start_point_x_1 = sorted_map.get(&start_point_x_1).unwrap();

        if !check_y_range_validity(
            y_values_for_start_point_x_1,
            start_point_y_1,
            start_point_y_2,
        ) {
            continue;
        }

        let y_values_for_start_point_x_2 = sorted_map.get(&start_point_x_2).unwrap();
        if !check_y_range_validity(
            y_values_for_start_point_x_2,
            start_point_y_1,
            start_point_y_2,
        ) {
            continue;
        }

        highest_area = *area;
        println!(
            "✓ Found valid rectangle with area {}: ({}, {}) to ({}, {})",
            area, i_x, i_y, y_x, y_y
        );
        break; // Found the largest valid rectangle, we're done!
    }

    highest_area
}

fn main() -> std::io::Result<()> {
    set_debug(false);
    let lines = read_input("input.txt")?;

    // Part 1
    let part1_result = solve_part1(&lines);
    println!("Part 1: {}", part1_result);

    // Part 2
    let part2_result = solve_part2(&lines);
    println!("Part 2: {}", part2_result);

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1() {
        let lines = read_input("example.txt").expect("Failed to read example.txt");
        assert_eq!(solve_part1(&lines), 50);
    }

    #[test]
    fn test_part2() {
        let lines = read_input("example.txt").expect("Failed to read example.txt");
        assert_eq!(solve_part2(&lines), 24); // Replace with expected value
    }
}
