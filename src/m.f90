program m
    use percolation
    use utilities
    implicit none

    integer :: num_Ls, i, num_samples, fileunit
    integer, dimension(:), allocatable :: Ls
    real(kind=dp) :: x1, x2, tolerance, nu, slope, const
    real(kind=dp), dimension(:,:), allocatable :: invPI
    real(kind=dp), dimension(:), allocatable :: diff, diffapprox
    character(len=:), allocatable :: filename

    Ls = [(2**i, i = 4, 9)]
    num_Ls = size(Ls)

    x1 = 0.8; x2 = 0.3
    num_samples = 2**15; tolerance = 0.0001d0

    allocate(invPI(num_Ls, 2))

    invPI(:,1) = [(spanning_probability_inverse(x1, Ls(i), num_samples/Ls(i), tolerance), &
                   i = 1, num_Ls)]
    invPI(:,2) = [(spanning_probability_inverse(x2, Ls(i), num_samples/Ls(i), tolerance), &
                   i = 1, num_Ls)]

    diff = invPI(:,1) - invPI(:,2)

    call linfit(log(1.0d0*Ls), log(diff), slope, const)
    nu = -1/slope
    diffapprox = exp(const) * Ls**slope

    open(newunit=fileunit, file="tmp/m.dat", status="replace")
    do i = 1, num_Ls
        write(unit=fileunit, fmt=*) Ls(i), diff(i), diffapprox(i)
    end do
    close(unit=fileunit)

    open(newunit=fileunit, file="tmp/m_nu.dat", status="replace")
    write(unit=fileunit, fmt="(f0.3)") nu
    close(unit=fileunit)

end program m
