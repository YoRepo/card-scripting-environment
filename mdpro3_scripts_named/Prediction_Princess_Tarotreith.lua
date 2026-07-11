--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Prediction Princess Tarotreith  (ID: 42932862)
-- Type: Monster / Effect / Ritual / Flip
-- Attribute: DARK
-- Race: Fairy
-- Level: 9
-- ATK 1200 | DEF 2700
-- Setcode: 0xcc
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Underworld Ritual of Prediction".
-- Must be Ritual Summoned, or Special Summoned with "Prediction Princess Tarotrei".
-- You can only use each effect of "Prediction Princess Tarotreith" once per turn.
-- (Quick Effect): You can activate 1 of these effects;
-- ● Flip any number of face-down monsters you control to face-up Defense Position.
-- ● Flip any number of face-up monsters you control to face-down Defense Position.
-- FLIP: You can Special Summon 1 Flip monster from your Deck in face-down Defense Position.
--[[ __CARD_HEADER_END__ ]]

--冥占術姫タロットレイス
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,8428836,94997874)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.ritlimit)
	c:RegisterEffect(e0)
	--Special Summon Flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--select position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_END_PHASE,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE+TIMING_STANDBY_PHASE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.postg)
	e2:SetOperation(s.posop)
	c:RegisterEffect(e2)
end
function s.spfilter(c,e,tp)
	return c:IsType(TYPE_FLIP) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function s.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,0,nil)
	local mg=Duel.GetMatchingGroup(s.posfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 or #mg>0 end
	local op=0
	if #g>0 and #mg>0 then
		op=Duel.SelectOption(tp,aux.Stringid(id,2),aux.Stringid(id,3))
	elseif #g>0 then
		op=Duel.SelectOption(tp,aux.Stringid(id,2))
	else
		op=Duel.SelectOption(tp,aux.Stringid(id,3))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_POSITION)
	else
		e:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,nil,1,0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,0,nil)
	local mg=Duel.GetMatchingGroup(s.posfilter,tp,LOCATION_MZONE,0,nil)
	if e:GetLabel()==0 then
		if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg=g:Select(tp,1,g:GetCount(),nil)
			if sg:GetCount()>0 then
				Duel.HintSelection(sg)
				Duel.ChangePosition(sg,POS_FACEUP_DEFENSE)
			end
		end
	else
		if mg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
			local sg1=mg:Select(tp,1,mg:GetCount(),nil)
			if sg1:GetCount()>0 then
				Duel.HintSelection(sg1)
				Duel.ChangePosition(sg1,POS_FACEDOWN_DEFENSE)
			end
		end
	end
end
