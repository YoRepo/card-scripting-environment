--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Big Benkei  (ID: 3117804)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 1000 | DEF 3500
-- Setcode: 0x9a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Special Summoned: You can change its battle position. "Superheavy
-- Samurai" monsters you control can attack while in face-up Defense Position.
-- If they do, apply their DEF for damage calculation.
--[[ __CARD_HEADER_END__ ]]

--超重武者ビッグベン－K
function c3117804.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3117804,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetOperation(c3117804.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c3117804.atktg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c3117804.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
function c3117804.atktg(e,c)
	return c:IsSetCard(0x9a)
end
