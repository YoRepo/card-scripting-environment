--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 极星灵 暗精灵  (ID: 77060848)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Spellcaster
-- Level 5
-- ATK 1400 | DEF 1600
-- Setcode: 41026
--
-- Effect Text:
-- 这张卡召唤成功时，可以选择自己墓地存在的1只名字带有「极星」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--極星霊デックアールヴ
function c77060848.initial_effect(c)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77060848,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c77060848.thtg)
	e1:SetOperation(c77060848.thop)
	c:RegisterEffect(e1)
end
function c77060848.filter(c)
	return c:IsSetCard(0x42) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c77060848.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c77060848.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77060848.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c77060848.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c77060848.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
