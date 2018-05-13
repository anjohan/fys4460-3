program c
    use utilities
    use percolation

    implicit none

    integer :: i,j,k, fileunit
    integer, parameter :: L = 1024, num_probabilities = 50, num_samples = 50
    real(kind=dp), dimension(:), allocatable :: probabilities, spanning_densities
    real(kind=dp), dimension(:), allocatable :: estimated_densities
    character(len=:), allocatable :: fmtstring, filename
    real(kind=dp) :: beta, const

    probabilities = linspace(pc + 0.000001d0, 1.02d0*pc, num_probabilities)

    spanning_densities = [ (spanning_density(probabilities(i), L, num_samples), &
                            i = 1, num_probabilities) ]

    call linfit(log10(probabilities - pc), log10(spanning_densities), beta, const)

    estimated_densities = (probabilities - pc)**beta * 10**const

    fmtstring = "(f0.6,x,f0.6,x,f0.6)"
    filename = "tmp/c_P.dat"
    open(newunit=fileunit, file=filename, status="replace")

    do i=1, num_probabilities
        write(unit=fileunit, fmt=fmtstring) probabilities(i), spanning_densities(i), &
                                            estimated_densities(i)
    end do
    close(unit=fileunit)

    open(newunit=fileunit, file="tmp/c_beta.dat", status="replace")
    write(unit=fileunit, fmt="(f0.3)") beta
    close(unit=fileunit)

end program c
