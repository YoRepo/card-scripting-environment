--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Utgarda, Generaider Boss of Delusion  (ID: 744887)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Rock
-- Level: 9
-- ATK 2200 | DEF 2700
-- Setcode: 0x134
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Utgarda, Generaider Boss of Delusion".
-- (Quick Effect): You can Tribute 2 "Generaider" monsters and/or Rock monsters, then target 1 card on
-- the field; banish it.
-- You can only use this effect of "Utgarda, Generaider Boss of Delusion" once per turn.
--[[ __CARD_HEADER_END__ ]]

--虚の王 ウートガルザ
function c744887.initial_effect(c)
	c:SetUniqueOnField(1,0,744887)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(744887,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,744887)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCost(c744887.rmcost)
	e1:SetTarget(c744887.rmtg)
	e1:SetOperation(c744887.rmop)
	c:RegisterEffect(e1)
end
function c744887.costfilter(c)
	return c:IsSetCard(0x134) or c:IsRace(RACE_ROCK)
end
function c744887.fselect(g,tp)
	return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,g)
		and Duel.CheckReleaseGroup(tp,aux.IsInGroup,#g,nil,g)
end
function c744887.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetReleaseGroup(tp):Filter(c744887.costfilter,nil)
	if chk==0 then return g:CheckSubGroup(c744887.fselect,2,2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=g:SelectSubGroup(tp,c744887.fselect,false,2,2,tp)
	aux.UseExtraReleaseCount(rg,tp)
	Duel.Release(rg,REASON_COST)
end
function c744887.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToRemove() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c744887.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
