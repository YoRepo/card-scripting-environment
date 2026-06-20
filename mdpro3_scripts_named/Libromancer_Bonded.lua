--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 书灵师再崛起  (ID: 41085464)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 380
--
-- Effect Text:
-- 「书灵师」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「书灵师」仪式怪兽仪式召唤。这个效果使用场上的「书灵师·炽火燃点侠」作仪式召唤的「书灵师·炽火爆裂侠」不会被
-- 效果破坏，不能用效果除外。
--[[ __CARD_HEADER_END__ ]]

--リブロマンサー・リライジング
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,45001322,88106656)
	--ritual summon
	aux.AddRitualProcGreater2(c,aux.FilterBoolFunction(Card.IsSetCard,0x17c),LOCATION_HAND,nil,nil,false,s.extraop)
end
function s.filter(c)
	return c:IsCode(45001322) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function s.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not (tc and tc:IsCode(88106656) and mat:IsExists(s.filter,1,nil)) then return end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(1)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_REMOVE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetTarget(s.rmlimit)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e2)
end
function s.rmlimit(e,c,tp,r,re)
	return c==e:GetHandler() and r&REASON_EFFECT>0
end
