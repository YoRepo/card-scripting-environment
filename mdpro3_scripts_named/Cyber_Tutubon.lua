--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Cyber Tutubon  (ID: 42600274)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 5
-- ATK 1800 | DEF 1600
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Special Summon this card (from your hand) by Tributing 1 Warrior or Fairy-Type monster from
-- your hand or field.
-- If this card is Tributed for a Ritual Summon: You can target 1 Ritual Spell Card in your Graveyard;
-- add it to your hand.
--[[ __CARD_HEADER_END__ ]]

--サイバー・チュチュボン
function c42600274.initial_effect(c)
	--spsummon from hand
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetCondition(c42600274.hspcon)
	e1:SetTarget(c42600274.hsptg)
	e1:SetOperation(c42600274.hspop)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_RELEASE)
	e2:SetCondition(c42600274.thcon)
	e2:SetTarget(c42600274.thtg)
	e2:SetOperation(c42600274.thop)
	c:RegisterEffect(e2)
end
function c42600274.hspfilter(c,tp)
	return c:IsRace(RACE_WARRIOR+RACE_FAIRY) and c:IsControler(tp) and Duel.GetMZoneCount(tp,c)>0
end
function c42600274.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c42600274.hspfilter,1,REASON_SPSUMMON,true,e:GetHandler(),tp)
end
function c42600274.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,true,REASON_SPSUMMON):Filter(c42600274.hspfilter,c,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c42600274.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	c:RegisterFlagEffect(0,RESET_EVENT+0x4fc0000,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(42600274,0))
end
function c42600274.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_RITUAL)
end
function c42600274.thfilter(c)
	return c:GetType()==0x82 and c:IsAbleToHand()
end
function c42600274.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c42600274.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c42600274.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c42600274.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c42600274.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
