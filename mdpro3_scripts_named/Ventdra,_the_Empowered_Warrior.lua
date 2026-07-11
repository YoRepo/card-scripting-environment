--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ventdra, the Empowered Warrior  (ID: 93298460)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level: 5
-- ATK 2000 | DEF 800
-- Setcode: 0xca
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack your opponent directly.
-- If this card is sent from the field to the Graveyard: You can target 1 Dragon, Warrior, or
-- Spellcaster-Type Normal Monster in your Graveyard; add it to your hand.
--[[ __CARD_HEADER_END__ ]]

--魔装戦士 ヴァンドラ
function c93298460.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93298460,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c93298460.condition)
	e2:SetTarget(c93298460.target)
	e2:SetOperation(c93298460.operation)
	c:RegisterEffect(e2)
end
function c93298460.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c93298460.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsRace(RACE_DRAGON+RACE_WARRIOR+RACE_SPELLCASTER) and c:IsAbleToHand()
end
function c93298460.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c93298460.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c93298460.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c93298460.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c93298460.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
