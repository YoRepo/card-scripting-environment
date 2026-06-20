--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 地龟的光藓  (ID: 74717840)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「自然」的怪兽表侧表示存在的场合才能发动。这个回合，对方的效果怪兽不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--ランドオルスのヒカリゴケ
function c74717840.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c74717840.condition)
	e1:SetOperation(c74717840.operation)
	c:RegisterEffect(e1)
end
function c74717840.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c74717840.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c74717840.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c74717840.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c74717840.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c74717840.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
