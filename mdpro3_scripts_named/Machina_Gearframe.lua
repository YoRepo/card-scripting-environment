--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Machina Gearframe  (ID: 42940404)
-- Type: Monster / Effect / Union
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 0
-- Setcode: 0x36
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can add 1 "Machina" monster from your Deck to your hand,
-- except "Machina Gearframe".
-- Once per turn, you can either: Target 1 Machine monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- If the equipped monster would be destroyed by battle or card effect, destroy this card instead.
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・ギアフレーム
function c42940404.initial_effect(c)
	aux.EnableUnionAttribute(c,c42940404.filter)
	--search
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(42940404,2))
	e5:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetTarget(c42940404.stg)
	e5:SetOperation(c42940404.sop)
	c:RegisterEffect(e5)
end
function c42940404.filter(c)
	return c:IsRace(RACE_MACHINE)
end
function c42940404.sfilter(c)
	return c:IsSetCard(0x36) and not c:IsCode(42940404) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c42940404.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42940404.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c42940404.sop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c42940404.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
