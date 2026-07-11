--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Virtual World Mai-Hime - Lulu  (ID: 49088914)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Psychic
-- Level: 3
-- ATK 1600 | DEF 600
-- Setcode: 0x14e
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your hand: You can target 1 "Virtual World" card you control; send 1 "Virtual
-- World" card of a different type (Monster, Spell, Trap) from your Deck to the GY, and if you do,
-- Special Summon this card, then, you can add 1 "Virtual World" card of the third type from your Deck
-- to your hand, except "Virtual World Mai-Hime - Lulu".
-- For the rest of this turn, you can only Special Summon Level/Rank 3 or higher monsters.
-- You can only use this effect of "Virtual World Mai-Hime - Lulu" once per turn.
--[[ __CARD_HEADER_END__ ]]

--電脳堺媛－瑞々
function c49088914.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49088914,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,49088914)
	e1:SetTarget(c49088914.sptg)
	e1:SetOperation(c49088914.spop)
	c:RegisterEffect(e1)
end
function c49088914.tfilter(c,tp)
	local type1=c:GetType()&0x7
	return c:IsSetCard(0x14e) and c:IsFaceup() and Duel.IsExistingMatchingCard(c49088914.tgfilter,tp,LOCATION_DECK,0,1,nil,type1)
end
function c49088914.tgfilter(c,type1)
	return not c:IsType(type1) and c:IsSetCard(0x14e) and c:IsAbleToGrave()
end
function c49088914.thfilter(c,type1)
	return not c:IsType(type1) and c:IsSetCard(0x14e) and not c:IsCode(49088914) and c:IsAbleToHand()
end
function c49088914.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c49088914.tfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingTarget(c49088914.tfilter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c49088914.tfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c49088914.spop(e,tp,eg,ep,ev,re,r,rp)
	local c,tc=e:GetHandler(),Duel.GetFirstTarget()
	local type1=tc:GetType()&0x7
	if tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c49088914.tgfilter,tp,LOCATION_DECK,0,1,1,nil,type1)
		local tgc=g:GetFirst()
		if tgc and Duel.SendtoGrave(tgc,REASON_EFFECT)~=0 and tgc:IsLocation(LOCATION_GRAVE) and c:IsRelateToEffect(e)
			and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local type1=tgc:GetType()&0x7|type1
			local sg=Duel.GetMatchingGroup(c49088914.thfilter,tp,LOCATION_DECK,0,nil,type1)
			if #sg>0 and Duel.SelectYesNo(tp,aux.Stringid(49088914,1)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local hg=sg:Select(tp,1,1,nil)
				if #hg>0 then
					Duel.SendtoHand(hg,nil,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,hg)
				end
			end
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c49088914.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c49088914.splimit(e,c)
	return not (c:IsLevelAbove(3) or c:IsRankAbove(3))
end
