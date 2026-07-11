--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Guard Penguin  (ID: 99581584)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Winged Beast
-- Level: 4
-- ATK 0 | DEF 1200
-- Setcode: 0x5a
-- Scope: OCG / TCG
--
-- Effect Text:
-- When you take damage from a card effect (except during the Damage Step): You can Special Summon this
-- card from your hand, and if you do, gain LP equal to the damage you took.
--[[ __CARD_HEADER_END__ ]]

--ガード・ペンギン
function c99581584.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99581584,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c99581584.spcon)
	e1:SetTarget(c99581584.sptg)
	e1:SetOperation(c99581584.spop)
	c:RegisterEffect(e1)
end
function c99581584.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_EFFECT)~=0
end
function c99581584.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c99581584.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Recover(tp,ev,REASON_EFFECT)
	end
end
