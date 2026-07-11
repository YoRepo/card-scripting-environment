--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Sagitta, Maverick Fur Hire  (ID: 93738004)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 5
-- ATK 1200 | DEF 2400
-- Setcode: 0x114
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Special Summoned: You can inflict 500 damage to your opponent for each monster "Fur
-- Hire" you control with a different name, except "Sagitta, Maverick Fur Hire".
-- You can only use this effect of "Sagitta, Maverick Fur Hire" once per turn.
-- Your opponent cannot target monsters "Fur Hire" you control with card effects, except this one.
--[[ __CARD_HEADER_END__ ]]

--空牙団の孤高 サジータ
function c93738004.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93738004,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,93738004)
	e1:SetTarget(c93738004.damtg)
	e1:SetOperation(c93738004.damop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c93738004.tgtg)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
end
function c93738004.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x114) and not c:IsCode(93738004)
end
function c93738004.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93738004.damfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c93738004.damfilter,tp,LOCATION_MZONE,0,nil)
	local dam=g:GetClassCount(Card.GetCode)*500
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c93738004.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c93738004.damfilter,tp,LOCATION_MZONE,0,nil)
	local dam=g:GetClassCount(Card.GetCode)*500
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
function c93738004.tgtg(e,c)
	return c~=e:GetHandler() and c:IsSetCard(0x114)
end
