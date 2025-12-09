package aoc;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

public class Solution {

    public static void main(String[] args) {
        try {
            List<String> lines = readInput("input.txt");
            // Part 1
            long part1Result = solvePart1(lines);
            System.out.println("Part 1: " + part1Result);
            // Part 2
            long part2Result = solvePart2(lines);
            System.out.println("Part 2: " + part2Result);
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
            System.exit(1);
        }
    }

    static List<String> readInput(String filename) throws IOException {
        String file = Files.readString(Paths.get(filename));
        return List.of(file.split(","));
    }

    public static long solvePart1(List<String> lines) {
        HashMap<Long, Long> map = new HashMap<>();
        for (String range : lines) {
            String[] parts = range.split("-");
            Long start = Long.valueOf(parts[0]);
            Long end = Long.valueOf(parts[1]);
            for (Long i = start; i <= end; i++) {
                String stringVersion = String.valueOf(i);
                // Sjekk om den er divisable
                if (stringVersion.length() % 2 != 0) {
                    continue;
                }

                Long midPart = stringVersion.length() / 2L;
                String[] splittedParts = {stringVersion.substring(0, midPart.intValue()), stringVersion.substring(midPart.intValue())};
                Long[] integerParts = {Long.valueOf(splittedParts[0]), Long.valueOf(splittedParts[1])};

                if (map.containsKey(integerParts[0])) {
                    continue;
                }

                if (Objects.equals(integerParts[0], integerParts[1])) {
                    map.put(integerParts[0], i);
                }
            }
        }
        return map.values().stream().mapToLong(l -> l).sum();
    }

    private static List<Long> buildPairs(char[] chars, int pairOf) {
        List<Long> pairs = new ArrayList<>();
        if (chars.length % pairOf != 0) {
            return pairs;
        }
        for (int i = 0; i < chars.length; i += pairOf) {
            String pair = "";
            for (int p = 0; p < pairOf; p++) {
                pair += String.valueOf(chars[i + p]);
            }
            pairs.add(Long.valueOf(pair));
        }
        return pairs;
    }

    public static long solvePart2(List<String> lines) {
        HashMap<Long, Long> map = new HashMap<>();
        for (String range : lines) {
            String[] parts = range.split("-");
            Long start = Long.valueOf(parts[0]);
            Long end = Long.valueOf(parts[1]);
            for (Long i = start; i <= end; i++) {
                String stringVersion = String.valueOf(i);
                if (stringVersion.length() % 2 == 0) {

                    Long midPart = stringVersion.length() / 2L;
                    String[] splittedParts = {stringVersion.substring(0, midPart.intValue()), stringVersion.substring(midPart.intValue())};
                    Long[] integerParts = {Long.valueOf(splittedParts[0]), Long.valueOf(splittedParts[1])};

                    if (!map.containsKey(integerParts[0])) {
                        if (Objects.equals(integerParts[0], integerParts[1])) {
                            map.put(i, i);
                        }
                    }
                }

                char[] chars = stringVersion.toCharArray();
                for (int c = 1; c < Math.ceil(chars.length / 2.0); c++) {
                    List<Long> pairs = buildPairs(chars, c);
                    if (pairs.isEmpty()) {
                        continue;
                    }

                    pairs.sort(Long::compareTo);
                    if (Objects.equals(pairs.getFirst(), pairs.getLast())) {
                        map.put(i, i);
                    }
                }
            }
        }
        return map.values().stream().mapToLong(l -> l).sum();
    }
}
