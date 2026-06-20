--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 木鳞龙的鳞片  (ID: 11813722)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有名字带有「自然」的怪兽表侧表示存在的场合才能发动。这个回合，对方不能把陷阱卡发动。
--[[ __CARD_HEADER_END__ ]]

--パルキオンのうろこ
function c11813722.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c11813722.condition)
	e1:SetOperation(c11813722.operation)
	c:RegisterEffect(e1)
end
function c11813722.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2a)
end
function c11813722.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c11813722.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c11813722.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c11813722.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c11813722.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
