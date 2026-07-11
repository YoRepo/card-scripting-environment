--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Tongue Twister  (ID: 91250514)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 6
-- ATK 400 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card was Tribute Summoned, when it is sent from the field to the Graveyard, draw 2 cards and
-- remove this card from play.
--[[ __CARD_HEADER_END__ ]]

--タン・ツイスター
function c91250514.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91250514,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c91250514.condition)
	e1:SetTarget(c91250514.target)
	e1:SetOperation(c91250514.operation)
	c:RegisterEffect(e1)
end
function c91250514.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c91250514.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function c91250514.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	Duel.BreakEffect()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
