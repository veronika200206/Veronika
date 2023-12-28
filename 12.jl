#Горизонтальные перегородки в случайном порядке на поле. 
#Результат: робот в исх. клетке, посчитано кол-во перегородок
#4 вида задачи
# 1)Только Горизонтальные
# 1)' 1 пропущенная клетка в перегородке не разрывает перегородку
# 2)И горизонтальные и вертикальные
# 3)Только прямоугольные
# 4)И прямоугольные и горизонтальные и вертикальные
using HorizonSideRobots
robot = Robot("starts/task11-12.sit",animate = true)

function num_borders!(robot::Robot)
    side = Ost
    N = 0
    n_nord,n_ost = goangle_and_count!(robot,Sud,West)
    while !isborder(robot,Nord) || !isborder(robot,Ost)
        N += num_borders!(robot,side,Nord)
        if !isborder(robot,Nord)
            move!(robot,Nord)
        end
        side = inverse(side)
    end
    goangle_and_count!(robot,Sud,West)
    goback!(robot,n_nord,n_ost)

    return N-1  
end

#=
state = 0 - на предыдущих двух шагах шаге перегородки не было => если есть на текущем +=1, statе = 1
state = 1 - на предыдущем шаге перегородка была => не прибавляем, проверяем есть ли на текущем, если есть state = 1
            если нет - state = 2
state = 2 - на предыдущем шаге перегородки не было, но была на предпредыдущем => не прибавляем, проверяем есть ли
            на текущем, если есть state = 1, если нет - state = 0
=#

function num_borders!(robot::Robot,move_side::HorizonSide,check_side::HorizonSide)
    num_b = 0
    state = 0 #границы на предыдущем шаге не было
    while !isborder(robot,move_side)
        if state == 0
            if isborder(robot,check_side)
                num_b += 1
                state = 1
            end
        elseif state == 1
            if isborder(robot,check_side)
                state = 1
            else
                state = 2
            end
        elseif state == 2
            if isborder(robot,check_side)
                state = 1
            else
                state = 0
            end
        end
        move!(robot,move_side)
    end
    return num_b
end

#=
is state = 0
    ....
elseif stste==1

elseif state==2

end

=#

function move_ifnoborder!(robot::Robot, side::HorizonSide)
    num_s  = 0
    while !isborder(robot,side)
        move!(robot,side)
        num_s += 1
    end
    return num_s
end

function goangle_and_count!(robot::Robot,side1::HorizonSide,side2::HorizonSide)
    num_s1 = num_s2 = 0
    while !isborder(robot, side1) || !isborder(robot,side2)
        num_s1 += move_ifnoborder!(robot,side1)
        num_s2 += move_ifnoborder!(robot,side2)
    end
    return (num_s1, num_s2)
end

function goback!(robot::Robot, n_1::Int, n_2::Int)
    for _ in range(0,n_1-1)
        move!(robot, Nord)
    end
    for _ in range(0,n_2-1)
        move!(robot,Ost)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

println(num_borders!(robot))