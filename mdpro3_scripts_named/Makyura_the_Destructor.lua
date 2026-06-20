--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 处刑人-摩休罗  (ID: 21593977)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1200
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡从怪兽区域送去墓地的场合才能发动。这个回合只有1次，自己可以把陷阱卡从手卡发动。
--[[ __CARD_HEADER_END__ ]]

--処刑人－マキュラ
function c21593977.initial_effect(c)
	--activate trap in hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,21593977)
	e1:SetCondition(c21593977.condition)
	e1:SetOperation(c21593977.operation)
	c:RegisterEffect(e1)
end
function c21593977.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE)
end
function c21593977.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21593977,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
