--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Justice Bringer  (ID: 26842483)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1700 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, when a Special Summoned monster your opponent controls activates its effect, you can
-- negate the activation.
--[[ __CARD_HEADER_END__ ]]

--ジャスティス・ブリンガー
function c26842483.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26842483,0))
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c26842483.condition)
	e1:SetTarget(c26842483.target)
	e1:SetOperation(c26842483.operation)
	c:RegisterEffect(e1)
end
function c26842483.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep~=tp and loc==LOCATION_MZONE and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
		and re:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c26842483.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c26842483.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
