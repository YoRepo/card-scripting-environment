--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Time Dimension Hole  (ID: 90615639)
-- Type: Trap
-- Setcode: 0x89
-- Scope: OCG
--
-- Effect Text:
-- Shuffle your Deck, then excavate the top card of your Deck, and if it is a monster that can be
-- Normal Summoned/Set, Special Summon it.
-- If it wasn't a monster, or couldn't be Special Summoned, place it on the top or bottom of the Deck.
-- You can only activate 1 "Time Dimension Hole" per turn.
--[[ __CARD_HEADER_END__ ]]

--タイム・ディメンションホール
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=1 end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<1 then return false end
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.DisableShuffleCheck()
	if tc:IsSummonableCard() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1
			and Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2))==1 then
			Duel.MoveSequence(tc,1)
		end
	end
end
