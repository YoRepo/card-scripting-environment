--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Mind Trust  (ID: 38680149)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 1 Level 2 or higher monster.
-- Add 1 Tuner Monster from your Graveyard to your hand whose Level is less than or equal to half of
-- the Tributed monster's.
--[[ __CARD_HEADER_END__ ]]

--トラスト・マインド
function c38680149.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetLabel(0)
	e1:SetCost(c38680149.cost)
	e1:SetTarget(c38680149.target)
	e1:SetOperation(c38680149.activate)
	c:RegisterEffect(e1)
end
function c38680149.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c38680149.filter1(c,e,tp)
	local lv=math.floor(c:GetLevel()/2)
	return lv>0 and Duel.IsExistingTarget(c38680149.filter2,tp,LOCATION_GRAVE,0,1,nil,lv)
end
function c38680149.filter2(c,lv)
	return c:IsLevelBelow(lv) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c38680149.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c38680149.filter2(chkc,e:GetLabel()) end
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c38680149.filter1,1,nil,e,tp)
	end
	local rg=Duel.SelectReleaseGroup(tp,c38680149.filter1,1,1,nil,e,tp)
	local lv=math.floor(rg:GetFirst():GetLevel()/2)
	e:SetLabel(lv)
	Duel.Release(rg,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c38680149.filter2,tp,LOCATION_GRAVE,0,1,1,nil,lv)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c38680149.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
