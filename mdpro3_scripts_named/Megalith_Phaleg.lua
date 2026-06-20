--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 巨石遗物·富雷格  (ID: 63233638)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 2500 | DEF 1200
-- Setcode: 312
--
-- Effect Text:
-- 「巨石遗物」卡降临。这个卡名的①的效果1回合只能使用1次。
-- ①：把这张卡从手卡丢弃才能发动。等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「巨石遗物」仪式怪兽仪式召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的怪兽的攻击力·守备力上升自己墓地的仪式怪兽数量×300。
--[[ __CARD_HEADER_END__ ]]

--メガリス・ファレグ
function c63233638.initial_effect(c)
	c:EnableReviveLimit()
	--ritual summon
	local e1=aux.AddRitualProcGreater2(c,c63233638.filter,nil,nil,c63233638.matfilter,true)
	e1:SetDescription(aux.Stringid(63233638,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,63233638)
	e1:SetCost(c63233638.rscost)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c63233638.val)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c63233638.filter(c,e,tp,chk)
	return c:IsSetCard(0x138) and (not chk or c~=e:GetHandler())
end
function c63233638.matfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c63233638.rscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c63233638.cfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER)
end
function c63233638.val(e,c)
	return Duel.GetMatchingGroupCount(c63233638.cfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*300
end
