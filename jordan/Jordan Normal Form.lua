-- Jordan Normal Form,version 1.0, 2015-10
-- Rolf Pütter
--------------------Global variables
platform.apilevel = '1.0'
screen = platform.window
dimension = 1
matrix = 2
show = 3
step = 4
dim = 2
trans = false
A = {} -- the input matrix
J = {} -- the Jordan matrix
S = {} -- the transformation matrix
valr = {} -- real parts of the eigenvalues
vali = {} -- imaginary parts of the eigenvalues
realE = {} -- list of real eigenvalues and their multiplicities
compE = {} -- list of complex eigenvalues and their multiplicities
function init()
    cursor.hide()
    W = platform.window:width()
    H = platform.window:height()
    matWin = mWindow(3, 3, 0.98 * W, 0.97 * H, "A")
    init1()
end -- init

function init1()
    modus = dimension
    collectgarbage()
end -- init1

function initM(n)
    A = {};
    S = {};
    J = {}
    collectgarbage()
    for i = 1, n do
        A[i] = {};
        S[i] = {};
        J[i] = {}
        for j = 1, n do
            A[i][j] = 0;
            S[i][j] = 0;
            J[i][j] = 0
        end
    end
end
function on.restore()
    -- init()
end

function on.resize()
    init()
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------Drawing procedures -----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function on.paint(gc)

    local text = ""
    if modus == dimension then
        matWin:hide()
        text = "Please enter the size (2...5) of the quadratic matrix A"
        gc:setColorRGB(0, 0, 0)
        gc:setFont("serif", "r", H * 0.05)
        gc:drawString(text, 0.03 * W, 0.03 * H, "top")
        text = string.format("Size = %d", dim)
        gc:drawString(text, 0.03 * W, 0.13 * H, "top")
    end -- if modus==dimension

    if modus == matrix then
        matWin:setVis(true)
        matWin:paint(gc)
    end

    if modus == show then
        gc:setColorRGB(0, 0, 0)
        gc:setFont("serif", "r", H * 0.05)
        text = "χ(x):"
        for i = 0, dim do
            text = text .. string.format(" %5.2f", minorSum(A, i) * par(i))
        end
        gc:drawString(text, 0.03 * W, 0.03 * H, "top")
        text = "Eigenvalues: "
        for i = 1, #realE do
            text = text .. string.format("(%3.3f,%d)", realE[i][1], realE[i][2])
        end
        for i = 1, #compE do
            text = text .. string.format("(%3.3f,%3.3f,%d)", compE[i][1], compE[i][2], compE[i][3])
        end
        gc:drawString(text, 0.03 * W, 0.13 * H, "top")
        if trans then
            gc:drawString("Transformation matrix:", 0.03 * W, 0.23 * H, "top")
            showM(gc, S, 0.03 * W, 0.33 * H)
        else
            gc:drawString("Real Jordan matrix:", 0.03 * W, 0.23 * H, "top")
            showM(gc, J, 0.03 * W, 0.33 * H)
        end

    end

end -- on.paint

function showM(gc, c, x, y) -- c is a dim x dim matrix
    local text
    gc:setColorRGB(0, 0, 0)
    gc:setFont("serif", "r", H * 0.05)
    for i = 1, #c do
        for j = 1, #c[i] do
            text = string.format("%3.3f", c[i][j])
            gc:drawString(text, x + (j - 1) * W / 6, y + (i - 1) * H / 10, "top")
        end -- for j
    end -- for i      
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------Mathematical functions ---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function det(a, n) -- a is a quadratic matrix, n the number of its rows and columns
    local res = 0
    local fact
    local b = {}
    local k
    if n == 2 then
        return a[1][1] * a[2][2] - a[2][1] * a[1][2]
    elseif n == 3 then
        return a[1][1] * (a[2][2] * a[3][3] - a[3][2] * a[2][3]) - a[2][1] * (a[1][2] * a[3][3] - a[3][2] * a[1][3]) +
                   a[3][1] * (a[1][2] * a[2][3] - a[2][2] * a[1][3])
    elseif n >= 4 then
        res = 0
        fact = -1
        for r = 1, n do -- the index of the row that is left out
            k = 0
            for i = 1, n do
                if i ~= r then
                    k = k + 1
                    b[k] = {}
                    for j = 1, n - 1 do
                        b[k][j] = a[i][j + 1]
                    end -- for j
                end -- if   
            end -- for i
            fact = -fact
            res = res + fact * a[r][1] * det(b, n - 1)
        end -- for r                        
        return res
    end -- if n       
    return res
end
function crossP(a, c) -- a is the (n-1)xn input matrix. The 1xn cross product of its rows is written to c
    local b = {} -- takes the (n-1)x(n-1) submatrices of a
    local rows = #a
    local cols = #a[1]
    for i = 1, rows do
        b[i] = {}
    end
    if rows ~= cols - 1 then
        return false
    end
    if rows == 1 then
        c[1] = -a[1][2]
        c[2] = a[1][1]
    elseif rows == 2 then
        c[1] = a[1][2] * a[2][3] - a[2][2] * a[1][3]
        c[2] = -(a[1][1] * a[2][3] - a[2][1] * a[1][3])
        c[3] = a[1][1] * a[2][2] - a[2][1] * a[1][2]
    elseif rows >= 3 then
        local fact = -1
        for r = 1, cols do -- index of the column to be skipped
            local k = 0
            for j = 1, cols do
                if j ~= r then
                    k = k + 1 -- column index
                    for i = 1, rows do -- row index
                        b[i][k] = a[i][j]
                    end -- for i
                end -- if   
            end -- for j
            fact = -fact
            c[r] = fact * det(b, rows)
        end -- for r                     
    end -- if
    return true
end

function par(n) -- n must be an integer
    return 1 - 2 * (n % 2)
end

function minorSum(a, n) -- a must be a dim x dim matrix. Output are (up to sign) the coefficients of the characteristic polynomial
    local c = 0
    local p, q
    local m = {}
    for i = 1, n do
        m[i] = {}
    end
    if n > dim then
        return 0
    end
    if n == dim then
        return det(a, dim)
    end

    if n == 0 then
        c = 1
    elseif n == 1 then
        for i = 1, dim do
            c = c + a[i][i]
        end
    elseif n == 2 then
        for i = 1, dim - 1 do
            for j = i + 1, dim do
                m[1][1] = a[i][i]
                m[1][2] = a[i][j]
                m[2][1] = a[j][i]
                m[2][2] = a[j][j]
                c = c + det(m, 2)
            end -- for j           
        end -- for i   
    elseif n == 3 then
        for i = 1, dim - 2 do
            for j = i + 1, dim - 1 do
                for k = j + 1, dim do
                    local v = {i, j, k}
                    for p = 1, 3 do
                        for q = 1, 3 do
                            m[p][q] = a[v[p]][v[q]]
                        end
                    end -- for p
                    c = c + det(m, 3)
                end -- for k
            end -- for j
        end -- for i
    elseif n == 4 then
        for i = 1, dim - 3 do
            for j = i + 1, dim do
                for k = j + 1, dim do
                    for l = k + 1, dim do
                        local v = {i, j, k, l}
                        for p = 1, 4 do
                            for q = 1, 4 do
                                m[p][q] = a[v[p]][v[q]]
                            end
                        end -- for p
                        c = c + det(m, 4)
                    end -- for l
                end -- for k
            end -- for j
        end -- for i  
    end -- if n   
    return c
end

function elim(a) -- a is an n x m matrix
    -- reduces a to echelon form   

    local max, t, ready
    local col -- the column which is in work
    local rows = #a
    if rows == 0 then
        return false
    end
    local cols = #a[1]
    if cols < rows then
        return false
    end
    for i = 1, rows do
        for j = 1, cols do
            if math.abs(a[i][j]) < 1.0e-4 then
                a[i][j] = 0
            end
        end
    end
    col = 0
    for i = 1, rows - 1 do
        ready = false
        while ready == false do
            col = col + 1
            if col > cols then
                return
            end
            max = i
            for j = i + 1, rows do
                if math.abs(a[j][col]) > math.abs(a[max][col]) then
                    max = j
                end
            end -- for j  
            if i ~= max then
                for k = 1, cols do -- swap rows i and max
                    a[i][k], a[max][k] = a[max][k], a[i][k]
                end -- for k
            end -- if   
            if a[i][col] ~= 0 then
                for j = i + 1, rows do
                    for k = cols, col, -1 do -- for k=col, a[j][col] becomes 0
                        a[j][k] = a[j][k] - a[i][k] * a[j][col] / a[i][col]
                        if math.abs(a[j][k]) < 1.0e-4 then
                            a[j][k] = 0
                        end
                    end -- for k
                end -- for j
                ready = true
            end -- if
        end -- while      
    end -- for i   

    return true
end -- eliminate

function substitute(a, result)
    local t
    local rows = #a
    local cols = #a[1]
    for r = rows + 1, cols do
        for i = 1, rows do
            result[i][r - rows] = 0
        end
        for j = #a, 1, -1 do
            t = 0.0
            for k = j + 1, rows do
                t = t + a[j][k] * result[k][r - rows]
            end -- for k    
            result[j][r - rows] = (a[j][r] - t) / a[j][j]
        end -- for j
    end -- for r      
end -- substitute

function inverse(a, b) -- a is a quadratic regular matrix
    -- returns the inverse of a on b
    local n = #a
    if det(a, n) == 0 then
        return false
    end
    if #a[1] ~= n then
        return false
    end
    local a1 = {}
    for i = 1, n do
        a1[i] = {}
        for j = 1, n do
            a1[i][j] = a[i][j]
            if j == i then
                a1[i][n + j] = 1
            else
                a1[i][n + j] = 0
            end
        end -- for j
    end -- for i
    -- eliminate(a1)
    elim(a1)
    substitute(a1, b)
    return true
end

function matMult(a, b, c) -- Multiplies n x m matrix a with mxk matrix  b, writes result to c
    local n = #a
    local m = #a[1]
    local k = #b[1]
    if m ~= #b then
        return "Dimension error in matMult"
    end
    for r = 1, n do
        for s = 1, k do
            c[r][s] = 0
        end
    end
    for r = 1, n do
        for s = 1, k do
            for i = 1, m do
                c[r][s] = c[r][s] + a[r][i] * b[i][s]
            end -- for i
        end -- for s
    end -- for r               
end -- mult

function pow(a, n, b) -- computes the nth power of matrix a, writes to b
    local mat1, mat2
    mat1 = {}
    for i = 1, #a do
        mat1[i] = {}
        for j = 1, #a do
            if i == j then
                b[i][j] = 1
            else
                b[i][j] = 0
            end
        end -- for j
    end -- for i   
    if n == 0 then
        return
    end
    for i = 1, n do
        for r = 1, #a do
            for s = 1, #a do
                mat1[r][s] = b[r][s]
            end -- copy b to mat1
        end
        matMult(a, mat1, b)
    end -- for i  
end -- pow

function norm(a) -- returns the sum norm of matrix a
    local res = 0
    for i = 1, #a do
        for j = 1, #a[1] do
            res = res + math.abs(a[i][j])
        end -- for j
    end -- for i
    return res
end
function rank(a) -- computes the rank of matrix a, leaves a untouched
    local count
    local rows = #a
    if rows == 0 then
        return 0
    end
    local cols = #a[1]
    if cols == 0 then
        return 0
    end
    if rows == 1 and cols == 1 then
        if a[1][1] == 0 then
            return 0
        else
            return 1
        end
    end
    local b = {}
    if rows <= cols then
        for i = 1, rows do
            b[i] = {}
            for j = 1, cols do
                b[i][j] = a[i][j]
            end -- for j
        end -- for i
    else
        for i = 1, cols do
            b[i] = {}
            for j = 1, rows do
                b[i][j] = a[j][i] -- b is the transpose of a
            end -- for j
        end -- for j
    end -- if                 
    elim(b)
    count = 0
    for i = 1, #b do
        for j = i, #b[1] do
            if math.abs(b[i][j]) > 1.0e-3 then
                count = count + 1
                break -- from j
            end -- if 
        end -- for j     
    end -- for i         
    return count
end

function kernel(a, c) -- returns a basis of the kernel of a on the columns of c, changes a
    local ran = rank(a)
    local ind
    local n = #a[1]
    if ran == n then
        for i = 1, #a do
            c[i][1] = 0
        end
        return 0
    end
    if norm(a) <= 1.0e-4 then
        for i = 1, n do
            c[i] = {}
            for j = 1, n do
                if i == j then
                    c[i][j] = 1
                else
                    c[i][j] = 0
                end -- if
            end -- for j
        end -- for i
        return n
    end
    cut(a)
    if ran == n - 1 and ran > 1 then
        local d = {}
        crossP(a, d)
        for i = 1, n do
            c[i][#c[i] + 1] = d[i]
        end
        return #c[1]
    end -- if
    if ran == 1 then
        for i = 1, n do
            if a[1][i] ~= 0 then
                ind = i
                break
            end -- if
        end -- for i
        for j = 1, ind - 1 do
            for i = 1, n do
                if i == j then
                    c[i][#c[i] + 1] = 1
                else
                    c[i][#c[i] + 1] = 0
                end -- if i==k      
            end -- for i
        end -- for j
        for j = ind + 1, n do
            for i = 1, n do
                if i ~= ind and i ~= j then
                    c[i][#c[i] + 1] = 0
                elseif i == ind then
                    c[i][#c[i] + 1] = -a[1][j]
                elseif i == j then
                    c[i][#c[i] + 1] = a[1][ind]
                end -- if    
            end -- for i
        end -- for j   
        return n - 1
    end -- if ran==1

    if ran == 2 then
        local indices = {}
        local d = {}
        for i = 1, 2 do
            d[i] = {}
        end
        local e = {}
        a[3] = {}
        local found = false
        for i = 1, n - 1 do
            for j = i + 1, n do
                if a[1][i] * a[2][j] - a[2][i] * a[1][j] ~= 0 then
                    indices[1] = i
                    indices[2] = j
                    for k = 1, n do
                        if k ~= i and k ~= j then
                            indices[3] = k
                            break
                        end -- if k   
                    end -- for k
                    table.sort(indices, function(x, y)
                        return (x < y)
                    end)
                    found = true
                    break -- from j-loop
                end -- if  a{1][i]    
            end -- for j
            if found then
                break
            end
        end -- for i

        for i = 1, 2 do
            for j = 1, 3 do
                d[i][j] = a[i][indices[j]]
            end --  for j
        end -- for i   
        crossP(d, e)

        for i = 1, n do
            c[i][1] = 0
            a[3][i] = 0
        end -- for i
        for i = 1, 3 do
            c[indices[i]][1] = e[i]
            a[3][indices[i]] = e[i]
        end -- for i

        kernel(a, c)
    end -- if ran==2

    if ran == 3 then
        local indices = {}
        local d = {}
        for i = 1, 3 do
            d[i] = {}
        end
        local e = {}
        a[4] = {}
        local found = false
        for i = 1, n - 2 do
            for j = i + 1, n - 1 do
                for k = j + 1, n do
                    if a[1][i] * (a[2][j] * a[3][k] - a[3][j] * a[2][k]) - a[2][i] *
                        (a[1][j] * a[3][k] - a[3][j] * a[1][k]) + a[3][i] * (a[1][j] * a[2][k] - a[2][j] * a[1][k]) ~= 0 then
                        indices[1] = i
                        indices[2] = j
                        indices[3] = k
                        for m = 1, n do
                            if m ~= i and m ~= j and m ~= k then
                                indices[4] = m
                                break
                            end
                        end -- for k
                        table.sort(indices, function(x, y)
                            return (x < y)
                        end)
                        found = true
                        break -- from k-loop
                    end -- if      
                end -- for k
                if found then
                    break
                end -- from j-loop
            end -- for j   
            if found then
                break
            end -- from i-loop
        end -- for i
        for i = 1, 3 do
            for j = 1, 4 do
                d[i][j] = a[i][indices[j]]
            end --  for j
        end -- for i   
        crossP(d, e)
        for i = 1, n do
            c[i][#c[i] + 1] = 0
            a[4][i] = 0
        end -- for i
        for i = 1, 4 do
            c[indices[i]][#c[1]] = e[i]
            a[4][indices[i]] = e[i]
        end -- for i
        kernel(a, c)
    end -- if ran==3  

    if ran == 4 then
        local indices = {}
        local d = {}
        local mat = {}
        for i = 1, 4 do
            mat[i] = {}
        end
        for i = 1, 4 do
            d[i] = {}
        end
        local e = {}
        a[5] = {}
        local found = false
        for i = 1, n - 3 do
            for j = i + 1, n - 2 do
                for k = j + 1, n - 1 do
                    for l = k + 1, n do
                        indices[1] = i
                        indices[2] = j
                        indices[3] = k
                        indices[4] = l
                        for r = 1, 4 do
                            for s = 1, 4 do
                                mat[r][s] = a[r][indices[s]]
                            end -- for s
                        end -- for r
                        if det(mat, 4) ~= 0 then
                            for m = 1, n do
                                if m ~= i and m ~= j and m ~= k and m ~= l then
                                    indices[5] = m
                                    break
                                end
                            end -- for m
                            table.sort(indices, function(x, y)
                                return (x < y)
                            end)
                            found = true
                            break -- from l-loop
                        end -- if det      
                    end -- for l
                    if found then
                        break
                    end -- from k-loop   
                end ---for k
                if found then
                    break
                end -- from j-loop      
            end -- for j   
            if found then
                break
            end -- from i-loop
        end -- for i
        for i = 1, 4 do
            for j = 1, 5 do
                d[i][j] = a[i][indices[j]]
            end --  for j
        end -- for i   
        crossP(d, e)
        for i = 1, n do
            c[i][#c[i] + 1] = 0
            a[5][i] = 0
        end -- for i
        for i = 1, 5 do
            c[indices[i]][#c[1]] = e[i]
            a[5][indices[i]] = e[i]
        end -- for i
        kernel(a, c)
    end -- if ran==4           
end

function cut(a) -- cuts out rows of a which are linearly dependent on the others
    local b
    if norm(a) == 0 then
        return 0
    end
    local ran = rank(a)
    local rows = #a
    local cols = #a[1]
    while #a > ran do
        for i = 1, #a do
            b = {}
            local k = 0
            for i1 = 1, #a do
                if i1 ~= i then -- leave out the i-th row
                    k = k + 1
                    b[k] = {}
                    for j = 1, cols do
                        b[k][j] = a[i1][j]
                    end
                end -- if   
            end -- for i1
            if rank(b) == ran then -- rank not diminished by clipping of i-th row
                table.remove(a, i)
                break
            end -- if 
        end -- for i   
    end -- while
    collectgarbage()
    return ran
end

function realCyclic(number) -- establishes a cyclic base for real eigenvalue number "number"
    local eigval = realE[number][1]
    local mult = realE[number][2]
    local a = {} -- a=A-eigval*id
    local b = {} -- b[k] is the k-th power of a
    local dimKerPow = {} -- the dimension of the kernel of powers of (A-eigval*id)
    local s = {} -- s[i] is the number of Jordan blocks of size i
    local nilInd -- the index of nilpotence of a
    local U = {} -- U[k] is a basis of the kernel of a^k 
    local W = {} -- is a collection of linarly independent vectors such that U[k]=U[k-1] +(direct sum) W[k]
    local indices = {}
    local offset = 0
    for i = 1, number - 1 do
        offset = offset + realE[i][2]
    end
    for i = 1, dim do -- a = A-eigval*id
        a[i] = {}
        for j = 1, dim do
            if i == j then
                a[i][j] = A[i][j] - eigval
            else
                a[i][j] = A[i][j]
            end -- if   
        end -- for j
    end -- for i
    for k = 1, mult do
        b[k] = {}
        for i = 1, dim do
            b[k][i] = {}
            for j = 1, dim do
                b[k][i][j] = 0
            end -- for j 
        end -- for i  
    end -- for k
    for k = 1, mult do
        pow(a, k, b[k])
        dimKerPow[k] = dim - rank(b[k])
    end -- for k  
    local x = rank(b[1])
    dimKerPow[0] = 0
    dimKerPow[mult + 1] = dimKerPow[mult]
    for k = 1, mult do
        if dimKerPow[k] == dimKerPow[k + 1] then
            nilInd = k
            break
        end
    end -- for k
    for k = 1, mult do
        s[k] = 2 * dimKerPow[k] - dimKerPow[k + 1] - dimKerPow[k - 1]
    end -- k
    for k = 1, dim do
        U[k] = {}
        for i = 1, dim do
            U[k][i] = {}
        end
    end
    for k = 1, nilInd do
        kernel(b[k], U[k]) ------------fill U[k]
    end -- for k

    if nilInd == 1 then
        for k = 1, dimKerPow[1] do
            for i = 1, dim do
                S[i][offset + k] = U[1][i][k]
            end -- for i   
        end
        return true
    end -- if
    ---------------------------------------------------------------------------------------------------------------------------   
    if nilInd == 2 then
        W[2] = {}
        for i = 1, dim do
            W[2][i] = {}
        end -- for i   
        -- complete the elements of U[1] to a basis of U[2], store new vectors in W[2]
        local h = {}
        for i = 1, dim do
            h[i] = {}
        end -- for i
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h[i][j] = U[1][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][#h[i] + 1] = U[2][i][j]
            end -- for i  
            if rank(h) == dimKerPow[1] + #W[2][1] + 1 then
                for i = 1, dim do
                    table.insert(W[2][i], U[2][i][j])
                end -- for i
            end -- if   
            if #W[2][1] == dimKerPow[2] - dimKerPow[1] then
                break
            end
        end -- for j
        -- find the indices of elements of U[1] not in a*W[2] , store their indices in indices[1} 
        for i = 1, dim do
            h[i] = {}
            for k = 1, #W[2][1] do
                h[i][k] = 0
            end -- for k   
        end -- for i
        matMult(a, W[2], h)
        indices[1] = {}
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h[i][#h[i] + 1] = U[1][i][j]
            end -- for i   
            if rank(h) == #W[2][1] + #indices[1] + 1 then
                table.insert(indices[1], j)
            end -- if      
        end -- for j
        -- fill the transformation Matrix
        -- new elements from U[1]      
        for j = 1, #indices[1] do
            for i = 1, dim do
                S[i][offset + j] = U[1][i][indices[1][j]]
            end -- for i
        end
        -- elements in A*W[2]     
        for j = 1, #W[2][1] do
            for i = 1, dim do
                S[i][offset + #indices[1] + j * 2 - 1] = h[i][j]
            end -- for i
        end -- for j 
        -- elements from W[2]
        for j = 1, #W[2][1] do
            for i = 1, dim do
                S[i][offset + #indices[1] + j * 2] = W[2][i][j]
            end -- for i
        end -- for j   
        return true
    end -- if nilInd==2
    ------------------------------------------------------------------------------------------------------------   
    if nilInd == 3 then
        for k = 2, 3 do
            W[k] = {}
            for i = 1, dim do
                W[k][i] = {}
            end -- for i
        end -- for k    
        -- complete U[2] to form a basis of [U[3], store the new elements in W[3]
        local h = {}
        for i = 1, dim do
            h[i] = {}
        end -- for i
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][j] = U[2][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[3] do
            for i = 1, dim do
                h[i][dimKerPow[2] + j] = U[3][i][j]
            end -- for i   
            if rank(h) == dimKerPow[2] + #W[3][1] + 1 then
                for i = 1, dim do
                    table.insert(W[3][i], U[3][i][j])
                end -- for i
            end -- if
            if #W[3][1] == dimKerPow[3] - dimKerPow[2] then
                break
            end
        end -- for j

        -- complete the elements of U[1] to form a basis of U[2], store the new elements in W[2]

        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h[i][j] = U[1][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][dimKerPow[1] + j] = U[2][i][j]
            end -- for i
            if rank(h) == dimKerPow[1] + #W[2][1] + 1 then
                for i = 1, dim do
                    table.insert(W[2][i], U[2][i][j])
                end -- for i
            end -- if
            if #W[2][1] == dimKerPow[2] - dimKerPow[1] then
                break
            end
        end -- for j           
        -- find the elements of W[2] not in U[1]+(direct sum) a*W[3] , store their indices on indices[2] #################hier weitermachen

        indices[2] = {}
        local h31 = {}
        local h32 = {}
        for i = 1, dim do
            h31[i] = {}
            h32[i] = {}
            for k = 1, #W[3][1] do
                h31[i][k] = 0
                h32[i][k] = 0
            end -- for k   
        end -- for i
        matMult(a, W[3], h31)
        matMult(a, h31, h32)
        for j = 1, #U[1][1] do
            for i = 1, dim do
                h31[i][#W[3][1] + j] = U[1][i][j]
            end
        end
        for j = 1, #W[2][1] do
            for i = 1, dim do
                h31[i][#h31[i] + 1] = W[2][i][j]
            end -- for i  
            if rank(h31) == #U[1][1] + #W[3][1] + #indices[2] + 1 then
                table.insert(indices[2], j)
            end -- if      
        end -- for j
        -- find the elements of  U[1] not in a*W[2], store their indices on indices[1]
        indices[1] = {}
        local h2 = {}
        for i = 1, dim do
            h2[i] = {}
            for k = 1, #W[2][1] do
                h2[i][k] = 0
            end -- for k
        end -- for i      
        matMult(a, W[2], h2)
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h2[i][#h2[i] + 1] = U[1][i][j]
            end -- for i
            if rank(h2) == #W[2][1] + #indices[1] + 1 then
                table.insert(indices[1], j)
            end -- if   
        end -- for j            
        -- fill the transformation Matrix

        -- new elements from U[1]    
        local x1 = #indices[1]
        for j = 1, #indices[1] do
            for i = 1, dim do
                S[i][offset + j] = U[1][i][indices[1][j]]
            end -- for i
        end
        -- elements from a*(W[2]\a*W[3])   
        for i = 1, dim do
            h[i] = {}
        end
        for i = 1, dim do
            for j = 1, #indices[2] do
                h[i][j] = 0
                for k = 1, dim do
                    h[i][j] = h[i][j] + a[i][k] * W[2][k][indices[2][j]]
                end -- for k
            end -- for j
        end -- for i

        for j = 1, #indices[2] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * j - 1] = h[i][j]
            end -- for i
        end -- for j 
        -- elements from W[2] not in a*W[3]
        for j = 1, #indices[2] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * j] = W[2][i][indices[2][j]]
            end -- for i
        end -- for j
        -- elements from a^2*W[3], a*W[3] and W[3]
        for j = 1, #W[3][1] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * #indices[2] + 3 * j - 2] = h32[i][j]
                S[i][offset + #indices[1] + 2 * #indices[2] + 3 * j - 1] = h31[i][j]
                S[i][offset + #indices[1] + 2 * #indices[2] + 3 * j] = W[3][i][j]
            end -- for i
        end -- for j      
    end -- if nilInd==3   
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

    if nilInd == 4 then
        for k = 2, 4 do
            W[k] = {}
            for i = 1, dim do
                W[k][i] = {}
            end -- for i
        end -- for k      

        local h = {}
        -- complete U[3] to   form a basis of U[4], store the new elements in W[4]
        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[3] do
            for i = 1, dim do
                h[i][j] = U[3][i][j]
            end
        end -- for j     
        for j = 1, dimKerPow[4] do
            for i = 1, dim do
                h[i][dimKerPow[3] + j] = U[4][i][j]
            end -- for i   
            if rank(h) == dimKerPow[3] + #W[4][1] + 1 then
                for i = 1, dim do
                    table.insert(W[4][i], U[4][i][j])
                end -- for i
            end -- if
            if #W[4][1] == dimKerPow[4] - dimKerPow[3] then
                break
            end
        end -- for j   
        -- complete U[2] to form a basis of [U[3], store the new elements in W[3]         
        for i = 1, dim do
            h[i] = {}
        end -- for i
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][j] = U[2][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[3] do
            for i = 1, dim do
                h[i][dimKerPow[2] + j] = U[3][i][j]
            end -- for i   
            if rank(h) == dimKerPow[2] + #W[3][1] + 1 then
                for i = 1, dim do
                    table.insert(W[3][i], U[3][i][j])
                end -- for i
            end -- if
            if #W[3][1] == dimKerPow[3] - dimKerPow[2] then
                break
            end
        end -- for j

        -- complete the elements of U[1] to form a basis of U[2], store the new elements in W[2]
        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h[i][j] = U[1][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][dimKerPow[1] + j] = U[2][i][j]
            end -- for i
            if rank(h) == dimKerPow[1] + #W[2][1] + 1 then
                for i = 1, dim do
                    table.insert(W[2][i], U[2][i][j])
                end -- for i
            end -- if
            if #W[2][1] == dimKerPow[2] - dimKerPow[1] then
                break
            end
        end -- for j           

        -- find the elements of W[2] not in U[1]+(direct sum) a*W[3] , store their indices on indices[2] 
        indices[2] = {}
        local h31 = {}
        local h32 = {}
        for i = 1, dim do
            h31[i] = {}
            h32[i] = {}
            for k = 1, #W[3][1] do
                h31[i][k] = 0
                h32[i][k] = 0
            end -- for k   
        end -- for i
        matMult(a, W[3], h31)
        matMult(a, h31, h32)
        for j = 1, #U[1][1] do
            for i = 1, dim do
                h31[i][#W[3][1] + j] = U[1][i][j]
            end
        end
        for j = 1, #W[2][1] do
            for i = 1, dim do
                h31[i][#h31[i] + j] = W[2][i][j]
            end -- for i   
            if rank(h31) == #U[1][1] + #W[3][1] + #indices[2] + 1 then
                table.insert(indices[2], j)
            end -- if      
        end -- for j
        -- find the elements of  U[1] not in a*W[2], store their indices on indices[1]
        indices[1] = {}
        local h2 = {}
        for i = 1, dim do
            h2[i] = {}
            for k = 1, #W[2][1] do
                h2[i][k] = 0
            end -- for k
        end -- for i      
        matMult(a, W[2], h2)
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h2[i][#h2[i] + 1] = U[1][i][j]
            end -- for i
            if rank(h2) == #W[2][1] + #indices[1] + 1 then
                table.insert(indices[1], j)
            end -- if   
        end -- for j      

        -- fill the transformation Matrix

        -- new elements from U[1]      
        for j = 1, #indices[1] do
            for i = 1, dim do
                S[i][offset + j] = U[1][i][indices[1][j]]
            end -- for i
        end
        -- elements from a*(W[2]\a*W[3])   
        for i = 1, dim do
            h[i] = {}
        end
        for i = 1, dim do
            for j = 1, #indices[2] do
                h[i][j] = 0
                for k = 1, dim do
                    h[i][j] = h[i][j] + a[i][k] * W[2][k][indices[2][j]]
                end -- for k
            end -- for j
        end -- for i

        for j = 1, #indices[2] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * j - 1] = h[i][j]
            end -- for i
        end -- for j 
        -- elements from W[2] not in a*W[3]
        for j = 1, #indices[2] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * j] = W[2][i][indices[2][j]]
            end -- for i
        end -- for j
        -- elements from a^3*W[4], a^2*W[4], a*W[4] and W[4]#######################################
        h41 = {}
        h42 = {}
        h43 = {}
        for i = 1, dim do
            h41[i] = {}
            h42[i] = {}
            h43[i] = {}
            for k = 1, #W[4][1] do
                h41[i][k] = 0
                h42[i][k] = 0
                h43[i][k] = 0
            end -- for k
        end -- for i   
        matMult(a, W[4], h41)
        matMult(a, h41, h42)
        matMult(a, h42, h43)
        for j = 1, #W[4][1] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 2 * #indices[2] + 4 * j - 3] = h43[i][j]
                S[i][offset + #indices[1] + 2 * #indices[2] + 4 * j - 2] = h42[i][j]
                S[i][offset + #indices[1] + 2 * #indices[2] + 4 * j - 1] = h41[i][j]
                S[i][offset + #indices[1] + 2 * #indices[2] + 4 * j] = W[4][i][j]
            end -- for i
        end -- for j      
    end -- if nilInd==4    

    -----------------------------------------------------------------------------------------------------------------------------------------     
    if nilInd == 5 then
        for k = 2, 5 do
            W[k] = {}
            for i = 1, dim do
                W[k][i] = {}
            end -- for i
        end -- for k      

        local h = {}
        -- complete U[4] to   form a basis of U[5], store the new elements in W[5]
        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[4] do
            for i = 1, dim do
                h[i][j] = U[4][i][j]
            end
        end -- for j     
        for j = 1, dimKerPow[5] do
            for i = 1, dim do
                h[i][dimKerPow[4] + j] = U[5][i][j]
            end -- for i   
            if rank(h) == dimKerPow[4] + #W[5][1] + 1 then
                for i = 1, dim do
                    table.insert(W[5][i], U[5][i][j])
                end -- for i
            end -- if
            if #W[5][1] == dimKerPow[5] - dimKerPow[4] then
                break
            end
        end -- for j   

        -- complete U[3] to   form a basis of U[4], store the new elements in W[4]
        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[3] do
            for i = 1, dim do
                h[i][j] = U[3][i][j]
            end
        end -- for j     
        for j = 1, dimKerPow[4] do
            for i = 1, dim do
                h[i][dimKerPow[3] + j] = U[4][i][j]
            end -- for i   
            if rank(h) == dimKerPow[3] + #W[4][1] + 1 then
                for i = 1, dim do
                    table.insert(W[4][i], U[4][i][j])
                end -- for i
            end -- if
            if #W[4][1] == dimKerPow[4] - dimKerPow[3] then
                break
            end
        end -- for j             
        -- complete U[2] to form a basis of [U[3], store the new elements in W[3]         
        for i = 1, dim do
            h[i] = {}
        end -- for i
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][j] = U[2][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[3] do
            for i = 1, dim do
                h[i][dimKerPow[2] + j] = U[3][i][j]
            end -- for i   
            if rank(h) == dimKerPow[2] + #W[3][1] + 1 then
                for i = 1, dim do
                    table.insert(W[3][i], U[3][i][j])
                end -- for i
            end -- if
            if #W[3][1] == dimKerPow[3] - dimKerPow[2] then
                break
            end
        end -- for j

        -- complete the elements of U[1] to form a basis of U[2], store the new elements in W[2]
        for i = 1, dim do
            h[i] = {}
        end
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h[i][j] = U[1][i][j]
            end -- for i
        end -- for j
        for j = 1, dimKerPow[2] do
            for i = 1, dim do
                h[i][dimKerPow[1] + j] = U[2][i][j]
            end -- for i
            if rank(h) == dimKerPow[1] + #W[2][1] + 1 then
                for i = 1, dim do
                    table.insert(W[2][i], U[2][i][j])
                end -- for i
            end -- if
            if #W[2][1] == dimKerPow[2] - dimKerPow[1] then
                break
            end
        end -- for j           

        -- find the elements of  U[1] not in a*W[2], store their indices on indices[1]
        indices[1] = {}
        local h2 = {}
        for i = 1, dim do
            h2[i] = {}
            for k = 1, #W[2][1] do
                h2[i][k] = 0
            end -- for k
        end -- for i      
        matMult(a, W[2], h2)
        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                h2[i][#h2[i] + 1] = U[1][i][j]
            end -- for i
            if rank(h2) == #W[2][1] + #indices[1] + 1 then
                table.insert(indices[1], j)
            end -- if   
        end -- for j      

        -- fill the transformation Matrix

        -- new elements from U[1]   

        for j = 1, #indices[1] do
            for i = 1, dim do
                S[i][offset + j] = U[1][i][indices[1][j]]
            end -- for i
        end

        -- elements from a^4*W[5], a^3*W[5], a^2*W[5], a*W[5] and W[5]#######################################
        h51 = {};
        h52 = {};
        h53 = {};
        h54 = {}
        for i = 1, dim do
            h51[i] = {};
            h52[i] = {};
            h53[i] = {};
            h54[i] = {}
            for k = 1, #W[4][1] do
                h51[i][k] = 0;
                h52[i][k] = 0;
                h53[i][k] = 0;
                h54[i][k] = 0
            end -- for k
        end -- for i   
        matMult(a, W[5], h51)
        matMult(a, h51, h52)
        matMult(a, h52, h53)
        matMult(a, h53, h54)
        for j = 1, #W[5][1] do
            for i = 1, dim do
                S[i][offset + #indices[1] + 5 * j - 4] = h54[i][j]
                S[i][offset + #indices[1] + 5 * j - 3] = h53[i][j]
                S[i][offset + #indices[1] + 5 * j - 2] = h52[i][j]
                S[i][offset + #indices[1] + 5 * j - 1] = h51[i][j]
                S[i][offset + #indices[1] + 5 * j] = W[5][i][j]
            end -- for i
        end -- for j      
    end -- if nilInd==5        
end --

function compCyclic(number) -- establishes a cyclic base for complex eigenvalue number "number"
    local eigvre = compE[number][1]
    local eigvim = compE[number][2]
    local mult = compE[number][3]
    local a = {} -- a=(A-eigvre*id)^2+eigvim^2*id
    local b = {} -- b[k] is the k-th power of a
    local c = {} -- c=A-eigvre*id
    local h = {} -- a matrix for the storage of intermediate results
    local dimKerPow = {} -- the dimension of the kernel of powers of (A-eigvre*id)^2+eigvim^2*id
    local s = {} -- s[i] is the number of Jordan blocks of size i
    local nilInd -- the index of nilpotence of a
    local U = {} -- U[k] is a basis of the kernel of a^k 
    local W = {} -- is a collection of linarly independent vectors such that U[k]=U[k-1] +(direct sum) W[k]
    local E = {}
    local k0
    local indices = {}
    local offset = 0
    for i = 1, #realE do
        offset = offset + realE[i][2]
    end -- for i
    for i = 1, number - 1 do
        offset = offset + 2 * compE[i][3] -----------------------------------------
    end
    for i = 1, dim do -- a = (A-eigvre*id)^2+eigvim^2*id
        a[i] = {}
        c[i] = {}
        for j = 1, dim do
            if i == j then
                c[i][j] = A[i][j] - eigvre
            else
                c[i][j] = A[i][j]
            end -- if   
        end -- for j
    end -- for i
    matMult(c, c, a)
    for i = 1, dim do
        a[i][i] = a[i][i] + eigvim * eigvim
    end -- for i
    for k = 1, mult do
        b[k] = {}
        for i = 1, dim do
            b[k][i] = {}
            for j = 1, dim do
                b[k][i][j] = 0
            end -- for j 
        end -- for i  
        pow(a, k, b[k])
        for i = 1, dim do
            for j = 1, dim do
                if math.abs(b[k][i][j]) < 1.0e-3 then
                    b[k][i][j] = 0
                end
            end -- for j
        end -- for i      
        dimKerPow[k] = dim - rank(b[k])
    end -- for k   
    local x = dimKerPow[1]
    dimKerPow[0] = 0
    dimKerPow[mult + 1] = dimKerPow[mult]
    for k = 1, mult do
        if dimKerPow[k] == dimKerPow[k + 1] then
            nilInd = k
            break
        end
    end -- for k
    local x = dimKerPow[1]
    for k = 1, mult do
        s[k] = dimKerPow[k] - dimKerPow[k + 1] / 2 - dimKerPow[k - 1] / 2
    end -- k
    for k = 1, nilInd do
        U[k] = {}
        for i = 1, dim do
            U[k][i] = {}
        end -- for i    
        kernel(b[k], U[k]) ------------fill U[k]
    end -- for k
    store(U[1], "u1")

    if nilInd == 1 then
        for k = 1, dimKerPow[1] do
            E[k] = {}
        end
        for i = 1, dim do
            E[1][i] = {}
            E[1][i][1] = 0
            E[1][i][2] = U[1][i][1]
            for j = 1, dim do
                E[1][i][1] = E[1][i][1] + c[i][j] * U[1][j][1] / eigvim
            end -- for j
        end

        if dimKerPow[1] > 2 then
            for i = 1, dim do
                h[i] = {}
                for j = 1, 2 do
                    h[i][j] = E[1][i][j]
                end -- for j
            end -- for i
            for k = 2, #U[1][1] do
                for i = 1, dim do
                    h[i][3] = U[1][i][k]
                end -- for i 
                if rank(h) > 2 then
                    k0 = k
                    break
                end -- if   
            end -- for k
            for i = 1, dim do
                E[1][i][3] = 0
                E[1][i][4] = U[1][i][k0]
                for j = 1, dim do
                    E[1][i][3] = E[1][i][3] + c[i][j] * U[1][i][k0] / eigvim
                end
            end -- for i  
        end -- if dimkerPow[1]>2     

        for j = 1, dimKerPow[1] do
            for i = 1, dim do
                S[i][offset + j] = E[1][i][j]
            end -- for i
        end -- for j    

    end -- if nilInd==1
    if nilInd == 2 then
        E = {}
        for i = 1, dim do
            h[i] = {}
        end
        for k = 1, #U[1][1] do
            for i = 1, dim do
                h[i][k] = U[1][i][k]
            end -- for i
        end -- for k
        for k = 1, #U[2][1] do
            for i = 1, dim do
                table.insert(h[i], U[2][i][k])
            end
            if rank(h) > #U[1][1] then
                for i = 1, dim do
                    E[i] = {}
                    for j = 1, 3 do
                        E[i][j] = 0
                    end
                    E[i][4] = U[2][i][k]
                end -- for i
                break -- from k         
            end -- if         
        end -- for k
        for i = 1, dim do
            for k = 1, dim do
                E[i][3] = E[i][3] + c[i][k] * E[k][4] / eigvim
            end -- for k
        end -- for i
        for i = 1, dim do
            for k = 1, dim do
                E[i][2] = E[i][2] + c[i][k] * E[k][3]
            end -- for k
            E[i][2] = E[i][2] + eigvim * E[i][4]
        end -- for i   
        for i = 1, dim do
            for k = 1, dim do
                E[i][1] = E[i][1] + c[i][k] * E[k][2] / eigvim
            end -- for k
        end
        for j = 1, 4 do
            for i = 1, dim do
                S[i][offset + j] = E[i][j]
            end -- for i
        end -- for j  
    end -- if nilInd=02
end -- compCyclic(number)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------- utility procedures ------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    end
    return 0
end
function store(matr, name)
    local text = name .. ":=["
    for i = 1, #matr do
        text = text .. "["
        for j = 1, #matr[i] - 1 do
            text = text .. tostring(matr[i][j]) .. ","
        end -- for j
        text = text .. tostring(matr[i][#matr[i]]) .. "]"
    end -- for i
    text = text .. "]"
    math.eval("delvar" .. name)
    math.eval(text)

end

function jordan() -- for each eigenvalue, create the Jordan blocks
    local Si = {} -- the inverse of the transformation matrix S
    local J1 = {} -- a matrix that takes intermediate values
    for i = 1, #realE do
        realCyclic(i)
    end
    for i = 1, #compE do
        compCyclic(i)
    end

    for i = 1, dim do
        J[i] = {};
        Si[i] = {};
        J1[i] = {}
        for j = 1, dim do
            J[i][j] = 0;
            Si[i][j] = 0;
            J1[i][j] = 0
            if math.abs(S[i][j]) < 0.5e-3 then
                S[i][j] = 0
            end
        end -- for j
    end -- for i
    store(S, "s")
    inverse(S, Si) ----
    store(Si, "si")
    matMult(A, S, J1)
    matMult(Si, J1, J)
    store(J, "j")

end

function sortE() -- sorts the eigenvalues and determines their multiplicity
    realE = {}
    compE = {}
    collectgarbage()
    for i = 1, dim do
        valr[i] = sign(valr[i]) * math.floor(math.abs(valr[i]) * 1e4 + 0.5) / 1e4 -- round to 4 decimal places
        vali[i] = sign(vali[i]) * math.floor(math.abs(vali[i]) * 1e4 + 0.5) / 1e4
        if vali[i] == 0 then
            table.insert(realE, {valr[i], 1})
        elseif vali[i] > 0 then -- Because complex eigenvalues come in conjugate pairs, only positive imaginary parts have to be stored
            table.insert(compE, {valr[i], vali[i], 1})
        end -- if   
    end -- for i
    if #realE >= 2 then
        table.sort(realE, function(x, y)
            return (x[1] < y[1])
        end)
    end
    if #compE >= 2 then
        table.sort(compE, function(x, y)
            return ((x[1] < y[1]) or (x[1] == y[1] and x[2] < y[2]))
        end)
    end
    local i = 2
    while i <= #realE do
        if realE[i][1] == realE[i - 1][1] then
            realE[i - 1][2] = realE[i - 1][2] + 1
            table.remove(realE, i)
        else
            i = i + 1
        end -- if
    end -- while
    i = 2
    while i <= #compE do
        if compE[i][1] == compE[i - 1][1] and compE[i][2] == compE[i - 1][2] then
            compE[i - 1][3] = compE[i - 1][3] + 1
            table.remove(compE, i)
        else
            i = i + 1
        end -- if
    end -- while                     
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------- key events---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function on.arrowRight()
    if modus == matrix then
        local row = 0
        local col = 0
        for i = 1, 5 do
            for j = 1, 5 do
                if matWin.box[i][j]:hasFocus() then
                    row = i;
                    col = j;
                    break
                end -- if   
            end -- for j
        end -- for i      
        if col < dim then
            matWin.box[row][col + 1]:setFocus(true)
        end
    end
    screen:invalidate()
end -- on.arrowRight

---[[

function on.arrowLeft()
    if modus == matrix then
        local row = 0
        local col = 0
        for i = 1, 5 do
            for j = 1, 5 do
                if matWin.box[i][j]:hasFocus() then
                    row = i;
                    col = j;
                    break
                end -- if   
            end -- for j
        end -- for i      
        if col >= 2 then
            matWin.box[row][col - 1]:setFocus(true)
        end
    end
    screen:invalidate()
end -- on.arrowLeft
---]]
function on.arrowUp()
    if modus == matrix then
        local row = 0
        local col = 0
        for i = 1, 5 do
            for j = 1, 5 do
                if matWin.box[i][j]:hasFocus() then
                    row = i;
                    col = j;
                    break
                end -- if   
            end -- for j
        end -- for i      
        if row >= 2 then
            matWin.box[row - 1][col]:setFocus(true)
        end -- if row        
    end -- if modus   
    screen:invalidate()
end -- on.arrowUp

function on.arrowDown()
    if modus == matrix then
        local row = 0
        local col = 0
        for i = 1, 5 do
            for j = 1, 5 do
                if matWin.box[i][j]:hasFocus() then
                    row = i;
                    col = j;
                    break
                end -- if   
            end -- for j
        end -- for i      
        if row < dim then
            matWin.box[row + 1][col]:setFocus(true)
        end -- if row        
    end -- if modus   

    screen:invalidate()
end -- on.arrowDown

function on.tabKey()
    if modus == matrix then
        matWin:swapFocus()
        matWin:setMessage("")
    end
    screen:invalidate()
end -- on.tabKey

function on.enterKey()
    if modus == dimension then
        modus = matrix
        initM(dim)
        -- A={{1,-2,0,-1,2},{1,-3,-1,0,3},{0,2,1,-1,-3},{1,0,0,-1,-2},{0,-1,0,0,2}}

        -- A={{25,-16,30,-44,-12},{13,-7,18,-26,-6},{-18,12,-21,36,12},{-9,6,-12,21,6},{11,-8,15,-22,-3}}
        -- A={{6,-2,6,1,1},{1,-1,2,1,-2},{-2,0,-1,0,-1},{-1,0,-2,2,-1},{-4,4,-6,-2,3}}

        matWin:setValues()
        matWin.box[1][1]:setFocus(true)
    elseif modus == matrix then
        local matr = {}
        trans = false
        local err = false
        for i = 1, dim do
            matr[i] = {}
            for j = 1, dim do
                matr[i][j] = 0
            end
        end
        matWin:getInput(matr)
        for i = 1, dim do
            for j = 1, dim do
                if matr[i][j] == nil then
                    matWin:setMessage("Invalid input for A[" .. i .. "][" .. j .. "]")
                    matWin.box[i][j]:setFocus()
                    err = true
                    break
                end
            end -- for j      
            if err then
                break
            end
        end -- for i
        if not err then
            for i = 1, dim do
                for j = 1, dim do
                    A[i][j] = matr[i][j]
                end -- for j
            end -- for i 

            store(A, "a")
            math.eval("eigenvalues:=eigvl(a)")
            valr = math.eval("real(eigenvalues)")
            vali = math.eval("imag(eigenvalues)")
            sortE()
            jordan()
            modus = show
            matWin:hide()
        end -- if
    end -- if modus               
    screen:invalidate()
end -- on.enterKey

function on.escapeKey()
    if modus == matrix then
        modus = dimension
        matWin:hide()
    elseif modus == show then
        modus = matrix
        trans = false
        matWin:setValues()
        matWin.box[1][1]:setFocus(true)
    end
end -- on.escapeKey()    

function on.charIn(char)
    if char == "2" then
        if modus == dimension then
            dim = 2
        end
    elseif char == "3" then
        if modus == dimension then
            dim = 3
        end
    elseif char == "4" then
        if modus == dimension then
            dim = 4
        end
    elseif char == "5" then
        if modus == dimension then
            dim = 5
        end
    elseif char == "t" then
        trans = not trans
    end

    screen:invalidate()

end -- on.charIn

function on.mouseDown(x, y)
    if x == 0 and y == 0 then
        on.enterKey()
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------Menu functions and definition of menu-------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  

function setMat(x)
    dim = x
    if x == 6 then
        dim = 3
    end
    modus = matrix
    initM(dim)
    if x == 2 then
        A = {{8, -4}, {5, 7}}
    elseif x == 3 then
        A = {{3, 4, 3}, {-1, 0, -1}, {1, 2, 3}}
    elseif x == 4 then
        A = {{2, 1, 0, 1}, {0, 3, 0, 0}, {-1, 1, 3, 1}, {-1, 1, 0, 4}}
    elseif x == 5 then
        A = {{6, -2, 6, 1, 1}, {1, -1, 2, 1, -2}, {-2, 0, -1, 0, -1}, {-1, 0, -2, 2, -1}, {-4, 4, -6, -2, 3}}
    elseif x == 6 then
        A = {{-0.354, -0.866, 0.354}, {0.612, -0.5, -0.612}, {0.707, 0, 0.707}}
    end
    matWin:setValues()
    matWin.box[1][1]:setFocus(true)
    screen:invalidate()
end

menu = {{"Matrix size", {"2x2", function()
    modus = dimension;
    on.charIn("2")
end}, {"3x3", function()
    modus = dimension;
    on.charIn("3")
end}, {"4x4", function()
    modus = dimension;
    on.charIn("4")
end}, {"5x5", function()
    modus = dimension;
    on.charIn("5")
end}}, {"Examples", {"2x2", function()
    setMat(2)
end}, {"3x3", function()
    setMat(3)
end}, {"4x4", function()
    setMat(4)
end}, {"5x5", function()
    setMat(5)
end}, {"Rotation", function()
    setMat(6)
end}}} -- menu
toolpalette.register(menu)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- class mWindow ---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
mWindow = class() -- a frame with 25 rich text fields that allow the user to input a matrix

function mWindow:init(x, y, width, height, name)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.box = {}
    for i = 1, 6 do
        self.box[i] = {}
    end
    self.message = ""
    self.name = name or ""
    for i = 1, 5 do
        for j = 1, 5 do
            self.box[i][j] = D2Editor.newRichText()
            self.box[i][j]:move(self.x + 0.03 * W + (j - 1) * 0.18 * W, self.y + 0.1 * H + (i - 1) * 0.15 * H)
            self.box[i][j]:resize(W / 6, H / 8.3)
            self.box[i][j]:setBorderColor(0)
            self.box[i][j]:setBorder(0)
            self.box[i][j]:setFontSize(0.05 * H)
            self.box[i][j]:setTextColor(000 * 000 * 000)
            self.box[i][j]:setVisible(false)
            self.box[i][j]:registerFilter{
                enterKey = function()
                    on.enterKey()
                end
            }
            self.box[i][j]:setTextChangeListener(function()
                self:setMessage("")
            end)
        end -- for j
    end -- for i     
end

function mWindow:paint(gc)
    ---gc:clipRect("set",self.x,self.y,self.width,self.height)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("serif", "r", H * 0.05)
    gc:drawRect(self.x, self.y, self.width, self.height)
    gc:drawString("Matrix " .. self.name, self.x + 5, self.y + 0.01 * H, "top")
    if self.message == "" then
        gc:setFont("serif", "r", H * 0.05)
        gc:drawString("Press Enter to accept or Esc to cancel", self.x + 5, self.y + 0.9 * H, "top")
    else
        gc:setFont("serif", "b", H * 0.05)
        gc:drawString(self.message, self.x + 5, self.y + 0.89 * H, "top")
    end

end

function mWindow:hide()
    for i = 1, dim do
        for j = 1, dim do
            self.box[i][j]:setVisible(false)
            self.box[i][j]:setFocus(false)
        end -- for j
    end -- for i   
end

function mWindow:swapFocus()
    local row = 0
    local col = 0
    for i = 1, 5 do
        for j = 1, 5 do
            if self.box[i][j]:hasFocus() then
                row = i;
                col = j;
                break
            end -- if   
        end -- for j
    end -- for i      
    if col < dim then
        self.box[row][col + 1]:setFocus(true)
    elseif col == dim and row < dim then
        self.box[row + 1][1]:setFocus(true)
    else
        self.box[1][1]:setFocus(true)
    end

end -- function swapFocus

function mWindow:setVis(b)
    for i = 1, dim do
        for j = 1, dim do
            self.box[i][j]:setVisible(b)
        end -- for j
    end ---for j   
end

function mWindow:setValues()
    for i = 1, dim do
        for j = 1, dim do
            self.box[i][j]:setText(string.format("%3.3f", A[i][j]))
        end -- for j
    end -- for i        
end

function mWindow:getInput(res)
    for i = 1, dim do
        for j = 1, dim do
            if not self.box[i][j]:getText() then
                res[i][j] = 0
            else
                res[i][j] = math.eval(self.box[i][j]:getText())
                if type(res[i][j]) ~= "number" then
                    res[i][j] = nil
                end
            end
        end -- for j
    end -- for i       

end

function mWindow:setMessage(str)
    self.message = str
end
