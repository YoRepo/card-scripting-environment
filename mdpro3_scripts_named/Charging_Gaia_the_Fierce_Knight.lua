--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Charging Gaia the Fierce Knight  (ID: 7841921)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 7
-- ATK 2300 | DEF 2100
-- Setcode: 0xbd
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Normal Summon this card without Tributing.
-- If this card is Normal Summoned without Tributing, its original ATK becomes 1900.
-- If this card is Tributed: You can add 1 "Black Luster Soldier" monster from your Deck to your hand.
-- You can only use this effect of "Charging Gaia the Fierce Knight" once per turn.
--[[ __CARD_HEADER_END__ ]]

--疾走の暗黒騎士ガイア
function c7841921.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7841921,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c7841921.ntcon)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_COST)
	e2:SetOperation(c7841921.atkop)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_RELEASE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,7841921)
	e3:SetTarget(c7841921.thtg)
	e3:SetOperation(c7841921.thop)
	c:RegisterEffect(e3)
end
function c7841921.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c7841921.atkcon(e)
	return e:GetHandler():GetMaterialCount()==0
end
function c7841921.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetCondition(c7841921.atkcon)
	e1:SetValue(1900)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c7841921.thfilter(c)
	return c:IsSetCard(0x10cf) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c7841921.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7841921.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c7841921.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c7841921.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
