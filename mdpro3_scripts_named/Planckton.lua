--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 浮朗克尺度  (ID: 10282757)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：这个回合中，以下效果适用。
-- ●双方场上的全部3阶以下的超量怪兽的攻击力·守备力上升500。
-- ●双方场上的全部4阶以上的超量怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--プランクスケール
function c10282757.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c10282757.activate)
	c:RegisterEffect(e1)
end
function c10282757.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(500)
	e1:SetTarget(c10282757.filter1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetReset(RESET_PHASE+PHASE_END)
	e3:SetTarget(c10282757.filter2)
	Duel.RegisterEffect(e3,tp)
end
function c10282757.filter1(e,c)
	return c:IsType(TYPE_XYZ) and c:IsRankBelow(3)
end
function c10282757.filter2(e,c)
	return c:IsType(TYPE_XYZ) and c:IsRankAbove(4)
end
