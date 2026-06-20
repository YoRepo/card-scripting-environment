--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电极兽 阳离子  (ID: 21291696)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 2
-- ATK 300 | DEF 100
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤的场合才能发动。从自己的卡组·墓地把1只「电极兽 阴离子」加入手卡。那之后，可以进行1只4星以下的雷族怪兽的召唤。这个效果的发动后，直到回合结束时自己不是光属性超量怪兽不能从额外卡组特殊
-- 召唤。
-- ②：以自己场上1只其他的雷族怪兽为对象才能发动。这张卡的等级直到回合结束时变成和那只怪兽的等级相同。
--[[ __CARD_HEADER_END__ ]]

--電極獣カチオン
function c21291696.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21291696,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,21291696)
	e1:SetTarget(c21291696.thtg)
	e1:SetOperation(c21291696.thop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21291696,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,21291696+1)
	e2:SetTarget(c21291696.lvtg)
	e2:SetOperation(c21291696.lvop)
	c:RegisterEffect(e2)
end
function c21291696.thfilter(c)
	return c:IsCode(58680635) and c:IsAbleToHand()
end
function c21291696.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21291696.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c21291696.sumfilter(c)
	return c:IsSummonable(true,nil) and c:IsRace(RACE_THUNDER) and c:IsLevelBelow(4)
end
function c21291696.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c21291696.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleHand(tp)
		if Duel.IsExistingMatchingCard(c21291696.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(21291696,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
			local sg=Duel.SelectMatchingCard(tp,c21291696.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
			if sg:GetCount()>0 then
				Duel.Summon(tp,sg:GetFirst(),true,nil)
			end
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c21291696.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c21291696.splimit(e,c)
	return not (c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_LIGHT)) and c:IsLocation(LOCATION_EXTRA)
end
function c21291696.lvfilter(c,lv)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER) and not c:IsLevel(lv) and c:IsLevelAbove(1)
end
function c21291696.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local lv=e:GetHandler():GetLevel()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c21291696.lvfilter(chkc,lv) end
	if chk==0 then return Duel.IsExistingTarget(c21291696.lvfilter,tp,LOCATION_MZONE,0,1,nil,lv) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c21291696.lvfilter,tp,LOCATION_MZONE,0,1,1,nil,lv)
end
function c21291696.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
