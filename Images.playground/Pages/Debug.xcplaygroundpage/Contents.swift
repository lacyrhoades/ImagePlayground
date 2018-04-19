let foo = [1, 2, 3]

foo.flatMap {
    return [$0]
}
