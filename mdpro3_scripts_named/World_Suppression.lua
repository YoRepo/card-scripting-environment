--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 世界平定  (ID: 12253117)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 场地卡发动时才能发动。直到回合结束时场地卡的效果无效。
--[[ __CARD_HEADER_END__ ]]

--世界の平定
function c12253117.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c12253117.condition)
	e1:SetOperation(c12253117.activate)
	c:RegisterEffect(e1)
end
function c12253117.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_FIELD)
end
function c12253117.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c12253117.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c12253117.distarget(e,c)
	return c:IsType(TYPE_FIELD)
end
