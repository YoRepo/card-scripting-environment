--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Eagle  (ID: 46241344)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1700
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Beast-Warrior monsters
-- You can only Special Summon "Brotherhood of the Fire Fist - Eagle(s)" once per turn.
-- You can activate "Fire Fist" monsters' effects without sending "Fire Fist" or "Fire Formation"
-- card(s) from your hand or field to the GY.
-- You can target 1 "Fire Formation" Spell/Trap you control or in your GY; return it to the hand, then
-- send 1 "Fire Fist" monster from your Deck to the GY.
-- You can only use this effect of "Brotherhood of the Fire Fist - Eagle" once per turn.
--[[ __CARD_HEADER_END__ ]]

--炎星仙－ワシンジン
function c46241344.initial_effect(c)
	c:SetSPSummonOnce(46241344)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_BEASTWARRIOR),2,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(46241344)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46241344,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,46241344)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c46241344.thtg)
	e2:SetOperation(c46241344.thop)
	c:RegisterEffect(e2)
end
function c46241344.thfilter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
		and (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE))
end
function c46241344.tgfilter(c)
	return c:IsSetCard(0x79) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c46241344.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_ONFIELD+LOCATION_GRAVE) and c46241344.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46241344.thfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(c46241344.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c46241344.thfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c46241344.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		local sg=Duel.GetMatchingGroup(c46241344.tgfilter,tp,LOCATION_DECK,0,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local tg=sg:Select(tp,1,1,nil)
			Duel.SendtoGrave(tg,REASON_EFFECT)
		end
	end
end
