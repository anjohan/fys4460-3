program b
    use clusterlabelling
    use utilities
    implicit none

    integer, dimension(:), allocatable :: Ls, sample_sizes
    integer :: i, j, k, number_of_samples, number_of_probabilities, L
    real(kind=dp), dimension(:), allocatable :: P, PI
    real(kind=dp), dimension(:), allocatable :: probabilities
    character(len=:), allocatable :: fmtstring, Pfile, PIfile, filebase

    Ls = [ (2**i, i=1, 7) ]
    sample_sizes = [10, 100, 1000] !, 2000]

    number_of_probabilities = 101
    probabilities = linspace(0.0d0,1.0d0,number_of_probabilities)

    fmtstring = "(f0.6,x,f0.6)"

    do i = 1, size(sample_sizes)
        number_of_samples = sample_sizes(i)
        do j = 1, size(Ls)
            L = Ls(j)
            write(*,*) "L = ", L, ", samples = ", number_of_samples
            P  = [ (spanning_density(probabilities(k), L, number_of_samples),&
                        k = 1, number_of_probabilities) ]
            PI = [ (spanning_probability(probabilities(k), L, number_of_samples), &
                        k = 1, number_of_probabilities) ]
            filebase = stringfromint(number_of_samples) // "_" // stringfromint(L) // ".dat"
            Pfile = "tmp/P_" // filebase
            PIfile = "tmp/PI_" // filebase
            open(unit=11, file=Pfile, status="replace")
            open(unit=12, file=PIfile, status="replace")
            do k = 1, number_of_probabilities
                write(unit=11,fmt=fmtstring) probabilities(k), P(k)
                write(unit=12,fmt=fmtstring) probabilities(k), PI(k)
            end do
            close(unit=11)
            close(unit=12)
        end do
    end do

end program b
