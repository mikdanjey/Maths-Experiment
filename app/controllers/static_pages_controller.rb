class StaticPagesController < ApplicationController
  def home
    if params[:n].present? && params[:n].to_s.to_i != 0
      @n = params[:n].to_s.to_i
    end
  end

  def bionomial_fit

    @x = params[:x].map(&:to_i)
    @f = params[:f].map(&:to_i)
    @n = params[:n].to_s.to_i
    @fx = []

    (0..@n).each do |i|
      @fx.push(@x[i]*@f[i])
    end

    # arithmetic mean
    @N = @f.inject(0){|sum, x| sum + x }
    @sfx = @fx.inject(0){|sum, x| sum + x }

    @arithmetic_mean = ((@sfx.to_f) / (@N.to_i)).round(4)

    # Bionamial Mean

    @np = @arithmetic_mean

    @p = ((@arithmetic_mean / @n).round(4)).to_f

    @q = ((1 - @p).round(4)).to_f

    @pXx = []
    (0..@n).each do |x|
      @pXx.push( (Math.nCr(@n, x) * (@p ** x) * (@q ** (@n - x))).round(4) )
    end

    @NP = []
    @pXx.each do |pxx|
      @NP.push((@N * pxx).round(1))
    end

    @E = []
    @NP.each do |np|
      @E.push(np.round)
    end

    @sE = @E.inject(0){|sum, x| sum + x }

  end

  def Math.nCr(n,r)
    a, b = r, n-r
    a, b = b, a if a < b  # a is the larger
    numer = (a+1..n).inject(1) { |t,v| t*v }  # n!/r!
    denom = (2..b).inject(1) { |t,v| t*v }    # (n-r)!
    numer/denom
  end
  
end
