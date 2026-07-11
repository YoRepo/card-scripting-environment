--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Future Glow  (ID: 64107820)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate this card by banishing 1 Psychic-Type monster from your Graveyard, and note its Level; all
-- Psychic-Type monsters you control gain ATK equal to that Level x 200.
--[[ __CARD_HEADER_END__ ]]

--フューチャー・グロウ
function c64107820.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c64107820.cost)
	e1:SetOperation(c64107820.operation)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PSYCHO))
	e2:SetValue(c64107820.val)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c64107820.cfilter(c)
	return c:IsRace(RACE_PSYCHO) and c:IsLevelAbove(1) and c:IsAbleToRemoveAsCost()
end
function c64107820.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c64107820.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c64107820.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetLevel()*200)
	e:GetLabelObject():SetLabel(0)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c64107820.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(e:GetLabel())
end
function c64107820.val(e,c)
	return e:GetLabel()
end
