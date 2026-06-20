--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 通行税  (ID: 82003859)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方玩家若不支付500基本分，则不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--通行税
function c82003859.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attack cost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_ATTACK_COST)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetCost(c82003859.atcost)
	e2:SetOperation(c82003859.atop)
	c:RegisterEffect(e2)
	--accumulate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_FLAG_EFFECT+82003859)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	c:RegisterEffect(e3)
end
function c82003859.atcost(e,c,tp)
	local ct=Duel.GetFlagEffect(tp,82003859)
	return Duel.CheckLPCost(tp,ct*500)
end
function c82003859.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,500)
end
