program n_collapse
    use percolation
    use utilities
    implicit none

    integer :: num_Ls, num_ps, num_samples, i, j, fileunit
    integer :: minLpow, maxLpow
    real(kind=dp), dimension(:), allocatable :: ps, PI, dpLpow
    integer, dimension(:), allocatable :: Ls
    real(kind=dp) :: nu
    character(len=:), allocatable :: filename

    nu = 4.0d0/3
    minLpow = 4
    maxLpow = 9
    Ls = [(2**i, i = minLpow, maxLpow)]
    num_Ls = size(Ls)
    num_ps = 500
    ps = linspace(0.0d0, 1.0d0, num_ps)
    num_samples = 2**13

    open(newunit=fileunit, file="tmp/n_Lpows.dat", status="replace")
    do i = minLpow, maxLpow
        write(unit=fileunit, fmt="(i0)") i
    end do
    close(unit=fileunit)

    do i = 1, num_Ls
        associate(L => Ls(i))
            dpLpow = (ps-pc)*L**(1/nu)
            PI = [(spanning_probability(ps(j), L, num_samples/L), &
                   j = 1, num_ps)]

            filename = "tmp/n_collapse_" // stringfromint(i) // ".dat"
            open(newunit=fileunit, file=filename, status="replace")
            do j = 1, num_ps
                write(unit=fileunit, fmt=*) dpLpow(j), PI(j)
            end do
            close(unit=fileunit)
        end associate
    end do
end program n_collapse
