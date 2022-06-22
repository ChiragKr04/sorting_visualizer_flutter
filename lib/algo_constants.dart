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
    [],
    [],
    [],
    [],
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
