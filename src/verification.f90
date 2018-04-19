program speedtest
    use clusterlabelling
    use utilities
    implicit none
    integer, parameter :: L = 6
    integer :: number_of_labels
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: labelled_matrix
    integer :: spanning_label
    real, parameter :: p = 0.585
    real :: t0,t1

    matrix = create_binary_matrix(p,L)

    call cpu_time(t0)
    call label(matrix, labelled_matrix, number_of_labels)
    call cpu_time(t1)

    write(*,fmt="(a)") "Binary matrix:"
    write(*, fmt='('//stringfromint(L)//'L4)') matrix

    write(*,fmt="(a)") "Labelled matrix:"
    write(*, fmt='('//stringfromint(L)//'i4)') labelled_matrix

    spanning_label = find_spanning_cluster(labelled_matrix, number_of_labels)
    write(*,fmt="(ai0)") "Spanning cluster: ", spanning_label
    write(*,fmt="(ai0)") "Spanning cluster area:", count(labelled_matrix == spanning_label)

end program speedtest
