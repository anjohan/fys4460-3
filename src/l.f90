program l
    use utilities
    use clusterlabelling
    implicit none

    integer :: num_Ls, num_xs, i, j, num_samples, fileunit
    integer, dimension(:), allocatable :: Ls
    real(kind=dp), dimension(:), allocatable :: xs
    character(len=:), allocatable :: filename
    real(kind=dp) :: tolerance, p_x

    num_samples = 16000
    tolerance = 0.0001d0

    xs = [0.3, 0.8]
    num_xs = size(xs)
    Ls = [25, 50, 100, 200, 400, 800]
    num_Ls = size(Ls)

    do i = 1, num_xs
        associate(x => xs(i))
            filename = "tmp/l_" // stringfromint(i) // ".dat"
            open(newunit=fileunit, file=filename, status="replace")
            do j = 1, num_Ls
                associate(L => Ls(j))
                    p_x = spanning_probability_inverse(x, L, num_samples/L, tolerance)
                    write(unit=fileunit, fmt=*) L, p_x
                end associate
            end do
            close(unit=fileunit)
        end associate
    end do


end program l
