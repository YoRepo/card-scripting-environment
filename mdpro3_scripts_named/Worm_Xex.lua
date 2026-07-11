--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Worm Xex  (ID: 11722335)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 4
-- ATK 1800 | DEF 1000
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned, you can send 1 Reptile-Type "Worm" monster from your Deck to the
-- Graveyard.
-- If you control a face-up "Worm Yagan", this card cannot be destroyed by battle.
--[[ __CARD_HEADER_END__ ]]

--ワーム・ゼクス
function c11722335.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11722335,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c11722335.target)
	e1:SetOperation(c11722335.operation)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c11722335.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c11722335.tgfilter(c)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE) and c:IsAbleToGrave()
end
function c11722335.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11722335.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c11722335.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c11722335.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c11722335.indfilter(c)
	return c:IsFaceup() and c:IsCode(47111934)
end
function c11722335.indcon(e)
	return Duel.IsExistingMatchingCard(c11722335.indfilter,e:GetOwnerPlayer(),LOCATION_MZONE,0,1,nil)
end
