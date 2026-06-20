--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 飞象  (ID: 88845345)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Beast
-- Level 2
-- ATK 500 | DEF 300
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以选择从游戏中除外的1只自己的3星以下的兽族·兽战士族·鸟兽族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--エレファン
function c88845345.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88845345,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c88845345.condition)
	e1:SetTarget(c88845345.target)
	e1:SetOperation(c88845345.operation)
	c:RegisterEffect(e1)
end
function c88845345.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c88845345.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(3) and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST) and c:IsAbleToHand()
end
function c88845345.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c88845345.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88845345.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c88845345.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c88845345.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
