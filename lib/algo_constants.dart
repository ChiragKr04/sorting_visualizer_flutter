class AlgoConstants {
  static const List<String> algoNames = [
    "Bubble Sort",
    "Insertion Sort",
    "Selection Sort",
    "Merge Sort",
    "Quick Sort",
  ];
  static const List pseudoCodeData = [
    [
      "do",
      "  swapped = false",
      "  for i = 1 to indexOfLastUnsortedElement-1",
      "      if leftElement > rightElement",
      "          swap(leftElement, rightElement)",
      "          swapped = true; ++swapCounter",
      "while swapped",
      "Sorting Done",
    ],
    [
      "mark first element as sorted",
      "for each unsorted element X",
      "    'extract' the element X",
      "    for j = lastSortedIndex down to 0",
      "        if current element j > X",
      "           move sorted element to the right by 1",
      "        break loop and insert X here",
      "Sorting Done",
    ],
    [
      "repeat (numOfElements - 1) times",
      "    set the first unsorted element as the minimum",
      "    for each of the unsorted elements",
      "        if element < currentMinimum",
      "            set element as new minimum",
      "    swap minimum with first unsorted position",
      "Sorting Done",
    ],
    [
      "split each element into partitions of size 1",
      "recursively merge adjacent partitions",
      "    for i = leftPartIdx to rightPartIdx",
      "        if leftPartHeadValue <= rightPartHeadValue",
      "            copy leftPartHeadValue",
      "        else: copy rightPartHeadValue; Increase RightIdx",
      "copy elements back to original array",
      "Sorting Done",
    ],
    [
      "for each (unsorted) partition",
      "set first element as pivot",
      "    storeIndex = pivotIndex+1",
      "    for i = pivotIndex+1 to rightmostIndex",
      "        if ((a[i] < a[pivot]) or (equal but 50% lucky))",
      "            swap(i, storeIndex); ++storeIndex",
      "    swap(pivot, storeIndex-1)",
      "Sorting Done",
    ],
  ];
  static const List<Map> algoData = [
    {
      "name": "Bubble Sort",
      "complexity": {
        "best": "O(n)",
        "average": "O(n^2)",
        "worst": "O(n^2)",
        "space": "O(1)",
      },
    },
    {
      "name": "Insertion Sort",
      "complexity": {
        "best": "O(n)",
        "average": "O(n^2)",
        "worst": "O(n^2)",
        "space": "O(1)",
      },
    },
    {
      "name": "Selection Sort",
      "complexity": {
        "best": "O(n^2)",
        "average": "O(n^2)",
        "worst": "O(n^2)",
        "space": "O(1)",
      },
    },
    {
      "name": "Merge Sort",
      "complexity": {
        "best": "O(n log(n))",
        "average": "O(n log(n))",
        "worst": "O(n log(n))",
        "space": "O(n)",
      },
    },
    {
      "name": "Quick Sort",
      "complexity": {
        "best": "O(n log(n))",
        "average": "O(n log(n))",
        "worst": "O(n^2)",
        "space": "O(log n)",
      },
    },
  ];
}
