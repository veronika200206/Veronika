#Горизонтальные перегородки в случайном порядке на поле. 
#Результат: робот в исх. клетке, посчитано кол-во перегородок
#4 вида задачи
# 1)Только Горизонтальные
#1)' 1 пропущенная клетка в перегородке не разрывает перегородку
# 2)И горизонтальные и вертикальные
# 3)Только прямоугольные
# 4)И прямоугольные и горизонтальные и вертикальные
using HorizonSideRobots
robot = Robot("starts/task11-12.sit",animate = true)


function num_borders!(robot)
    side = Ost
    N = 0
    n_nord,n_ost = topleft_and_count!(robot)
    while !isborder(robot,Nord) || !isborder(robot,Ost)
        N += num_borders!(robot,side)
        if !isborder(robot,Nord)
            move!(robot,Nord)
        end
        side = inverse(side)
    end
    topleft_and_count!(robot)
    goback!(robot,n_nord,n_ost)
    return N-1        
end


function num_borders!(robot,side)
    num_b = 0
    state = false #границы на предыдущем шаге не было
    while !isborder(robot,side)
            if isborder(robot,Nord) && state == false
                num_b += 1
                state = !state
            end
            if !isborder(robot,Nord)
                state = false
            end
            move!(robot,side)
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

function topleft_and_count!(robot::Robot)
    num_s_sud = num_s_west = 0
    while !isborder(robot, Sud) || !isborder(robot,West)
        num_s_sud += move_ifnoborder!(robot,Sud)
        num_s_west += move_ifnoborder!(robot,West)
    end
    return (num_s_sud, num_s_west)
end

function goback!(robot, n_nord, n_ost)
    for _ in range(0,n_nord-1)
        move!(robot, Nord)
    end
    for _ in range(0,n_nord-1)
        move!(robot,Ost)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

println(num_borders!(robot))