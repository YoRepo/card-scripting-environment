--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 魔导杂货商人  (ID: 32362575)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Insect
-- Level 1
-- ATK 200 | DEF 700
-- Setcode: 110
--
-- Effect Text:
-- ①：这张卡反转的场合发动。直到魔法·陷阱卡出现为止从自己卡组上面翻卡，那张魔法·陷阱卡加入手卡。剩下的翻开的卡全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--魔導雑貨商人
function c32362575.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c32362575.operation)
	c:RegisterEffect(e1)
end
function c32362575.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_SPELL+TYPE_TRAP)
	local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if dcount==0 then return end
	if g:GetCount()==0 then
		Duel.ConfirmDecktop(tp,dcount)
		Duel.ShuffleDeck(tp)
		return
	end
	local seq=-1
	local tc=g:GetFirst()
	local spcard=nil
	while tc do
		if tc:GetSequence()>seq then
			seq=tc:GetSequence()
			spcard=tc
		end
		tc=g:GetNext()
	end
	Duel.ConfirmDecktop(tp,dcount-seq)
	if spcard:IsAbleToHand() then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(spcard,nil,REASON_EFFECT)
		Duel.DiscardDeck(tp,dcount-seq-1,REASON_EFFECT+REASON_REVEAL)
		Duel.ConfirmCards(1-tp,spcard)
		Duel.ShuffleHand(tp)
	else Duel.DiscardDeck(tp,dcount-seq,REASON_EFFECT+REASON_REVEAL) end
end
