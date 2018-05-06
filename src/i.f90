program iprogram
    use utilities
    use clusterlabelling
    implicit none

    integer :: num_samples, i, spanning_label, M, L, num_Ls
    logical, dimension(:,:), allocatable :: matrix
    integer, dimension(:,:), allocatable :: label_matrix
    integer, dimension(:), allocatable :: Ms, Ls

    Ls = 2**[(i, i=4, 11)]
    num_Ls = size(Ls)
    allocate(Ms(num_Ls))

    do i = 1, num_Ls
        associate(L => Ls(i), M => Ms(i))
        end associate
    end do

end program iprogram
