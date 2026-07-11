--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Limit Overdrive  (ID: 35014241)
-- Type: Spell / Quick-Play
-- Scope: OCG / TCG
--
-- Effect Text:
-- Return 1 Tuner Synchro Monster and 1 non-Tuner Synchro Monster you control to the Extra Deck;
-- Special Summon 1 Synchro Monster from your Extra Deck that has a Level equal to the combined Levels
-- the 2 monsters had on the field, ignoring its Summoning conditions.
-- You can only activate 1 "Limit Overdrive" per turn.
--[[ __CARD_HEADER_END__ ]]

--リミットオーバー・ドライブ
function c35014241.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,35014241+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c35014241.cost)
	e1:SetTarget(c35014241.target)
	e1:SetOperation(c35014241.activate)
	c:RegisterEffect(e1)
end
function c35014241.cfilter1(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsType(TYPE_TUNER) and c:IsAbleToExtraAsCost()
		and Duel.IsExistingMatchingCard(c35014241.cfilter2,tp,LOCATION_MZONE,0,1,nil,e,tp,c)
end
function c35014241.cfilter2(c,e,tp,tc)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and not c:IsType(TYPE_TUNER) and c:IsAbleToExtraAsCost()
		and Duel.IsExistingMatchingCard(c35014241.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetLevel()+tc:GetLevel(),Group.FromCards(c,tc))
end
function c35014241.spfilter(c,e,tp,lv,mg)
	return c:IsType(TYPE_SYNCHRO) and c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and Duel.GetLocationCountFromEx(tp,tp,mg,c)>0
end
function c35014241.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.IsExistingMatchingCard(c35014241.cfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,c35014241.cfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,c35014241.cfilter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp,g1:GetFirst())
	e:SetLabel(g1:GetFirst():GetLevel()+g2:GetFirst():GetLevel())
	g1:Merge(g2)
	Duel.SendtoDeck(g1,nil,SEQ_DECKTOP,REASON_COST)
end
function c35014241.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return true
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c35014241.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c35014241.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv,nil)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
