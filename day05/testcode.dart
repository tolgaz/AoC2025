/*
funksjonen som sletter direkte duplikater
  for (final range in ranges) {
    final start = int.parse(range[0]);
    final end = int.parse(range[1]);
    var test = false;
    for (final innerRange in ranges) {
      final innerStart = int.parse(innerRange[0]);
      final innerEnd = int.parse(innerRange[1]);

      if (start == innerStart && end == innerEnd) {
        continue;
      }
      if (start >= innerStart && end <= innerEnd) {
        test = true;
      }
    }

    if (test == false) {
      newRanges.add(range);
    }
  }

*/
  // Range i settes inn, start, end og diff
  // Range 2 sjekeks, er starten til range to større en starten til range 1
  // Sjekk ending, er endingen mindre en endingen til range 1, skip
  // Er endingen større så lager vi at range to nå er range 1 end <-> range 2 end, så har vi sletter overlapp

/*
    for (final innerRange in ranges) {
      final innerStart = int.parse(innerRange[0]);
      final innerEnd = int.parse(innerRange[1]);
      if (innerStart == start && innerEnd == end) {
        continue;
      }
    }
*/
/*
  final newMap = Map<int, int>();
  for (final range in ranges) {
    print("THIS IS RANGE: ");
    print(range);
    var start = int.parse(range[0]);
    var end = int.parse(range[1]);
    var range1 = [];
    var range2 = [];

    newMap.forEach((mapStart, mapEnd) {
      if (!(start == 0 && end == 0)) {
        print("THIS IS NEW MAP INNER RANGE");
        print("mapStart: ${mapStart} - mapEnd: ${mapEnd}");
        if (start >= mapStart) {
          if (end <= mapEnd) {
            print("The start is higher and end is lower!");
            start = 0;
            end = 0;
          } else if (start >= mapEnd) {
            // DO nothing its out of range
          } else if (start <= mapEnd) {
            print("The start is lower than the end and end is higher!");
            if (end >= mapEnd) {
              start = mapEnd + 1;
            } else {
              start = 0;
              end = 0;
            }
          }
        } else {
          if (end < mapStart) {
            // Do nothign, its under range
          } else if (end >= mapStart) {
            if (end >= mapEnd) {
              // Da overlapper den hele rangen her,m hva gjør vi?
              range1 = [start, mapStart];
              range2 = [end, mapEnd];
              start = 0;
              end = 0;
            } else {
              // den starter under, men er mindre enn enden
              end = mapStart - 1;
            }

            print("The start is lower but the end is higher than start!");
            print("Start is lower, and end is higher");
            //end = mapEnd;
          }
        }
      }
    });

    newMap[start] = end;
    if (range1.isNotEmpty && range2.isNotEmpty) {
      newMap[range1[0]] = range1[1];
      newMap[range2[0]] = range2[1];
      range1 = [];
      range2 = [];
    }
  }

  var count = 0;
  newMap.forEach((mapStart, mapEnd) {
    count += 1 + mapEnd - mapStart;
  });
*/
// Sort all ranges based on start range
// Then loop over each range, check their end value
// IF end value is higher than the next end value,

// Tar første range, maxen, sjekk i neste, sjekk først most laveste
// om den er lavere enn start i neste range, do nothing, neste index
// om den er høyere nn start i neste range sjekk max i neste index
// om den er lavere enn max i neste index, set end i current index til å være start i neste - 1
// om den er høyere enn max i neste index, skip neste range, siden den er i forrige og sett i+2
/*
  for (int i = 0; i < ranges.length; i++) {
    // check if duplicate exists in map

    var start = int.parse(ranges[i][0]);
    var end = int.parse(ranges[i][1]);
    if (newMap[start] == end) {
      continue;
    }

    for (int y = i + 1; y < ranges.length; y++) {
      var nextStart = int.parse(ranges[y][0]);
      var nextEnd = int.parse(ranges[y][1]);

      if (start == nextStart && end == nextEnd) {
        continue;
      } else if (end < nextStart) {
        break;
      } else if (end > nextStart) {
        if (end < nextEnd) {
          end = nextStart - 1;
        } else {}
      } else if (end == nextStart) {
        end = nextStart - 1;
      }
    }
    newMap[start] = end;
  }
  */