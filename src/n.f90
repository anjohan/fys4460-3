program n
    use percolation, critical_probability => pc
    use utilities
    implicit none

    integer :: num_Ls, num_xs, i, j, fileunit, num_samples
    integer, dimension(:), allocatable :: Ls
    real(kind=dp), dimension(:), allocatable :: xs, invPI, Lpow
    real(kind=dp) :: nu, tolerance, const, slope, pc
    character(len=:), allocatable :: filename

    pc = 0
    nu = 4/3.0d0
    num_samples = 2**13

    xs = [0.1, 0.3, 0.7, 0.9]
    num_xs = size(xs)

    Ls = [(2**i, i = 4, 9)]
    Lpow = Ls**(-1/nu)
    num_Ls = size(Ls)

    open(newunit=fileunit, file="tmp/n_x.dat", status="replace")
    do i = 1, num_xs
        write(unit=fileunit, fmt="(f0.1)") xs(i)
    end do
    close(unit=fileunit)

    do i = 1, num_xs
        invPI = [(spanning_probability_inverse(xs(i), Ls(j), num_samples/Ls(j), tolerance), &
                  j = 1, num_Ls)]
        call linfit(Lpow, invPI, slope, const)
        pc = pc + const

        filename = "tmp/n_" // stringfromint(i) // ".dat"
        open(newunit=fileunit, file=filename, status="replace")
        do j = 1, num_Ls
            write(unit=fileunit, fmt=*) Lpow(j), invPI(j)
        end do
        close(unit=fileunit)

        filename = "tmp/n_" // stringfromint(i) // "_approx.dat"
        open(newunit=fileunit, file=filename, status="replace")
        write(unit=fileunit, fmt=*) 0.0d0, const
        do j = 1, num_Ls
            write(unit=fileunit, fmt=*) Lpow(j), const + slope*Lpow(j)
        end do
        close(unit=fileunit)

        filename = "tmp/n_pc_" // stringfromint(i) // ".dat"
        open(newunit=fileunit, file=filename, status="replace")
        write(unit=fileunit, fmt="(f0.4)") const
        close(unit=fileunit)
    end do
end program n
