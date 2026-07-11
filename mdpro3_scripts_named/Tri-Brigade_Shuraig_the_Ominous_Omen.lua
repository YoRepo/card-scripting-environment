--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Tri-Brigade Shuraig the Ominous Omen  (ID: 99726621)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Winged Beast
-- Link Rating: 4
-- Link Arrows: Left, Right, Bottom-Left, Bottom-Right
-- ATK 3000
-- Setcode: 0x14d
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2+ Beast, Beast-Warrior, and/or Winged Beast monsters
-- If this card is Special Summoned, or if another Beast, Beast-Warrior, or Winged Beast monster(s) is
-- Special Summoned to your field: You can banish 1 card on the field.
-- If this card is sent to the GY: You can add 1 Beast, Beast-Warrior, or Winged Beast monster from
-- your Deck to your hand, whose Level is less than or equal to the number of your banished Beast,
-- Beast-Warrior, and Winged Beast monsters.
-- You can only use each effect of "Tri-Brigade Shuraig the Ominous Omen" once per turn.
--[[ __CARD_HEADER_END__ ]]

--鉄獣戦線 凶鳥のシュライグ
function c99726621.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST),2,4)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99726621,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,99726621)
	e1:SetTarget(c99726621.rmtg)
	e1:SetOperation(c99726621.rmop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c99726621.rmcon)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(99726621,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,99726622)
	e3:SetTarget(c99726621.thtg)
	e3:SetOperation(c99726621.thop)
	c:RegisterEffect(e3)
end
function c99726621.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c99726621.rmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c99726621.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST) and c:IsControler(tp)
end
function c99726621.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c99726621.cfilter,1,nil,tp)
end
function c99726621.rfilter(c)
	return c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST) and c:IsFaceup()
end
function c99726621.thfilter(c,lv)
	return c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST) and c:IsAbleToHand() and c:IsLevelBelow(lv)
end
function c99726621.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c99726621.rfilter,tp,LOCATION_REMOVED,0,nil)
		return ct>0 and Duel.IsExistingMatchingCard(c99726621.thfilter,tp,LOCATION_DECK,0,1,nil,ct)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c99726621.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c99726621.rfilter,tp,LOCATION_REMOVED,0,nil)
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c99726621.thfilter,tp,LOCATION_DECK,0,1,1,nil,ct)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
